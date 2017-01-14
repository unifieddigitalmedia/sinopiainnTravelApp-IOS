//
//  MapViewController.m
//  SinopiaInnTravelApp
//
//  Created by Machel Slack on 12/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController


@synthesize locationField;
@synthesize width;
@synthesize height;
@synthesize myLatitude;
@synthesize mainTableView;
@synthesize myLongitude;


double myLatitude = 18.166716;

double myLongitude = -76.380764;

double eyeLatitude = 18.166716;

double eyeLongitude = -76.380764;

- (id)initWithHeight:(int)theheight initWithWidth:(int) thewidth{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}

- (id)initWithHeight:(int)theheight initWithWidth:(int) thewidth initWithLatitude:(int)themyLatitude initWithLongitude:(int)themyLongitude{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    myLongitude = themyLatitude;
    
    myLongitude = themyLongitude;
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    MKMapView *mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, width,height)];
    
    mapView.delegate = self;

    
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(myLatitude, myLongitude);
    
   
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(eyeLatitude, eyeLongitude);
 
    MKMapCamera *myCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye eyeAltitude:100];
    
    mapView.zoomEnabled = true;
    mapView.scrollEnabled = true;
    mapView.userInteractionEnabled = true;
    mapView.camera = myCamera;
    
    

    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,50,width,height) style:UITableViewStylePlain];
    
    mainTableView.delegate = self;
    
    mainTableView.dataSource = self;
    
    mainTableView.bounces = NO;
    
    mainTableView.scrollEnabled = YES;
    
    mainTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    mainTableView.rowHeight = UITableViewAutomaticDimension;
    
    mainTableView.estimatedRowHeight = 44.0;
    
    mainTableView.scrollEnabled = YES;
    
    mainTableView.backgroundColor = [UIColor clearColor];
    
    [mapView addSubview:mainTableView];
   
    [self.view addSubview:mapView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
  
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    
    
    
    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  
    return 50;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width  , 50 )];

    [view setBackgroundColor:[UIColor lightGrayColor]];
    
    locationField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, view.frame.size.width - 20 , 50 - 20 )];
    
    locationField.leftViewMode = UITextFieldViewModeAlways;
    
    locationField.leftView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_place"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    locationField.placeholder = @"Find a location:";
    
    [locationField setBackgroundColor:[UIColor whiteColor]];
    
    locationField.leftViewMode = UITextFieldViewModeAlways;
    
    [locationField setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    locationField.delegate = self;
    
    [view addSubview:locationField];
    
    return view;

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
    
    
}

-(UITextField*) addBorder:(UITextField*) textfield {
    
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor darkGrayColor].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height + 10, textfield.frame.size.width, borderWidth);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = YES;
    
    return textfield;
}



@end
