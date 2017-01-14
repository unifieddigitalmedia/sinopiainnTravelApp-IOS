//
//  travelplannerPage.h
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "guestContainer.h"
#import "checkedinguestContainer.h"


@interface travelplannerPage : UITableViewController <guestContainer,UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate>


@property(nonatomic,retain) UITableView *mainTableView;

@property(nonatomic,retain) UIButton *checkAvailabilitybutton;


@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIColor *sinopia;



- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight initWithArray:(NSArray*)thejsonArray;


- (id)initWithHeight:(int)width initWithWidth:(int)height initWithtypes:(NSString*)types initWithservices:(NSString*)services initWithplaces:(NSString*)places initWithArray:(NSArray*)businessesArray;

- (id)initWithHeight:(int)width initWithWidth:(int)height;
@property(nonatomic,retain) NSMutableArray* jsonbusinessTypesArray;

@property(nonatomic,retain) NSMutableArray* jsonbusinessServiceArray;

@property(nonatomic,retain) NSMutableArray* jsonbusinessPlacesArray;

@property(nonatomic,retain) NSArray* jsonArray;

@property(nonatomic,retain) NSString * typesstring;
@property(nonatomic,retain) NSString * servicestring;
@property(nonatomic,retain) NSString * placesstring;
@property(nonatomic,retain) NSMutableArray *iconArray;

@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@end
