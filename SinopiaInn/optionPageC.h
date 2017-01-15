//
//  optionPageC.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guestContainerViewController.h"
#import "checkedinguestContainer.h"

@interface optionPageC : UITableViewController <checkedinguestContainer, guestContainer ,UITableViewDataSource, UITableViewDelegate>



- (id)initWithHeight:(int)width initWithWidth:(int)height initWithArray:(NSArray*)width;

- (id)initWithHeight:(int)width initWithWidth:(int)height initWithArray:(NSArray*)width initWithIcons:(NSArray*)iconArray;



@property(nonatomic,retain) NSArray* jsonArray;

@property(nonatomic,retain) UITableView *mainTableView;

@property(nonatomic,retain) NSMutableArray* selectedlist;
@property(nonatomic,retain) UIColor *myColor;
@property(nonatomic,retain) UIButton *gotoPersonalDetails;
@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
@property(nonatomic,retain) NSArray * imagesAmenities;
@property(nonatomic,retain) NSArray * imageTravel;
@property(nonatomic,retain) NSDictionary *iconDictionary;
@property(nonatomic,retain) NSArray *iconArray;
@property(nonatomic,retain) UIImageView *backgroundImageView;
@property (weak) IBOutlet UITableViewCell *cell1;

@end
