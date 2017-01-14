//
//  travelGuide.h
//  SinopiaInn
//
//  Created by Machel Slack on 17/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface travelGuide : UITableViewController <UITableViewDataSource, UITableViewDelegate>



@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;

- (id)initWithHeight:(int)width initWithWidth:(int)height;
@property(nonatomic,retain) UITableView *mainTableView;

@end
