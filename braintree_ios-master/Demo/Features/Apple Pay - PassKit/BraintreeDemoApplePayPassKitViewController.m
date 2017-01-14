#import "BraintreeDemoApplePayPassKitViewController.h"
#import "BraintreeDemoSettings.h"
#import <BraintreeApplePay/BraintreeApplePay.h>
#import <PureLayout/PureLayout.h>

@import PassKit;

@interface BraintreeDemoApplePayPassKitViewController () <PKPaymentAuthorizationViewControllerDelegate>
@property (nonatomic, strong) UILabel *label;
@end

@implementation BraintreeDemoApplePayPassKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 1;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];

    [self.label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.paymentButton];
    [self.label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.paymentButton withOffset:8];
    [self.label autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.label autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.label autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];

    self.title = @"Apple Pay via PassKit";
}

- (UIControl *)createPaymentButton {
    if (![PKPaymentAuthorizationViewController class]) {
        self.progressBlock(@"Apple Pay is not available on this version of iOS");
        return nil;
    }
    if (![PKPaymentAuthorizationViewController canMakePayments]) {
        self.progressBlock(@"canMakePayments returns NO, hiding Apple Pay button");
        return nil;
    }

    // Discover and PrivateLabel were added in iOS 9.0
    // At this time, we have not tested these options
    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa]]) {
        self.progressBlock(@"canMakePaymentsUsingNetworks: returns NO, hiding Apple Pay button");
        return nil;
    }

    UIButton *button;
    BOOL pkPaymentButtonAvailable = NO;

    // When compiling with an iOS 8.3 or higher SDK, we can check for
    // the PKPaymentButton, which was added in iOS 8.3. Note that we
    // still need to check, because the deployment target may be < 8.3
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80300
    pkPaymentButtonAvailable = [PKPaymentButton class] != nil;
    if (pkPaymentButtonAvailable) {
        button = [PKPaymentButton buttonWithType:PKPaymentButtonTypePlain style:PKPaymentButtonStyleBlack];
    }
#endif
    // If we're compiling with an older version of the iOS SDK (very rare),
    // we should not use the `PKPaymentButton` at all - not even to check
    // whether it's available.
    if (pkPaymentButtonAvailable == NO) {
        // Create a custom button
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTintColor:[UIColor blackColor]];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:36]];
        [button setTitle:@"PAY WITH APPLE PAY" forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(tappedApplePayButton) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)tappedApplePayButton {
    self.progressBlock(@"Constructing PKPaymentRequest");

    PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];

    // Requiring PKAddressFieldPostalAddress crashes Simulator
    //paymentRequest.requiredBillingAddressFields = PKAddressFieldName|PKAddressFieldPostalAddress;
    paymentRequest.requiredBillingAddressFields = PKAddressFieldName;

    PKShippingMethod *shippingMethod1 = [PKShippingMethod summaryItemWithLabel:@"✈️ Fast Shipping" amount:[NSDecimalNumber decimalNumberWithString:@"4.99"]];
    shippingMethod1.detail = @"Fast but expensive";
    shippingMethod1.identifier = @"fast";
    PKShippingMethod *shippingMethod2 = [PKShippingMethod summaryItemWithLabel:@"🐢 Slow Shipping" amount:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    shippingMethod2.detail = @"Slow but free";
    shippingMethod2.identifier = @"slow";
    PKShippingMethod *shippingMethod3 = [PKShippingMethod summaryItemWithLabel:@"💣 Unavailable Shipping" amount:[NSDecimalNumber decimalNumberWithString:@"0xdeadbeef"]];
    shippingMethod3.detail = @"It will make Apple Pay fail";
    shippingMethod3.identifier = @"fail";
    paymentRequest.shippingMethods = @[shippingMethod1, shippingMethod2, shippingMethod3];
    paymentRequest.requiredShippingAddressFields = PKAddressFieldAll;
    paymentRequest.paymentSummaryItems = @[
                                           [PKPaymentSummaryItem summaryItemWithLabel:@"SOME ITEM" amount:[NSDecimalNumber decimalNumberWithString:@"10"]],
                                           [PKPaymentSummaryItem summaryItemWithLabel:@"SHIPPING" amount:shippingMethod1.amount],
                                           [PKPaymentSummaryItem summaryItemWithLabel:@"BRAINTREE" amount:[NSDecimalNumber decimalNumberWithString:@"14.99"]]
                                           ];

#ifdef __IPHONE_9_0
    paymentRequest.supportedNetworks = @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex, PKPaymentNetworkDiscover];
#else
    paymentRequest.supportedNetworks = @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex];
#endif
    paymentRequest.merchantCapabilities = PKMerchantCapability3DS;
    paymentRequest.currencyCode = @"USD";
    paymentRequest.countryCode = @"US";
    if ([paymentRequest respondsToSelector:@selector(setShippingType:)]) {
        paymentRequest.shippingType = PKShippingTypeDelivery;
    }

    switch ([BraintreeDemoSettings currentEnvironment]) {
        case BraintreeDemoTransactionServiceEnvironmentSandboxBraintreeSampleMerchant:
            paymentRequest.merchantIdentifier = @"merchant.com.braintreepayments.sandbox.Braintree-Demo";
            break;
        case BraintreeDemoTransactionServiceEnvironmentProductionExecutiveSampleMerchant:
            paymentRequest.merchantIdentifier = @"merchant.com.braintreepayments.Braintree-Demo";
            break;
        case BraintreeDemoTransactionServiceEnvironmentCustomMerchant:
            self.progressBlock(@"Direct Apple Pay integration does not support custom environments in this Demo App");
            break;
    }

    PKPaymentAuthorizationViewController *viewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentRequest];
    viewController.delegate = self;

    self.progressBlock(@"Presenting Apple Pay Sheet");
    [self presentViewController:viewController animated:YES completion:nil];
}


#pragma mark PKPaymentAuthorizationViewControllerDelegate

- (void)paymentAuthorizationViewController:(__unused PKPaymentAuthorizationViewController *)controller
                   didSelectShippingMethod:(PKShippingMethod *)shippingMethod
                                completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    PKPaymentSummaryItem *testItem = [PKPaymentSummaryItem summaryItemWithLabel:@"SOME ITEM" amount:[NSDecimalNumber decimalNumberWithString:@"10"]];
    if ([shippingMethod.identifier isEqualToString:@"fast"]) {
        completion(PKPaymentAuthorizationStatusSuccess,
                   @[
                     testItem,
                     [PKPaymentSummaryItem summaryItemWithLabel:@"SHIPPING" amount:shippingMethod.amount],
                     [PKPaymentSummaryItem summaryItemWithLabel:@"BRAINTREE" amount:[testItem.amount decimalNumberByAdding:shippingMethod.amount]],
                     ]);
    } else if ([shippingMethod.identifier isEqualToString:@"fail"]) {
        completion(PKPaymentAuthorizationStatusFailure, @[testItem]);
    } else {
        completion(PKPaymentAuthorizationStatusSuccess, @[testItem]);
    }
}

- (void)paymentAuthorizationViewController:(__unused PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    self.progressBlock(@"Apple Pay Did Authorize Payment");
    BTApplePayClient *applePayClient = [[BTApplePayClient alloc] initWithAPIClient:self.apiClient];
    [applePayClient tokenizeApplePayPayment:payment completion:^(BTApplePayCardNonce * _Nullable tokenizedApplePayPayment, NSError * _Nullable error) {
        if (error) {
            self.progressBlock(error.localizedDescription);
            completion(PKPaymentAuthorizationStatusFailure);
        } else {
            self.label.text = tokenizedApplePayPayment.nonce;
            self.completionBlock(tokenizedApplePayPayment);
            completion(PKPaymentAuthorizationStatusSuccess);
        }
    }];
}



- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)paymentAuthorizationViewControllerWillAuthorizePayment:(__unused PKPaymentAuthorizationViewController *)controller {
    self.progressBlock(@"Apple Pay will Authorize Payment");
}

@end
