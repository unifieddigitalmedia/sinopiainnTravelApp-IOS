//
//  ViewController.h
//  SinopiaInnTravelApp
//
//  Created by Machel Slack on 08/09/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderViewController.h"

@interface ViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate , ReaderViewControllerDelegate>


@property(nonatomic,retain) UITableView *mainControllerOptions;

@property(nonatomic,retain) UIButton *checkAvailabilitybutton;

@property(nonatomic,retain) UIView * topRootview;
@property(nonatomic,retain) UIView * bottomRootview;

@property(nonatomic,retain) UIColor *myColor;


@end

