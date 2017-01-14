#import "BTDropInController.h"
#import "BTVaultManagementViewController.h"
#import "BTCardFormViewController.h"
#import "BTEnrollmentVerificationViewController.h"
#if __has_include("BraintreeCard.h")
#import "BTAPIClient_Internal.h"
#import "BraintreeCard.h"
#import "BraintreeUnionPay.h"
#else
#import <BraintreeCore/BTAPIClient_Internal.h>
#import <BraintreeCard/BraintreeCard.h>
#import <BraintreeUnionPay.h>
#endif

#define BT_ANIMATION_SLIDE_SPEED 0.35
#define BT_ANIMATION_TRANSITION_SPEED 0.1
#define BT_HALF_SHEET_HEIGHT 410

@interface BTDropInController ()

@property (nonatomic, strong) BTConfiguration *configuration;
@property (nonatomic, strong, readwrite) BTAPIClient *apiClient;
@property (nonatomic, strong) UIToolbar *btToolbar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *contentClippingView;
@property (nonatomic, strong) BTVaultManagementViewController *vaultManagementViewController;
@property (nonatomic, strong) BTPaymentSelectionViewController *paymentSelectionViewController;
@property (nonatomic, strong) BTCardFormViewController *cardFormViewController;
@property (nonatomic, strong) NSLayoutConstraint *contentHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentHeightConstraintBottom;
@property (nonatomic) BOOL isFullScreen;
@property (nonatomic) BOOL wantsFullScreen;
@property (nonatomic) BOOL useBlur;
@property (nonatomic, strong) UIVisualEffectView *blurredBackgroundView;
@property (nonatomic, copy, nullable) BTDropInControllerHandler handler;

@end

@implementation BTDropInController

#pragma mark - Prefetch BTDropInResult

+ (void)fetchDropInResultForAuthorization:(NSString *)authorization handler:(BTDropInControllerFetchHandler)handler {
    BTUIKPaymentOptionType lastSelectedPaymentOptionType = [[NSUserDefaults standardUserDefaults] integerForKey:@"BT_dropInLastSelectedPaymentMethodType"];
    __block BTAPIClient *apiClient = [[BTAPIClient alloc] initWithAuthorization:authorization];
    apiClient = [apiClient copyWithSource:apiClient.metadata.source integration:BTClientMetadataIntegrationDropIn2];

    
    [apiClient fetchPaymentMethodNonces:NO completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
                                       if (error != nil) {
                                           handler(nil, error);
                                       } else {
                                           BTDropInResult *result = [BTDropInResult new];
                                           if (lastSelectedPaymentOptionType == BTUIKPaymentOptionTypeApplePay) {
                                               result.paymentOptionType = lastSelectedPaymentOptionType;
                                           } else if (paymentMethodNonces != nil && paymentMethodNonces.count > 0) {
                                               BTPaymentMethodNonce *paymentMethod = paymentMethodNonces.firstObject;
                                               result.paymentOptionType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:paymentMethod.type];
                                               result.paymentMethod = paymentMethod;
                                           }
                                           handler(result, error);
                                       }
                                       apiClient = nil;
                                   }];
}

#pragma mark - Lifecycle

- (nullable instancetype)initWithAuthorization:(NSString *)authorization
                                       request:(BTDropInRequest *)request
                                       handler:(BTDropInControllerHandler) handler {
    if (self = [super init]) {
        BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:authorization];
        self.apiClient = [client copyWithSource:client.metadata.source integration:BTClientMetadataIntegrationDropIn2];

        _dropInRequest = [request copy];
        if (!_apiClient || !_dropInRequest) {
            return nil;
        }
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.modalPresentationStyle = UIModalPresentationFormSheet;
            // Customize the iPad size...
            // self.preferredContentSize = CGSizeMake(600, 400);
        } else {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        }
        
        self.useBlur = !UIAccessibilityIsReduceTransparencyEnabled();
        if (![BTUIKAppearance sharedInstance].useBlurs) {
            self.useBlur = NO;
        }
        self.handler = handler;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self setUpChildViewControllers];
    [self setUpConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isBeingPresented) {
        [self.paymentSelectionViewController showLoadingScreen:YES animated:NO];
        [self.paymentSelectionViewController loadConfiguration];
        
        [self.cardFormViewController resetForm];
        [self.cardFormViewController showLoadingScreen:YES animated:NO];
        [self.cardFormViewController loadConfiguration];
        
        [self resetDropInState];
        [self loadConfiguration];
        if ([self isFormSheet]) {
            // Position the views in screen before appearing
            [self flexViewToFullScreenIfPossible:true animated:NO];
        } else {
            // Move content off screen so it can be animated in when it appears
            CGFloat sh = CGRectGetHeight([[UIScreen mainScreen] bounds]) + [UIApplication sharedApplication].statusBarFrame.size.height;
            self.contentHeightConstraintBottom.constant = sh;
            self.contentHeightConstraint.constant = sh;
            [self.view setNeedsUpdateConstraints];
            [self.view layoutIfNeeded];
        }
    } else {
        [self flexViewToFullScreenIfPossible:self.wantsFullScreen animated:NO];
        [self.view setNeedsDisplay];
    }
    [self.apiClient sendAnalyticsEvent:@"ios.dropin2.appear"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![self isFormSheet] && self.isBeingPresented) {
        [self flexViewToFullScreenIfPossible:false animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.apiClient sendAnalyticsEvent:@"ios.dropin2.disappear"];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    // before rotating
    [coordinator animateAlongsideTransition:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        // while rotating
        if (self.view.window != nil && !self.isBeingDismissed) {
            [self flexViewToFullScreenIfPossible:self.wantsFullScreen animated:NO];
            [self.view setNeedsDisplay];
            [self.view setNeedsLayout];
        }
    } completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        // after rotating
    }];
}

#pragma mark - Setup

- (void)setUpViews {
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[BTDropInController.self]] setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].tintColor, NSFontAttributeName:[UIFont fontWithName:[BTUIKAppearance sharedInstance].fontFamily size:[UIFont labelFontSize]]} forState:UIControlStateNormal];
    if ([BTUIKAppearance sharedInstance].tintColor != nil) {
        self.view.tintColor = [BTUIKAppearance sharedInstance].tintColor;
    }
    self.view.opaque = NO;
    self.view.backgroundColor = self.useBlur ? [UIColor clearColor] : [BTUIKAppearance sharedInstance].overlayColor;
    self.view.userInteractionEnabled = YES;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:[BTUIKAppearance sharedInstance].blurStyle];
    self.blurredBackgroundView = [[UIVisualEffectView alloc] initWithEffect:effect];
    self.blurredBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.useBlur) {
        [self.view addSubview:self.blurredBackgroundView];
    }
    
    self.contentView = [[UIView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.backgroundColor = [UIColor clearColor];
    if (self.useBlur) {
        [self.blurredBackgroundView.contentView addSubview: self.contentView];
    } else {
        [self.view addSubview: self.contentView];
    }
    
    self.contentClippingView = [[UIView alloc] init];
    self.contentClippingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: self.contentClippingView];
    self.contentClippingView.backgroundColor = [BTUIKAppearance sharedInstance].sheetBackgroundColor;
    self.contentClippingView.clipsToBounds = true;
    
    self.btToolbar = [[UIToolbar alloc] init];
    self.btToolbar.delegate = self;
    self.btToolbar.userInteractionEnabled = YES;
    self.btToolbar.barStyle = UIBarStyleDefault;
    self.btToolbar.barTintColor = [BTUIKAppearance sharedInstance].barBackgroundColor;
    self.btToolbar.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.btToolbar];
}

- (void)setUpChildViewControllers {
    self.vaultManagementViewController = [[BTVaultManagementViewController alloc] initWithAPIClient:self.apiClient request:self.dropInRequest];
    [self.contentClippingView addSubview:self.vaultManagementViewController.view];
    self.vaultManagementViewController.view.hidden = YES;
    
    self.paymentSelectionViewController = [[BTPaymentSelectionViewController alloc] initWithAPIClient:self.apiClient request:self.dropInRequest];
    self.paymentSelectionViewController.delegate = self;
    [self.contentClippingView addSubview:self.paymentSelectionViewController.view];
    self.paymentSelectionViewController.view.hidden = YES;
    self.paymentSelectionViewController.navigationItem.leftBarButtonItem.target = self;
    self.paymentSelectionViewController.navigationItem.leftBarButtonItem.action = @selector(cancelHit:);
    
    self.cardFormViewController = [[BTCardFormViewController alloc] initWithAPIClient:self.apiClient request:self.dropInRequest];
    self.cardFormViewController.delegate = self;
    [self.contentClippingView addSubview:self.cardFormViewController.view];
    self.cardFormViewController.view.hidden = YES;
}

- (void)setUpConstraints {
    NSDictionary *viewBindings = @{
                                   @"view": self,
                                   @"toolbar": self.btToolbar,
                                   @"contentView": self.contentView,
                                   @"vaultManagementViewController":self.vaultManagementViewController.view,
                                   @"contentClippingView":self.contentClippingView,
                                   @"paymentSelectionViewController":self.paymentSelectionViewController.view,
                                   @"cardFormViewController":self.cardFormViewController.view,
                                   @"blurredBackgroundView":self.blurredBackgroundView
                                   };
    NSDictionary *metrics = @{};
    
    if (self.useBlur) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurredBackgroundView]|"
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:viewBindings]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurredBackgroundView]|"
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:viewBindings]];
    }
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    
    self.contentHeightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self.view addConstraint:self.contentHeightConstraint];
    
    self.contentHeightConstraintBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraint:self.contentHeightConstraintBottom];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[vaultManagementViewController]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[paymentSelectionViewController]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cardFormViewController]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[paymentSelectionViewController]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[vaultManagementViewController]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cardFormViewController]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self applyContentViewConstraints];
}

- (void)loadConfiguration {
    [self.apiClient fetchOrReturnRemoteConfiguration:^(BTConfiguration * _Nullable configuration, NSError * _Nullable error) {
        self.configuration = configuration;
        if (!error) {
            self.paymentSelectionViewController.view.hidden = NO;
            self.paymentSelectionViewController.view.alpha = 1.0;
            [self updateToolbarForViewController:self.paymentSelectionViewController];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription ?: @"Connection Error" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * __unused _Nonnull action) {
                if (self.handler) {
                    self.handler(self, nil, error);
                }
            }];
            [alertController addAction: alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

#pragma mark - View management and actions

- (void)cancelHit:(__unused id)sender {
    BTDropInResult *result = [[BTDropInResult alloc] init];
    result.cancelled = YES;
    if (self.handler) {
        self.handler(self, result, nil);
    }
}

- (void)completeTokenizeCard:(BTPaymentMethodNonce *)tokenizedCard error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.handler) {
            BTDropInResult *result = [[BTDropInResult alloc] init];
            if (tokenizedCard != nil) {
                result.paymentOptionType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:tokenizedCard.type];
                result.paymentMethod = tokenizedCard;
            }
            self.handler(self, result, error);
        }
    });
}

- (void)tokenizeCard:(__unused id)sender {
    [self.view endEditing:YES];
    __block BTCardRequest *cardRequest = self.cardFormViewController.cardRequest;
    __block BTCardClient *cardClient = [[BTCardClient alloc] initWithAPIClient:self.apiClient];
    
    void (^basicTokenizeBlock)() = ^void() {
        UIActivityIndicatorView *spinner = [UIActivityIndicatorView new];
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [spinner startAnimating];
        
        NSArray *originalToolbarItems = self.btToolbar.items;
        NSMutableArray *newToolbarItems = [self.btToolbar.items mutableCopy];
        [newToolbarItems removeLastObject];
        [newToolbarItems addObject:[[UIBarButtonItem alloc] initWithCustomView:spinner]];
        [self.btToolbar setItems:newToolbarItems animated:NO];
        self.view.userInteractionEnabled = NO;
        
        [cardClient tokenizeCard:cardRequest options:nil completion:^(BTCardNonce * _Nullable tokenizedCard, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.view.userInteractionEnabled = YES;
                [self.btToolbar setItems:originalToolbarItems animated:NO];

                if (self.dropInRequest.threeDSecureVerification && self.dropInRequest.amount != nil
                    && [self.configuration.json[@"threeDSecureEnabled"] isTrue] && [[BTTokenizationService sharedService] isTypeAvailable:@"ThreeDSecure"]) {

                    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
                    options[BTTokenizationServiceViewPresentingDelegateOption] = self;
                    options[BTTokenizationServiceAmountOption] = [[NSDecimalNumber alloc] initWithString:self.dropInRequest.amount];
                    options[BTTokenizationServiceNonceOption] = tokenizedCard.nonce;

                    [[BTTokenizationService sharedService] tokenizeType:@"ThreeDSecure" options:options withAPIClient:self.apiClient completion:^(BTPaymentMethodNonce * _Nullable tokenizedCard, NSError * _Nullable error) {
                        [self completeTokenizeCard:tokenizedCard error:error];
                    }];

                } else {
                    [self completeTokenizeCard:tokenizedCard error:error];
                }
            });
        }];
    };
    
    if (self.cardFormViewController.cardCapabilities != nil && self.cardFormViewController.cardCapabilities.isUnionPay && self.cardFormViewController.cardCapabilities.isSupported) {
        [cardClient enrollCard:cardRequest completion:^(NSString * _Nullable enrollmentID, BOOL smsCodeRequired, NSError * _Nullable error) {
            if (error) {
                self.handler(self, nil, error);
                return;
            }
            
            cardRequest.enrollmentID = enrollmentID;
            
            if (!smsCodeRequired) {
                basicTokenizeBlock();
                return;
            }

            __block UINavigationController *navController;
            __block BTEnrollmentVerificationViewController *enrollmentController;
            enrollmentController = [[BTEnrollmentVerificationViewController alloc] initWithPhone:self.cardFormViewController.mobilePhoneField.mobileNumber mobileCountryCode:self.cardFormViewController.mobileCountryCodeField.countryCode handler:^(NSString* authCode, BOOL resend) {
                
                if (resend) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // If user elects to resend, show a prompt asking them to verify the card form information and try again
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Resend SMS" message:@"Double check your mobile information and try again." preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction * _Nonnull action) {
                            [navController dismissViewControllerAnimated:NO completion:nil];
                        }];
                        [alertController addAction: alertAction];
                        [navController presentViewController:alertController animated:YES completion:nil];
                    });
                    return;
                }
                
                __block UIBarButtonItem *originalRightBarButtonItem = enrollmentController.navigationItem.rightBarButtonItem;
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIActivityIndicatorView *spinner = [UIActivityIndicatorView new];
                    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                    [spinner startAnimating];

                    enrollmentController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
                    self.view.userInteractionEnabled = NO;
                });

                cardRequest.smsCode = authCode;
                [cardClient tokenizeCard:cardRequest options:nil completion:^(BTCardNonce * _Nullable tokenizedCard, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.view.userInteractionEnabled = YES;
                        enrollmentController.navigationItem.rightBarButtonItem = originalRightBarButtonItem;
                        if (self.handler) {
                            if (error) {
                                // When tokenization fails for UnionPay, Drop-In will not report the error back but will instead display an alert
                                // And return to the card form
                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Validating" message:@"Unable to verify card. Double check your information and try again." preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction * _Nonnull action) {
                                    [navController dismissViewControllerAnimated:NO completion:nil];
                                }];
                                [alertController addAction: alertAction];
                                [navController presentViewController:alertController animated:YES completion:nil];
                                return;
                            }

                            [navController dismissViewControllerAnimated:NO completion:^{
                                [self completeTokenizeCard:tokenizedCard error:error];
                            }];
                        }
                    });
                }];
            }];

            navController = [[UINavigationController alloc] initWithRootViewController:enrollmentController];
            navController.modalPresentationStyle = UIModalPresentationCurrentContext;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:navController animated:YES completion:^{
                    BTJSON *environment = self.configuration.json[@"environment"];
                    if(![environment isError] && [[environment asString] isEqualToString:@"sandbox"]) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sandbox Sample SMS Code" message:@"Any code passes, example: 12345 \n\nTest incorrect code is: 999999" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction: alertAction];
                        [navController presentViewController:alertController animated:YES completion:nil];
                    }
                }];
            });
        }];
        return;
    }
    basicTokenizeBlock();
}

- (void)updateToolbarForViewController:(UIViewController*)viewController {
    UILabel *titleLabel = [[UILabel alloc] init];
    [BTUIKAppearance styleLabelPrimary:titleLabel];
    titleLabel.text = viewController.title ? viewController.title : @"";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    UIBarButtonItem *barTitle = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *leftItem = viewController.navigationItem.leftBarButtonItem ? viewController.navigationItem.leftBarButtonItem : fixed;
    UIBarButtonItem *rightItem = viewController.navigationItem.rightBarButtonItem ? viewController.navigationItem.rightBarButtonItem : fixed;
    [self.btToolbar setItems:@[leftItem, flex, barTitle, flex, rightItem] animated:YES];
}

- (void)showCardForm:(__unused id)sender {
    [self animateToViewController:self.cardFormViewController animateForward:false];
    [self updateToolbarForViewController:self.cardFormViewController];
}

- (void)showPaymentSelection:(__unused id)sender {
    [self animateToViewController:self.paymentSelectionViewController animateForward:true];
    [self updateToolbarForViewController:self.paymentSelectionViewController];
}

- (void)showVaultManagement:(__unused id)sender {
    [self animateToViewController:self.vaultManagementViewController animateForward:false];
    [self updateToolbarForViewController:self.vaultManagementViewController];
}

- (void)animateToViewController:(UIViewController*)destinationViewController animateForward:(__unused BOOL)animateForward {
    if (!destinationViewController.view.hidden) {
        return;
    }
    
    UIView *viewToHide = [self visibleViewController].view;
    [viewToHide endEditing:YES];
    UIView *viewToReveal = destinationViewController.view;
    viewToReveal.hidden = NO;
    viewToReveal.alpha = 0.0;
    
    [UIView animateWithDuration:BT_ANIMATION_TRANSITION_SPEED
                          delay:0
                        options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         viewToReveal.alpha = 1.0;
                         viewToHide.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             viewToHide.hidden = YES;
                         }
                     }
     ];
    
    [self flexViewToFullScreenIfPossible:(destinationViewController == self.vaultManagementViewController || destinationViewController == self.cardFormViewController) animated:true];
}

#pragma mark - UI Helpers

- (UIViewController *)visibleViewController {
    if (!self.paymentSelectionViewController.view.hidden) {
        return self.paymentSelectionViewController;
    } else if (!self.vaultManagementViewController.view.hidden) {
        return self.vaultManagementViewController;
    } else {
        return self.cardFormViewController;
    }
}

- (void)flexViewToFullScreenIfPossible:(BOOL)fullscreen animated:(BOOL)animated{
    self.wantsFullScreen = fullscreen;
    self.isFullScreen = [self supportsHalfSheet] && ![self isFormSheet] ? fullscreen : true;
    [self.btToolbar removeFromSuperview];
    [self.contentView addSubview:self.btToolbar];
    
    
    if ([self isFormSheet]) {
        // iPad formSheet
        self.contentHeightConstraint.constant = 0;
    } else {
        // Flexible views
        int statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        int sh = [[UIScreen mainScreen] bounds].size.height;
        int sheetHeight = BT_HALF_SHEET_HEIGHT;
        self.contentHeightConstraint.constant = self.isFullScreen ? statusBarHeight : (sh - sheetHeight);
    }
    
    [self applyContentViewConstraints];
    
    [self.view setNeedsUpdateConstraints];

    self.contentHeightConstraintBottom.constant = 0;

    if (animated) {
        [UIView animateWithDuration:BT_ANIMATION_SLIDE_SPEED delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:4 options:0 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    } else {
        [self.view updateConstraints];
        [self.view layoutIfNeeded];
    }
}

- (void)applyContentViewConstraints {
    NSDictionary *viewBindings = @{@"toolbar": self.btToolbar,
                                   @"contentClippingView": self.contentClippingView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolbar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentClippingView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[toolbar][contentClippingView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewBindings]];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        // No iPad specific dismissal animation
    } else {
        CGFloat sh = CGRectGetHeight([[UIScreen mainScreen] bounds]);
        self.contentHeightConstraintBottom.constant = sh;
        self.contentHeightConstraint.constant = sh;
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:BT_ANIMATION_SLIDE_SPEED animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)resetDropInState {
    self.configuration = nil;
    self.vaultManagementViewController.view.hidden = YES;
    self.vaultManagementViewController.view.alpha = 1.0;
    self.cardFormViewController.view.hidden = YES;
    self.cardFormViewController.view.alpha = 1.0;
    self.paymentSelectionViewController.view.hidden = NO;
    self.paymentSelectionViewController.view.alpha = 1.0;
    self.cardFormViewController.navigationItem.leftBarButtonItem.target = self;
    self.cardFormViewController.navigationItem.leftBarButtonItem.action = @selector(showPaymentSelection:);
    self.cardFormViewController.navigationItem.rightBarButtonItem.target = self;
    self.cardFormViewController.navigationItem.rightBarButtonItem.action = @selector(tokenizeCard:);
}

// No fullscreen when in landscape or FormSheet modes.
- (BOOL)supportsHalfSheet {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight || [self isFormSheet]) {
        return false;
    }
    return true;
}

- (BOOL)isFormSheet {
    return self.modalPresentationStyle == UIModalPresentationFormSheet;
}

#pragma mark - UI Preferences

- (BOOL)prefersStatusBarHidden {
    if (self.presentingViewController != nil) {
        return [self.presentingViewController prefersStatusBarHidden];
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.presentingViewController != nil) {
        return [self.presentingViewController preferredStatusBarStyle];
    }
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    if (bar == self.btToolbar && self.isFullScreen && ![self isFormSheet]) {
        return UIBarPositionTopAttached;
    }
    return UIBarPositionTop;
}

#pragma mark BTAppSwitchDelegate

- (void)appSwitcherWillPerformAppSwitch:(__unused id)appSwitcher {
    // No action
}

- (void)appSwitcherWillProcessPaymentInfo:(__unused id)appSwitcher {
    // No action
}

- (void)appSwitcher:(__unused id)appSwitcher didPerformSwitchToTarget:(__unused BTAppSwitchTarget)target {
    // No action
}

- (void)paymentDriver:(__unused id)driver requestsPresentationOfViewController:(UIViewController *)viewController {
    // Needed for iPad
    viewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)paymentDriver:(__unused id)driver requestsDismissalOfViewController:(UIViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectionCompletedWithPaymentMethodType:(BTUIKPaymentOptionType)type nonce:(BTPaymentMethodNonce *)nonce error:(NSError *)error {
    if (error == nil) {
        [[NSUserDefaults standardUserDefaults] setInteger:type forKey:@"BT_dropInLastSelectedPaymentMethodType"];
        if (self.handler != nil) {
            BTDropInResult *result = [BTDropInResult new];
            result.paymentOptionType = type;
            result.paymentMethod = nonce;
            self.handler(self, result, error);
        }
    }
}

@end
