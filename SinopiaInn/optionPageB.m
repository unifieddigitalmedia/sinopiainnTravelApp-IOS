//
//  optionPageB.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "optionPageB.h"
#import "itemDescription.h"
#import "checkedinguestContainer.h"
#import <QuartzCore/QuartzCore.h>

@interface optionPageB ()

@end

@implementation optionPageB


@synthesize jsonArray;
@synthesize mainTableView;
@synthesize selectedlist;
@synthesize width;
@synthesize height;
@synthesize gotoPersonalDetails;
@synthesize imagesAmenities;
@synthesize imageTravel;
@synthesize types;
@synthesize images;
@synthesize sinopia_cell;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSArray*)thejsonArray{
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonArray = thejsonArray;
    
    return self;
}

- (id)initWithHeight:(int)theheight initWithWidth:(int) thewidth initWithArray:(NSArray*)thejsonArray initWithIcons:(NSArray*)theiconArray
{
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonArray = thejsonArray;
    
    _iconArray = theiconArray;
    
    
    return self;
}


-(void) gotoOptionspageWithimages:(NSArray*)thejsonArray withImages:(NSMutableArray*)theiconArray {
    
    
    jsonArray = thejsonArray;
    _iconArray = theiconArray;
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    imagesAmenities = @[@"ic_free_breakfast" , @"ic_airport_shuttle", @"ic_time_to_leave" , @"ic_bookmark_border", @"ic_local_library", @"ic_local_movies_white"];
    
    imageTravel = @[@"ic_home_white" , @"ic_restaurant", @"ic_card_travel" , @"ic_bookmark_border", @"ic_local_library", @"ic_local_movies_white"];
    
    sinopia_cell = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
    
    
    selectedlist = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,0,width-20,height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100.0;
    
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    
    
    //imageView.image =  [UIImage imageWithData: [[jsonArray objectAtIndex:0] objectForKey:@"image" ]];
    
    
    
    [headerView addSubview:imageView];
    
    gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    gotoPersonalDetails.frame = CGRectMake(headerView.frame.size.width - 75 ,headerView.frame.size.height - 25 ,50,50);
    
    _myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    UIImage *btnImage = [UIImage imageNamed:@"ic_local_see"];
    
    [gotoPersonalDetails setImage:btnImage forState:UIControlStateNormal];
    
    
    [gotoPersonalDetails.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    
    [gotoPersonalDetails addTarget:self action:@selector(gotoDetailspage:) forControlEvents:UIControlEventTouchUpInside];
    
    [[gotoPersonalDetails layer] setBorderColor:_myColor.CGColor];
    
    [[gotoPersonalDetails layer] setBackgroundColor:_myColor.CGColor];
    
    gotoPersonalDetails.layer.cornerRadius = gotoPersonalDetails.frame.size.width / 2;
    
    gotoPersonalDetails.layer.borderWidth = 3.0f;
    
    gotoPersonalDetails.clipsToBounds = YES;
    
    [headerView bringSubviewToFront:gotoPersonalDetails];
    
    [headerView addSubview:gotoPersonalDetails];
    
    
    self.tableView.tableHeaderView = headerView;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [jsonArray count] + 1;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.imageView.tintColor = _myColor;
    
    tableView.tintColor = _myColor;
    
    cell.textLabel.textColor = sinopia_cell;
    
    cell.detailTextLabel.textColor = sinopia_cell;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.row < [jsonArray count]){
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 1 ){
            
            id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
            
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 5){
                
                
                cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.section] objectForKey:@"name"];
                
                cell.textLabel.textColor = [UIColor whiteColor];
                
                [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
                
                cell.detailTextLabel.text = [[jsonArray objectAtIndex:indexPath.section] objectForKey:@"description"];
                
                cell.detailTextLabel.textColor = [UIColor whiteColor];
                
                NSLog(@"%@",[[jsonArray objectAtIndex:indexPath.section] objectForKey:@"description"]);
                
                
                cell.backgroundColor = sinopia_cell;
                
                return cell;
                
                
            } else{
                
                
                
                
                if([parentViewController.itineraryArray containsObject:[jsonArray objectAtIndex:indexPath.row] ])
                {
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    
                    
                }
                else{
                    
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
                
                cell.imageView.image = [[UIImage imageNamed:[_iconArray objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                
                
                cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"businessname"];
                
                cell.detailTextLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"businessdescription"];
                
                
                
            }
            
            
            
        } else  {
            
            
            
            id <guestContainer> parentViewController = (id)self.parentViewController;
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 0 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 1 ) {
                
                
                if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ]  != 3){
                    
                    
                    cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"name"];
                    
                    cell.detailTextLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"description"];
                    
                    
                }else{
                    
                    cell.imageView.image = [[UIImage imageNamed:[imagesAmenities objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    
                    cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"name"];
                    
                    cell.detailTextLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"description"];
                    
                    
                    
                }
                
                
                
            }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 2){
                
                
                
                cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.section] objectForKey:@"name"];
                
                cell.detailTextLabel.text = [[jsonArray objectAtIndex:indexPath.section] objectForKey:@"description"];
                
                cell.textLabel.textColor = [UIColor whiteColor];
                
                [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
                
                
                cell.detailTextLabel.textColor = [UIColor whiteColor];
                
                
                cell.backgroundColor = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
                
                
                
            }else{
                
                if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ]  != 2){
                    
                    
                    cell.imageView.image = nil;
                    
                    
                    cell.imageView.image = [[UIImage imageNamed:[_iconArray objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    cell.textLabel.text = [jsonArray objectAtIndex:indexPath.row];
                    
                    
                    
                }else{
                    
                    if([parentViewController.itineraryArray containsObject:[jsonArray objectAtIndex:indexPath.row] ])
                        
                    {
                        
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        
                        
                    }
                    
                    else {
                        
                        
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        
                    }
                    
                    
                    cell.imageView.image = [[UIImage imageNamed:[_iconArray objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"businessname"];
                    
                    cell.detailTextLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"businessdescription"];
                    
                    
                }
                
            }
            
            
            
            
        }
        
        
        
    }
    
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.numberOfLines = 0;
    
    
    
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    sectionName = @"";
    
    return sectionName;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue]!= 0){
        
        id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 5){
            
            
            [parentViewController gotoItemdescriptionpage:[jsonArray objectAtIndex:indexPath.section]];
            
            
        }else{
            
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ]  != 2){
                
                
                if([selectedlist containsObject:[jsonArray objectAtIndex:indexPath.row]])
                {
                    
                    
                    [selectedlist removeObject:[jsonArray objectAtIndex:indexPath.row]];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
                
                else
                    
                {
                    
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    
                    [selectedlist addObject:[jsonArray objectAtIndex:indexPath.row]];
                    
                    
                    
                }
                
                
                
                
            } else {
                
                
                [parentViewController gotoplacedescriptionpage:[jsonArray objectAtIndex:indexPath.row]];
                
                
                
            }
            
            
            
            
        }
        
        
        
    }else{
        
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 0 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 1 ) {
            
            
            
            if([selectedlist containsObject:[jsonArray objectAtIndex:indexPath.row]])
            {
                
                [selectedlist removeObject:[jsonArray objectAtIndex:indexPath.row]];
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            else
            {
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                [selectedlist addObject:[jsonArray objectAtIndex:indexPath.row]];
                
                
                
            }
            
            
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 2){
            
            
            [parentViewController gotoItemdescriptionpage:[jsonArray objectAtIndex:indexPath.row]];
            
            
            
        }else{
            
            
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ]  != 2){
                
                
                
                
                if([selectedlist containsObject:[jsonArray objectAtIndex:indexPath.row]])
                {
                    
                    [selectedlist removeObject:[jsonArray objectAtIndex:indexPath.row]];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
                else
                {
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    
                    [selectedlist addObject:[jsonArray objectAtIndex:indexPath.row]];
                    
                    
                    
                }
                
            }
            
            else{
                
                
                [parentViewController gotoplacedescriptionpage:[jsonArray objectAtIndex:indexPath.row]];
                
                
            }
            
            
            
            
        }
        
        
        
    }
    
    
}


- (IBAction)gotoItempage:(id)sender {
    
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    
    [parentViewController gotoItemdescriptionpage:[jsonArray objectAtIndex: [sender tag]]];
    
    
}

- (IBAction)gotoDetailspage:(id)sender {
    
    
    if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] != 0){
        
        
        id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
        
        
        if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue] == 4 ){
            
            
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ]  == 0){
                
                [parentViewController returnedbuinessTypesArray:selectedlist];
                
            }else if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue] == 1){
                
                
                [parentViewController returnedserviceTypesArray:selectedlist];
                
            }else{
                
                
                [parentViewController returnedplacesTypesArray:selectedlist];
                
            }
            
            
            
            
        } else  {
            
            
            
            
            
            
        }
        
        
        
    }
    else{
        
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        
        if(     [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 0 ||      [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 1 ){
            
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ] == 1){
                
                [parentViewController returnedroomsArray:selectedlist];
                
            }else{
                
                
                [parentViewController returnedamenitiesArray:selectedlist];
                
            }
            
            
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3) {
            
            
            
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ] == 0){
                
                [parentViewController returnedbuinessTypesArray:selectedlist];
                
            }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionSelected"] intValue ] == 1){
                
                
                [parentViewController returnedserviceTypesArray:selectedlist];
                
            }else{
                
                
                [parentViewController returnedplacesTypesArray:selectedlist];
                
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 1 ){
        
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 5) {
            
            return 70;
        }
        
    }else{
        
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 2 ) {
            
            return 70;
        }
        
        
    }
    
    
    return 100;
    
}
@end
