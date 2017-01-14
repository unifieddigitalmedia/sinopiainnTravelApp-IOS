//
//  TimelineViewController.m
//  SinopiaInnApp
//
//  Created by Machel Slack on 13/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "TimelineViewController.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

@synthesize width;
@synthesize height;
@synthesize jsonArray;
@synthesize sinopia_cell;

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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height/2)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    NSArray *imageArray = [[jsonArray objectAtIndex:0]  objectForKey:@"images"];
    
    NSString *fullurl  = [[NSString stringWithFormat:@"http://www.sinopiainn.com/%@",[[imageArray objectAtIndex:0] objectForKey:@"image_url"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    

    NSData *imagedata = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:fullurl]];
    
    
    imageView.image = [UIImage imageWithData: imagedata];
    
    [headerView addSubview:imageView];
    
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return [jsonArray count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return [jsonArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    sectionName = @" ";
    
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.imageView.tintColor = _myColor;
    
    tableView.tintColor = _myColor;
    
    cell.textLabel.textColor = sinopia_cell;
    
    cell.detailTextLabel.textColor = sinopia_cell;
    
    cell.imageView.frame = CGRectMake(20,20,width,height);
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
 
                
                NSArray *imageArray = [[jsonArray objectAtIndex:indexPath.section]  objectForKey:@"images"];
        
      
        
        
        NSString *fullurl  = [[NSString stringWithFormat:@"http://www.sinopiainn.com/%@",[[imageArray objectAtIndex:0] objectForKey:@"image_url"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        
        
        NSData *imagedata = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:fullurl]];
        
        if ( imagedata == nil )  return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
          
            
            cell.imageView.image = [UIImage imageWithData:imagedata];
        
            cell.textLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            
            cell.detailTextLabel.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"location"];
            
            
           
        });
        
        
            
            
            
        
    });
    
    
    return cell;
    

    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}

@end
