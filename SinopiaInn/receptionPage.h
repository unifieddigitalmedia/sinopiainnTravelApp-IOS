//
//  receptionPage.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guestContainerViewController.h"

@interface receptionPage : UIViewController
<guestContainer,UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate>


@property(nonatomic,retain) UITableView *mainTableView;
@property(nonatomic,retain) UIButton *mainButton;
@property(nonatomic,retain) UIScrollView *mainScrollview;
@property(nonatomic,retain) UIPageControl *mainPagecontroller;
@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIColor *sinopia;
@property(nonatomic,retain) NSArray *titles;
@property(nonatomic,retain) NSArray *descriptions;
@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;


- (id)initWithHeight:(int)height initWithWidth:(int)width;


@end
