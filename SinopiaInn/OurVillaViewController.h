//
//  OurVillaViewController.h
//  SinopiaInn
//
//  Created by Machel Slack on 26/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OurVillaViewController : UIViewController

@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic,retain) UIButton *gotoPersonalDetails;
- (id)initWithHeight:(int)width initWithWidth:(int)height;


@end
