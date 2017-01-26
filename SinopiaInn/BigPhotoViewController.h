//
//  BigPhotoViewController.h
//  SinopiaInn
//
//  Created by Machel Slack on 26/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "checkedInProtocol.h"

@interface BigPhotoViewController : UIViewController  < checkedinguestContainer , UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>


@property(nonatomic,retain) UITableView *mainTableView;
@property(nonatomic,retain) UIScrollView *mainScrollview;
@property(nonatomic,retain) UIPageControl *mainPagecontroller;
@property(nonatomic,retain) UIButton *mainButton;
@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic,retain) UIButton *gotoPersonalDetails;
@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIColor *sinopia;
@property(nonatomic,retain) UITextField *messageField;
@property(nonatomic,retain) UITextField *locationField;
@property(nonatomic,retain) NSString *locationString;
@property(nonatomic,retain) NSString *messageString;
@property(nonatomic,retain) UIImage *jpeg;
@property(nonatomic,retain) NSArray *jpgDict;
@property(nonatomic,retain) UITextField *message;
@property(nonatomic,retain) UIButton *sendBtn;


- (id)initWithHeight:(int)width initWithWidth:(int)height initWithObject:(UIImage*)JPG;

- (id)initWithHeight:(int)width initWithWidth:(int)height initWithArray:(NSArray*)jpgDict;



@end
