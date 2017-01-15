//
//  MapViewController.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController <UITextFieldDelegate,MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>


@property(nonatomic, readwrite) int width;
@property(nonatomic, readwrite) int height;
- (id)initWithHeight:(int)width initWithWidth:(int)height;

- (id)initWithHeight:(int)theheight initWithWidth:(int) thewidth initWithLatitude:(int)themyLatitude initWithLongitude:(int)themyLongitude;

@property(nonatomic, readwrite) double myLatitude ;

@property(nonatomic, readwrite) double myLongitude ;

@property(nonatomic,retain) UITableView *mainTableView;

@property(nonatomic,retain) UITextField *locationField;

@end
