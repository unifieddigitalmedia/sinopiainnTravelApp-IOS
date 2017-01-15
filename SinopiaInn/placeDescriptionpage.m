//
//  placeDescriptionpage.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "placeDescriptionpage.h"

@interface placeDescriptionpage ()

@end

@implementation placeDescriptionpage
@synthesize width;

@synthesize height;

@synthesize jsonObject;

@synthesize mainTableView;

@synthesize myColor;

@synthesize sinopia;

@synthesize gotoPersonalDetails;

@synthesize HomePageToolbar;

@synthesize mylatitude;

@synthesize mylongitude;
NSArray *imagesPlace;

- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight initWithObject:(NSDictionary*)item{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonObject = item;
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    imagesPlace = @[@"ic_local_phone" , @"ic_email", @"ic_public" ,@"ic_map"];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 600;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"sinopia_inn.png"];
    
    [self.tableView addSubview:imageView];
    
    
    UIImage *btnImage = [UIImage imageNamed:@"ic_local_see"];
    
    [gotoPersonalDetails setImage:btnImage forState:UIControlStateNormal];
    
    
    [gotoPersonalDetails.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    
    [gotoPersonalDetails addTarget:self action:@selector(returnList:) forControlEvents:UIControlEventTouchUpInside];
    
    [[gotoPersonalDetails layer] setBorderColor:myColor.CGColor];
    
    [[gotoPersonalDetails layer] setBackgroundColor:myColor.CGColor];
    
    gotoPersonalDetails.layer.cornerRadius = gotoPersonalDetails.frame.size.width / 2;
    
    gotoPersonalDetails.layer.borderWidth = 3.0f;
    
    gotoPersonalDetails.clipsToBounds = YES;
    
    [headerView bringSubviewToFront:gotoPersonalDetails];
    
    [headerView addSubview:gotoPersonalDetails];
    
    [jsonObject objectForKey:@"businessaddress"] ;
    
    mylatitude = [[[jsonObject objectForKey:@"coordinates"]  objectForKey:@"Latitude"] doubleValue];
    
    mylongitude = [[[jsonObject objectForKey:@"coordinates"]  objectForKey:@"Longitude"] doubleValue];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)returnList:(id)sender {
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 3;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if(section != 2){
        
        
        return 1;
        
        
    }
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.imageView.tintColor = myColor;
    
    tableView.tintColor = myColor;
    
    if(indexPath.section == 0){
        
        
        
        HomePageToolbar  = [[UIToolbar alloc] initWithFrame:CGRectMake(10,cell.frame.size.height / 2 ,cell.frame.size.width - 20 ,cell.frame.size.height  )];
        
        HomePageToolbar.tintColor = [UIColor whiteColor];
        
        HomePageToolbar.barTintColor = sinopia;
        
        
        UIButton *HomePageCalButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width/3,HomePageToolbar.frame.size.height  )];
        
        [HomePageCalButton setTitle:@"RESERVATION" forState:UIControlStateNormal];
        
        [HomePageCalButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        HomePageCalButton.titleLabel.font = cellFont;
        
        [HomePageCalButton addTarget:self action:@selector(gotoReservation:) forControlEvents:UIControlEventTouchUpInside];
        
        [[HomePageCalButton layer] setBorderWidth:0.5f];
        
        [[HomePageCalButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        [HomePageCalButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        
        
        [HomePageCalButton setImage:[UIImage imageNamed:@"ic_home_white"] forState:UIControlStateNormal];
        
        
        
        [HomePageToolbar addSubview:[self designButtonwithText:HomePageCalButton]];
        
        
        UIButton *HomePageAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageCalButton.frame.size.width,0,self.view.frame.size.width/3,HomePageToolbar.frame.size.height )];
        
        
        [HomePageAccountButton addTarget:self action:@selector(gotoTraveltips:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [HomePageAccountButton setTitle:@"GUIDE" forState:UIControlStateNormal];
        
        [[HomePageAccountButton layer] setBorderWidth:0.5f];
        
        HomePageAccountButton.titleLabel.font = cellFont;
        
        
        [[HomePageAccountButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        [HomePageAccountButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        
        [HomePageAccountButton setImage:[UIImage imageNamed:@"ic_card_travel_white"] forState:UIControlStateNormal];
        
        [HomePageToolbar addSubview:[self designButtonwithText:HomePageAccountButton]];
        
        UIButton *HomePageHelpButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageAccountButton.frame.origin.x + HomePageAccountButton.frame.size.width,0,self.view.frame.size.width/3,HomePageToolbar.frame.size.height  )];
        
        [HomePageHelpButton setTitle:@"HELP" forState:UIControlStateNormal];
        
        
        
        HomePageHelpButton.titleLabel.font = cellFont;
        
        
        
        [[HomePageHelpButton layer] setBorderWidth:0.5f];
        
        HomePageHelpButton.titleLabel.font = cellFont;
        
        
        [[HomePageHelpButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        
        [HomePageHelpButton addTarget:self action:@selector(gotoContact:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [[HomePageHelpButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        [HomePageHelpButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        
        [HomePageHelpButton setImage:[UIImage imageNamed:@"ic_help_outline_white"] forState:UIControlStateNormal];
        
        
        
        [HomePageToolbar addSubview:[self designButtonwithText:HomePageHelpButton]];
        
        //[cell.contentView addSubview:HomePageToolbar];
        
        
        cell.backgroundColor = [UIColor clearColor];
        
        return  cell;
        
    } else if(indexPath.section == 1 ){
        
        gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        gotoPersonalDetails.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 1 ){
            
            id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
            
            if([parentViewController.itineraryArray containsObject:jsonObject])
            {
                
                [gotoPersonalDetails setTitle:@"REMOVE FROM ITINERARY" forState:UIControlStateNormal];
                
                
            }else{
                
                [gotoPersonalDetails setTitle:@"ADD TO ITINERARY" forState:UIControlStateNormal];
                
                
            }
            
            
        }else{
            
            id <guestContainer> parentViewController = (id)self.parentViewController;
            
            if([parentViewController.itineraryArray containsObject:jsonObject])
            {
                
                [gotoPersonalDetails setTitle:@"REMOVE FROM ITINERARY" forState:UIControlStateNormal];
                
                
            }else{
                
                [gotoPersonalDetails setTitle:@"ADD TO ITINERARY" forState:UIControlStateNormal];
                
                
            }
            
            
        }
        
        
        [gotoPersonalDetails.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        gotoPersonalDetails.titleLabel.font = cellFont;
        
        [gotoPersonalDetails addTarget:self action:@selector(gotoDetailspage:) forControlEvents:UIControlEventTouchUpInside];
        
        [[gotoPersonalDetails layer] setBorderWidth:0.5f];
        
        [[gotoPersonalDetails layer] setBorderColor:myColor.CGColor];
        
        [[gotoPersonalDetails layer] setBackgroundColor:myColor.CGColor];
        
        [gotoPersonalDetails setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        
        [cell.contentView addSubview:gotoPersonalDetails];
        
        return  cell;
        
        
    }
    
    else{
        
        
        if(indexPath.row == 0 )
            
        {
            
            
            
            cell.imageView.image = [[UIImage imageNamed:[imagesPlace objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = [jsonObject objectForKey:@"businessphone"] ;
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            cell.backgroundColor = [UIColor clearColor];
            
            return  cell;
            
            
        }
        
        else if(indexPath.row == 1 )
            
        {
            
            cell.imageView.image = [[UIImage imageNamed:[imagesPlace objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = [jsonObject objectForKey:@"businessemail"] ;
            
            cell.textLabel.numberOfLines = 0;
            
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            cell.backgroundColor = [UIColor clearColor];
            
            return  cell;
            
            
        }else if (indexPath.row == 2){
            
            
            cell.imageView.image = [[UIImage imageNamed:[imagesPlace objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = [jsonObject objectForKey:@"businesswebsite"] ;
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            cell.backgroundColor = [UIColor clearColor];
            
            return  cell;
            
            
        }else if (indexPath.row == 3){
            
            
            cell.imageView.image = [[UIImage imageNamed:[imagesPlace objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = [jsonObject objectForKey:@"businessaddress"] ;
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            cell.backgroundColor = [UIColor clearColor];
            
            return  cell;
            
            
        }
        
        return  cell;
        
    }
    
    
    
    return cell;
    
    
}

- (IBAction)gotoReservation:(id)sender {
    
}


- (IBAction)gotoTraveltips:(id)sender {
    
}


- (IBAction)gotoContact:(id)sender {
    
}

- (IBAction)gotoDetailspage:(id)sender {
    
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue]!= 0){
        
        
        id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
        
        if([parentViewController.itineraryArray containsObject:jsonObject])
        {
            
            [sender setTitle:@"ADD TO ITINERARY" forState:UIControlStateNormal];
            [parentViewController.itineraryArray removeObject:jsonObject];
            
            
            
        }
        
        else
            
        {
            
            
            [sender setTitle:@"REMOVE FROM ITINERARY" forState:UIControlStateNormal];
            
            [parentViewController.itineraryArray addObject:jsonObject];
            
            
            
        }
        
        [parentViewController returnedplacesTypesArray:parentViewController.itineraryArray];
        
    }else{
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        if([parentViewController.itineraryArray containsObject:jsonObject])
        {
            
            [sender setTitle:@"ADD TO ITINERARY" forState:UIControlStateNormal];
            [parentViewController.itineraryArray removeObject:jsonObject];
            
            
            
        }
        
        else
            
        {
            
            
            [sender setTitle:@"REMOVE FROM ITINERARY" forState:UIControlStateNormal];
            
            [parentViewController.itineraryArray addObject:jsonObject];
            
            
        }
        
        [parentViewController returnedplacesTypesArray:parentViewController.itineraryArray];
    }
    
    
    
    
    
    
}

-(UIButton*) designButtonwithText:(UIButton*) button  {
    
    
    
    CGFloat spacing = 6.0;
    
    
    CGSize imageSize = button.imageView.image.size;
    
    button.titleEdgeInsets = UIEdgeInsetsMake(
                                              0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
    
    button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
    
    return button;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    sectionName = @"";
    
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        
        return 100;
    }
    return 60;
    
}


- (IBAction) gotoMap:(id) sender

{
    
    
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    [parentViewController gotoMap:(double)mylatitude withLongitude:(double)mylongitude];
    
    
    
}


@end
