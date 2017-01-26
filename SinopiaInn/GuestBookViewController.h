//
//  GuestBookViewController.h
//  SinopiaInn
//
//  Created by Machel Slack on 26/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
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
