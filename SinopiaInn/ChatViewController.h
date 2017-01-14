//
//  ChatViewController.h
//  SinopiaInnApp
//
//  Created by Machel Slack on 14/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <  UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate >

@property(nonatomic,retain) NSArray* jsonArray;
@property(nonatomic,retain) UITextField *message;
@property(nonatomic,retain) UITableView *messageLog;
@property(nonatomic,retain) UIButton *sendBtn;
@property(nonatomic,readwrite) int width;
@property(nonatomic,readwrite) int height;
- (id)initWithHeight:(int)width initWithWidth:(int)height initWithArray:(NSArray*)thejsonArray;
@property(nonatomic,readwrite) NSMutableArray *messages;

@property(nonatomic,readwrite) CGFloat cellheight;


@end
