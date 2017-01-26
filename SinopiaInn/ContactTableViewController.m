//
//  ContactTableViewController.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "ContactTableViewController.h"

@interface ContactTableViewController ()

@end

@implementation ContactTableViewController
@synthesize mainTableView;
@synthesize width;
@synthesize height;
@synthesize sinopia;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0 )
        
    {
         return 4;
    }
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    
    cell.textLabel.numberOfLines = 0;
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    
    cell.textLabel.textColor = sinopia;
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    
    
    if(indexPath.section == 0 )
        
    {
        
      
        if(indexPath.row == 0 )
            
        {
            
            cell.textLabel.text = @"Zion Hill, Fairy Hill:";
            
        }else if(indexPath.row == 1){
            
            cell.textLabel.text = @"Port Antonio";
            
            
        }else if(indexPath.row == 2){
            
            cell.textLabel.text = @"Jamaica, West Indies";
            
            
        }else if(indexPath.row == 4 ){
            
            cell.textLabel.text = @"Jamaica, West Indies";
            
            
        }
        
        
        
        return  cell;
        
        
    }
    if(indexPath.section == 1 )
        
    {
        
      
        if(indexPath.row == 0 )
            
        {
       
            cell.textLabel.text = @"Call:";
            
        }else if(indexPath.row == 1){
            
            cell.textLabel.text = @"Visit: www.sinopiainn.com";
            
            
        }else if(indexPath.row == 2){
            
            cell.textLabel.text = @"Email: info@sinopiainn.com";
            
            
        }
        
       
        
        
        
        return  cell;
        
        
    }
       return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"WHERE WE ARE";
            break;
        case 1:
            sectionName = @"CONTACTS";
            break;
    
        default:
            
            break;
    }
    return sectionName;
}



@end
