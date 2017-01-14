//
//  TimeViewController.h
//  SinopiaInnTravelApp
//
//  Created by Machel Slack on 12/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewController : UIViewController


@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic, readwrite) UIVisualEffectView *blurEffectView;
- (id)initWithHeight:(int)width initWithWidth:(int)height;


@end
