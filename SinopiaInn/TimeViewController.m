//
//  TimeViewController.m
//  SinopiaInn
//
//  Created by Machel Slack on 26/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

@end

@implementation TimeViewController

@synthesize width;
@synthesize height;
@synthesize blurEffectView;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    blurEffectView.frame =  CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height  );
    
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,height)];
    
    timeView.backgroundColor = [UIColor clearColor];
    
    
    UITextView *placeholderTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, height/3, width,height/3)];
    
    [placeholderTextView setTextAlignment:NSTextAlignmentCenter ];
    
    placeholderTextView.backgroundColor = [UIColor clearColor];
    
    placeholderTextView.editable = false;
    
    placeholderTextView.font = [UIFont fontWithName:@"Helvetica" size:40.0];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:[timeZone name]]];
    
    [formatter setDateFormat:@"HH:mm a"];
    
    
    
    NSInteger no_of_seconds = [[NSTimeZone timeZoneWithAbbreviation:@"EST"] secondsFromGMT];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"EEE"];
    
    
    NSString *dayWk = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:no_of_seconds]];
    
    [dateFormatter setDateFormat:@"MMM dd yyyy"];
    
    placeholderTextView.text = [NSString stringWithFormat:@"%@ %@ %@",dayWk,[dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSinceNow:no_of_seconds]],[formatter stringFromDate: [NSDate dateWithTimeIntervalSinceNow:no_of_seconds]]];
    
    [timeView addSubview:placeholderTextView];
    
    [blurEffectView addSubview:placeholderTextView];
    
    [self.view addSubview:blurEffectView];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
