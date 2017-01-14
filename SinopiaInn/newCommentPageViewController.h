//
//  newCommentPageViewController.h
//  SinopiaInnApp
//
//  Created by Machel Slack on 16/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "checkedInProtocol.h"



@interface newCommentPageViewController : UITableViewController <checkedinguestContainer,UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate,UIScrollViewDelegate>


@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic,retain) NSArray* jsonArray;
@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIColor *sinopia_cell;
- (id)initWithHeight:(int)width initWithWidth:(int)height;
@property(nonatomic, retain) NSString *nameTEXT;
@property(nonatomic, retain) NSString *commentEXT;
@property(nonatomic, retain) UIButton *checkAvailabilitybutton;
@property(nonatomic, readwrite) int rating;
@property(nonatomic,retain) UIScrollView *mainScrollview;
@property(nonatomic,retain) UIPageControl *mainPagecontroller;




@end
