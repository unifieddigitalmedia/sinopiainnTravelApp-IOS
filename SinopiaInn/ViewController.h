//
//  ViewController.h
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property(nonatomic,retain) UITableView *mainControllerOptions;

@property(nonatomic,retain) UIButton *checkAvailabilitybutton;

@property(nonatomic,retain) UIView * topRootview;
@property(nonatomic,retain) UIView * bottomRootview;

@property(nonatomic,retain) UIColor *myColor;


@end

