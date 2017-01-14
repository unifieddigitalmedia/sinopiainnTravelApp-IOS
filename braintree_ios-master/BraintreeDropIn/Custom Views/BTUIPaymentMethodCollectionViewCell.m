#import "BTUIPaymentMethodCollectionViewCell.h"
#import "BTUIKPaymentOptionCardView.h"
#import "BTUIKAppearance.h"

@implementation BTUIPaymentMethodCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self removeConstraints:self.constraints];
        [self.contentView removeConstraints:self.contentView.constraints];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

        self.paymentOptionCardView = [[BTUIKPaymentOptionCardView alloc] init];
        self.paymentOptionCardView.translatesAutoresizingMaskIntoConstraints = NO;
        self.paymentOptionCardView.innerPadding = 15.0;
        self.paymentOptionCardView.cornerRadius = 8.0;
        [self.contentView addSubview:self.paymentOptionCardView];

        self.titleLabel = [[UILabel alloc] init];
        [BTUIKAppearance styleLabelSecondary:self.titleLabel];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];

        NSDictionary* viewBindings = @{@"contentView":self.contentView, @"paymentOptionCardView":self.paymentOptionCardView, @"titleLabel":self.titleLabel};

        NSDictionary* metrics = @{};

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:viewBindings]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:viewBindings]];

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[paymentOptionCardView]|"
                                                                                 options:0
                                                                                 metrics:metrics
                                                                                   views:viewBindings]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|"
                                                                                 options:0
                                                                                 metrics:metrics
                                                                                   views:viewBindings]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[paymentOptionCardView]-[titleLabel]|"
                                                                                 options:0
                                                                                 metrics:metrics
                                                                                   views:viewBindings]];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self.paymentOptionCardView setHighlighted:highlighted];
}

@end
