//
//  OurVillaViewController.m
//  SinopiaInn
//
//  Created by Machel Slack on 26/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "OurVillaViewController.h"

@interface OurVillaViewController ()

@end

@implementation OurVillaViewController
@synthesize width;
@synthesize height;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, width,height)];
    
    NSString *url = @"http://www.sinopiainn.com/our-villa.html";
    
    NSURL *nsurl=[NSURL URLWithString:url];
    
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:nsurl];
    
    [webview loadRequest:nsrequest];
    
    [self.view addSubview:webview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
