//
//  placeDescriptionpage.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guestContainerViewController.h"
#import "checkedinguestContainer.h"


@interface placeDescriptionpage : UITableViewController <UITableViewDataSource, UITableViewDelegate>


- (id)initWithHeight:(int)width initWithWidth:(int)height initWithObject:(NSDictionary*)item;

@property(nonatomic,retain) NSDictionary* jsonObject;

@property(nonatomic, readwrite) int width;

@property(nonatomic, readwrite) int height;

@property(nonatomic,retain) UITableView *mainTableView;

@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIColor *sinopia;

@property(nonatomic,retain) UIButton *gotoPersonalDetails;
@property (retain, nonatomic) IBOutlet UIToolbar *HomePageToolbar;

@property(nonatomic, readwrite) double mylatitude;
@property(nonatomic, readwrite) double mylongitude;

@end
