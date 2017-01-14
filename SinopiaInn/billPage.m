//
//  billPage.m
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "billPage.h"

@interface billPage ()

@end

@implementation billPage


@synthesize width;

@synthesize height;

@synthesize jsonObject;

@synthesize mainTableView;

@synthesize myColor;

@synthesize sinopia;

@synthesize total;

@synthesize gotoPersonalDetails;

- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight initWithObject:(NSDictionary*)item{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonObject = item;
    
    return self;
}


- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    
    
    
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 44.0;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 5;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
 
    
    if(section == 0){
        
        
        return [parentViewController.roomsArray count];
        
        
    }else if (section == 1) {
        
        return [parentViewController.offersArray count] ;
        
    }else if (section == 2) {
        
        
        return [parentViewController.amentitiesArray count];
    }else if (section == 3) {
        
        return 2;
        
    }
    
    return 2;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
   
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    cell.backgroundColor =  [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    
    if(indexPath.section == 0){
        
        
     
        UITextView *amount = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                 0, 0, 100,cell.frame.size.height)];
        
       cell.textLabel.text = [[parentViewController.roomsArray objectAtIndex:indexPath.row]  objectForKey:@"name"];
        
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        [amount setTextAlignment:NSTextAlignmentRight];
        
        amount.text = [NSString stringWithFormat:@"USD $ %.2f",[[[parentViewController.roomsArray objectAtIndex:indexPath.row]  objectForKey:@"price"] doubleValue ] * parentViewController.num_days ];
        
        [amount setTextColor:[UIColor whiteColor]];
        
        cell.accessoryView = amount;
        
        [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
        
        cell.accessoryView.backgroundColor  = [UIColor clearColor];
        
        
        
        
        total = total + [[[parentViewController.roomsArray objectAtIndex:indexPath.row]  objectForKey:@"price"] intValue ];
        
        
        return  cell;
        
    }else if(indexPath.section == 1){
        
        
        UITextView *amount = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                          0, 0, 100,cell.frame.size.height)];
        
        cell.textLabel.text = [[parentViewController.offersArray objectAtIndex:indexPath.row]  objectForKey:@"name"];
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        [amount setTextAlignment:NSTextAlignmentRight];
        
        cell.textLabel.textColor = sinopia;
        
        amount.text = [NSString stringWithFormat:@"USD $ %.2f", total * [[[parentViewController.offersArray objectAtIndex:indexPath.row]  objectForKey:@"amount"] doubleValue ]];
        
            [amount setTextColor:[UIColor whiteColor]];
        
        cell.accessoryView = amount;
        
        
        cell.accessoryView.backgroundColor  = [UIColor clearColor];
        

        [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];

        total = total - [[[parentViewController.offersArray objectAtIndex:indexPath.row]  objectForKey:@"amount"] intValue ];
        
   
       
        return cell;
        
    }else if(indexPath.section == 2){
        
        
        UITextView *amount = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                          0, 0, 100,cell.frame.size.height)];
        
        [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
        
        
        [amount setTextAlignment:NSTextAlignmentRight];
        
        
        
        
        cell.accessoryView = amount;
        
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        cell.textLabel.text = [[parentViewController.amentitiesArray objectAtIndex:indexPath.row]  objectForKey:@"name"];
        
        
        if([[[parentViewController.amentitiesArray objectAtIndex:indexPath.row]  objectForKey:@"frequency"]  isEqualToString:@"person" ]){
            
            
            
            amount.text = [NSString stringWithFormat:@"USD $ %.2f",[[[parentViewController.amentitiesArray objectAtIndex:indexPath.row]  objectForKey:@"price"] doubleValue ] * parentViewController.num_guest ];
            
            
        }else  if([[[parentViewController.amentitiesArray objectAtIndex:indexPath.row]  objectForKey:@"frequency"]  isEqualToString:@"room" ]){
            
            
            amount.text = [NSString stringWithFormat:@"USD $ %.2f",[[[parentViewController.amentitiesArray objectAtIndex:indexPath.row]  objectForKey:@"price"] doubleValue ] * [parentViewController.roomsArray count] ];
            
            
        }else if([[[parentViewController.amentitiesArray objectAtIndex:indexPath.row]  objectForKey:@"frequency"]  isEqualToString:@"night" ]){
            
        
            amount.text = [NSString stringWithFormat:@"USD $ %.2f",[[[parentViewController.amentitiesArray objectAtIndex:indexPath.row]  objectForKey:@"price"] doubleValue ] * parentViewController.num_days ];
            
            
        }
        
  
        
        [amount setTextColor:[UIColor whiteColor]];
        
        cell.accessoryView.backgroundColor  = [UIColor clearColor];
        
        
        return cell;
        
        
    }else if(indexPath.section == 3){
        
        
        if(indexPath.row == 0 ){
            
            UITextView *amount = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                              0, 0, 100,cell.frame.size.height)];
                [amount setTextColor:[UIColor whiteColor]];
            cell.textLabel.text = @"Tax";
            
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            
            
            [amount setTextAlignment:NSTextAlignmentRight];
            
            amount.text = [NSString stringWithFormat:@"USD $ %.2f", parentViewController.tax  ];
            
            cell.accessoryView = amount;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            cell.accessoryView.backgroundColor  = [UIColor clearColor];
            

            
            return  cell;
            
        }else{
            
            UITextView *amount = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                              0, 0, 100,cell.frame.size.height)];
            [amount setTextColor:[UIColor whiteColor]];
            
            cell.textLabel.text = @"Total";
            
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            
            
            [amount setTextAlignment:NSTextAlignmentRight];
            
            amount.text = [NSString stringWithFormat:@"USD $ %.2f", parentViewController.total ];
            
            cell.accessoryView = amount;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
         
            cell.accessoryView.backgroundColor  = [UIColor clearColor];
            

            
            return  cell;
            
        }
        
    }else if(indexPath.section == 4) {
        
        
        if(indexPath.row == 0 ){
            
            
     
        gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        gotoPersonalDetails.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
        
        [gotoPersonalDetails setTitle:@"Check Availability" forState:UIControlStateNormal];
        
        [gotoPersonalDetails.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        gotoPersonalDetails.titleLabel.font = cellFont;
        
        [gotoPersonalDetails addTarget:self action:@selector(gotoDetailspage:) forControlEvents:UIControlEventTouchUpInside];
        
        [[gotoPersonalDetails layer] setBorderWidth:0.5f];
        
        [[gotoPersonalDetails layer] setBorderColor:myColor.CGColor];
        
        [gotoPersonalDetails setTitleColor:myColor forState:UIControlStateNormal];
        
        
        [cell.contentView addSubview:gotoPersonalDetails];
        
        return  cell;
            
               }
        
    }
    
    
    return cell;
    
    
}


- (IBAction)gotoDetailspage:(id)sender {
    
    
    
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    [parentViewController gotoPersonalDetails];
    
    
    
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Rooms";
            break;
        case 1:
            sectionName = @"Discounts";
            break;
        case 2:
            sectionName = @"Amenities";
            break;
        case 3:
            sectionName = @"";
            break;
        default:
          
            break;
    }
    return sectionName;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    
    NSString *sectionName;
    
    switch (section)
    {
        case 0:
            sectionName = @" Rooms";
            break;
        case 1:
            sectionName = @" Discounts";
            break;
        case 2:
            sectionName = @" Amenities";
            break;
    
        default:
            
            break;
    }
  
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, tableView.frame.size.width, 100)];
    
    [label setBackgroundColor:[UIColor blackColor]];
    
    if(section != 3){
        
        
        [label setFont:[UIFont boldSystemFontOfSize:16]];
        
        [[label layer] setBorderWidth:0.5f];
        
        [[label layer] setBorderColor:myColor.CGColor];
        
        [label setText:sectionName];
        
        [label setTextColor:myColor];
        

    }
    
    
    return label;
    
}



-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    switch (section)
    {
        case 0:
           return 50;
            break;
        case 1:
           return 50;
            break;
       case 2:
           return 50;
            break;
        case 3:
            return 1;
            
        case 4:
            return 0;
            break;
            
            break;
        default:
            
            break;
    }

    return 50;
    
}


@end
