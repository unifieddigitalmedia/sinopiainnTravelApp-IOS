//
//  TimeViewController.h
//  SinopiaInn
//
//  Created by Machel Slack on 26/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewController : UIViewController

@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic, readwrite) UIVisualEffectView *blurEffectView;
- (id)initWithHeight:(int)width initWithWidth:(int)height;



@end
