//
//  reservationPage.h
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guestContainer.h"



@interface reservationPage : UITableViewController  <guestContainer,UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;

- (id)initWithHeight:(int)width initWithWidth:(int)height;

- (id)initWithHeight:(int)width initWithWidth:(int)height initWithFrom:(NSString*)fromdate initWithTo:(NSString*)todate initWithrooms:(NSString*)rooms initWithamenities:(NSString*)amenties;



@property(nonatomic,retain) NSArray* jsonRoomsArray;

@property(nonatomic,retain) NSArray* jsonAmenitiesArray;

@property(nonatomic,retain) UIButton *gotoPersonalDetails;

@property (nonatomic, copy, readonly) NSArray *viewControllers;

@property (nonatomic, assign) UIViewController *selectedViewController;

@property (nonatomic, strong) UIView *privateButtonsView;

@property (nonatomic, strong) UIView *privateContainerView;

@property(nonatomic,retain) UITableView *mainTableView;

@property(nonatomic,retain) UIButton *mainButton;

@property(nonatomic,assign) int resID;

@property(nonatomic,retain) UIColor *myColor;

@property(nonatomic,retain) NSMutableArray* selectedroomlist;

@property(nonatomic,retain) NSMutableArray* selectedofferslist;

@property(nonatomic,retain) NSMutableArray* selectedaddonlist;

@property(nonatomic,retain) UITableView *SignUpTable;

@property(nonatomic,retain) UITextField *amenitiesField;

@property(nonatomic,retain) UITextField *offersField;


@property(nonatomic,retain) UITextField *roomsField;


@property(nonatomic,retain) NSString *str_rooms;

@property(nonatomic,retain) NSString *str_offers;


@property(nonatomic,retain) NSString *str_addons;


@property(nonatomic,retain) NSString *fromdatestring;

@property(nonatomic,retain) NSString *todatestring;

@property(nonatomic,retain) NSString *roomsstring;

@property(nonatomic,retain) NSString *offersstring;

@property(nonatomic,retain) NSString *amenitiesstring;

@property(nonatomic,retain) NSString *totalstring;

@property(nonatomic,assign) int num_guest;


@property(nonatomic,assign) NSInteger num_days;

@property(nonatomic,retain) NSDate *fromdatepickerstring;

@property(nonatomic,retain) NSDate *todatepickerstring;

@property(nonatomic,retain) UITextField *guestField;

@end
