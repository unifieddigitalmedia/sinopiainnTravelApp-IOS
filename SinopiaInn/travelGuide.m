//
//  travelGuide.m
//  SinopiaInn
//
//  Created by Machel Slack on 17/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "travelGuide.h"

@interface travelGuide ()

@end

@implementation travelGuide
@synthesize mainTableView;
@synthesize width;
@synthesize height;
UIColor *sinopia;

- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  NSLog(@"tableview height %d",height);
   
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
   self.tableView.dataSource = self;
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 44.0;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"sinopia_inn.png"];
    
    [headerView addSubview:imageView];
    
    self.tableView.tableHeaderView = headerView;
    
    sinopia = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 11;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *simpleTableIdentifier = @"SimpleTableItem";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
            
        }
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row == 0 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"KEY FACTS";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:24.0];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 1 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"Capital:Kingston";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        
        cell.textLabel.textColor = sinopia;
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 2 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"Population:2,702,300";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        
         cell.textLabel.textColor = sinopia;
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 3 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"Currency:JMD:Jamaican Dollar";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        
         cell.textLabel.textColor = sinopia;
        
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 4 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"Language:English";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        
         cell.textLabel.textColor = sinopia;
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 5 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"WHEN TO GO";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:24.0];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 6 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"Jamaica’s middle-of-the-Caribbean location means it enjoys balmy temperatures all year round. The summer months are the hottest, with temperatures topping 30 degrees. Winter is a bit cooler, but still toasty by UK standards – expect the mercury to hover in the mid to high 20s. This is the driest time to visit – most of the island’s rain falls in summer and autumn. Hurricane season is from June to November, with August and September being the peak months. Severe storms are pretty rare, though.";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        
         cell.textLabel.textColor = sinopia;
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 7 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"HOW TO GET HERE";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:24.0];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 8 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"Visitors flying into the country are well served by three modern international airports, and the island enjoys direct connectivity to most major US gateways. Jamaica averages 37 flights daily from the US, ranging from a low of 30 on Tuesdays to a high of 48 on Saturdays, and has four ports of call with 53 ships docking annually. Some of the world’s premier cruise lines such as Carnival, Princess Cruises and Royal Caribbean from North America, Aida Cruises from Germany and Sun Cruises from Britain visit Jamaica each year.";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        
         cell.textLabel.textColor = sinopia;
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 9 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"PASSPORTS AND VISAS";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:24.0];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    if(indexPath.row == 10 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"British citizens don’t need a visa to enter Jamaica, but must have a valid passport. For the most up-to-date passport and visa info, visit www.gov.uk/foreign-travel-advice/jamaica/entry-requirements For more information visit the Foreign Office website - www.fco.gov.uk/en/";
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        
         cell.textLabel.textColor = sinopia;
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        return  cell;
        
        
    }
    
        return cell;
    }




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
