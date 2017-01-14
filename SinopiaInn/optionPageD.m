//
//  optionPageD.m
//  SinopiaInnApp
//
//  Created by Machel Slack on 19/12/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "optionPageD.h"

@interface optionPageD ()

@end

@implementation optionPageD

@synthesize jsonArray;
@synthesize mainTableView;
@synthesize selectedlist;
@synthesize width;
@synthesize height;
@synthesize gotoPersonalDetails;
@synthesize imagesAmenities;
@synthesize imageTravel;


- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSMutableArray*)thejsonArray{
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonArray = thejsonArray;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,height) style:UITableViewStylePlain];
    
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100.0;
    
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    
    
    gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    gotoPersonalDetails.frame = CGRectMake(headerView.frame.size.width - 75 ,headerView.frame.size.height - 25 ,50,50);
    
    _myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    

        imageView.image = [UIImage imageNamed:@"room1.JPG"];
        
        [headerView addSubview:imageView];
        

    
    
    
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
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.row < [jsonArray count]){
        
        
        
       //cell.imageView.image = [UIImage imageWithData:  [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[jsonArray objectAtIndex:0] objectForKey:@"image_url"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
                                                                     
        
        
    
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[jsonArray objectAtIndex:0] objectAtIndex:0 ]  objectForKey:@"image"]]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                      
                        
                        
                        cell.imageView.image = image;
                        
                        
                    });
                }
            }
        }];
        [task resume];

        
        cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x , 5 ,cell.imageView.frame.size.width,cell.imageView.frame.size.height - 10 );
                
          cell.textLabel.text = [[[jsonArray objectAtIndex:indexPath.row] objectAtIndex:0 ] objectForKey:@"name"];
        
          cell.detailTextLabel.text = [[[jsonArray objectAtIndex:indexPath.row] objectAtIndex:0  ] objectForKey:@"description"];
                
                
        
        
            
            
        } else  {
            
            
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
    
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue] != 0){
        
        
        id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
        
        
        [parentViewController gotoItemlist:[jsonArray objectAtIndex:indexPath.row]];
        
        
    } else {
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        
        [parentViewController gotoItemlist:[jsonArray objectAtIndex: indexPath.row]];
        
    }
    
    
}
    





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
    
}
@end

