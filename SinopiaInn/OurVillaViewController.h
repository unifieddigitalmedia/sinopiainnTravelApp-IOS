//
//  OurVillaViewController.h
//  SinopiaInnTravelApp
//
//  Created by Machel Slack on 01/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OurVillaViewController : UIViewController



@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic,retain) UIButton *gotoPersonalDetails;
- (id)initWithHeight:(int)width initWithWidth:(int)height;

@end
