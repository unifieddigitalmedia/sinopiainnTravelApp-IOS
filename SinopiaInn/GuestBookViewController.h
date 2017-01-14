//
//  GuestBookViewController.h
//  SinopiaInnApp
//
//  Created by Machel Slack on 16/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "checkedInProtocol.h"


@interface GuestBookViewController : UITableViewController <checkedinguestContainer,UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate>



@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic,retain) NSArray* jsonArray;
@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIButton *gotoPersonalDetails;
@property(nonatomic,retain) UIColor *sinopia_cell;
- (id)initWithHeight:(int)width initWithWidth:(int)height initWithArray:(NSArray*)width;




@end
