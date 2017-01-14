//
//  confirmationPage.h
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "checkedInProtocol.h"


@interface confirmationPage : UITableViewController <checkedinguestContainer,UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate>


@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic,retain) UIButton *gotoPersonalDetails;
- (id)initWithHeight:(int)height initWithWidth:(int)width;
@property (retain, nonatomic) IBOutlet UIToolbar *HomePageToolbar;
@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIColor *sinopia;

@property(nonatomic,retain) UITextField * FromDate;
@property(nonatomic,retain) UITextField * ToDate;
@property(nonatomic,retain) NSString *fromdatestringConfirm;

@property(nonatomic,retain) NSString *todatestringConfirm;

@property(nonatomic,retain) UITableView *mainTableView;

@end
