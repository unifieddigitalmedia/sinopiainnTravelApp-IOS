//
//  GuestBookViewController.m
//  SinopiaInnApp
//
//  Created by Machel Slack on 16/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "GuestBookViewController.h"


@interface GuestBookViewController ()

@end

@implementation GuestBookViewController


@synthesize width;
@synthesize height;
@synthesize jsonArray;
@synthesize sinopia_cell;
@synthesize gotoPersonalDetails;


- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSArray*)thejsonArray{
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonArray = thejsonArray;
    
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    _myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia_cell = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100.0;
    
   
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height/2)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    imageView.image = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.sinopiainn.com/public/reservations/582363636b8a340011fcd00b/IMG_5514.jpg"]]];
    
    [headerView addSubview:imageView];
    
    UIImage *btnImage = [UIImage imageNamed:@"ic_create"];
    
    gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    gotoPersonalDetails.frame = CGRectMake(headerView.frame.size.width - 75 ,headerView.frame.size.height - 25 ,50,50);
    
    gotoPersonalDetails.tintColor  = [UIColor blackColor];
    
    _myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    [gotoPersonalDetails setImage:btnImage forState:UIControlStateNormal];
    
    
    [gotoPersonalDetails.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    
    [gotoPersonalDetails addTarget:self action:@selector(gotoNewCommentpage:) forControlEvents:UIControlEventTouchUpInside];
    
    [[gotoPersonalDetails layer] setBorderColor:_myColor.CGColor];
    
    [[gotoPersonalDetails layer] setBackgroundColor:_myColor.CGColor];
    
    gotoPersonalDetails.layer.cornerRadius = gotoPersonalDetails.frame.size.width / 2;
    
    gotoPersonalDetails.layer.borderWidth = 3.0f;
    
    gotoPersonalDetails.clipsToBounds = YES;
    
    [headerView bringSubviewToFront:gotoPersonalDetails];
    
    [headerView addSubview:gotoPersonalDetails];
    
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [jsonArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [jsonArray objectAtIndex:indexPath.section] ;
    
    
    cell.imageView.image = [UIImage imageWithData:[[jsonArray objectAtIndex:indexPath.section] objectForKey:@"image_url"]];
    
    cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"comment"];
    

    
    UIFont *cellFont = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    
 
    
    cell.textLabel.font = cellFont;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[[jsonArray objectAtIndex:indexPath.row] objectForKey:@"name"],[self returnDateString:[[jsonArray objectAtIndex:indexPath.row] objectForKey:@"date"]]] ;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];

    
    imgView.image = [UIImage imageNamed:  [NSString stringWithFormat:@"%@star",[[jsonArray objectAtIndex:indexPath.row] objectForKey:@"rating_img"]]];
    
    cell.accessoryView = imgView;
    
    
    cell.accessoryView.backgroundColor  = [UIColor clearColor];
    
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.numberOfLines = 0;
    
    
    return cell;


}



-(NSString*) returnDateString:(NSString*)initalDate{
    
    NSString *datestring = @"";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    
    NSDate *date = [dateFormat dateFromString:initalDate];
    
    NSLog(@"%@",date);
    
    [dateFormat setDateFormat:@"EE, MMM dd yyyy"];
    
    
    datestring = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
    
    return datestring;
    
    
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    sectionName = @"";
    
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}

- (IBAction) gotoNewCommentpage:(id) sender

{
    
    
    id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
    
    [parentViewController gotoNewCommentpage];
    
    
    
}



@end
