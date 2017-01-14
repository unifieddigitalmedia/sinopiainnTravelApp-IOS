//
//  billPage.h
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "guestContainer.h"


@interface billPage : UITableViewController <guestContainer,UITableViewDataSource, UITableViewDelegate>


@property(nonatomic,retain) UIButton *gotoPersonalDetails;

- (id)initWithHeight:(int)width initWithWidth:(int)height;

- (id)initWithHeight:(int)width initWithWidth:(int)height initWithObject:(NSDictionary*)item;

@property(nonatomic,retain) NSDictionary* jsonObject;

@property(nonatomic, readwrite) int width;

@property(nonatomic, readwrite) int height;

@property(nonatomic,retain) UITableView *mainTableView;

@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIColor *sinopia;

@property(nonatomic,assign) float total;


@end
