//
//  optionPageC.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "optionPageC.h"

@interface optionPageC ()

@end

@implementation optionPageC

@synthesize jsonArray;
@synthesize mainTableView;
@synthesize selectedlist;
@synthesize width;
@synthesize height;
@synthesize gotoPersonalDetails;
@synthesize imagesAmenities;
@synthesize imageTravel;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSArray*)thejsonArray{
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonArray = thejsonArray;
    
    return self;
}

- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight initWithArray:(NSArray*)thejsonArray initWithIcons:(NSArray*)theiconArray
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
    
    selectedlist = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100.0;
    
    
    
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
    
    
    if(indexPath.row < [jsonArray count]){
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 200)];
        
        UIButton *sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        sectionButton.frame = CGRectMake(0,2,tableView.frame.size.width , 198);
        
        
        NSString *url = @"";
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 0 && [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3){
            
            
            url = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"url"];
            
            
            
        }else{
            
            
            url = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"image"];
            
        }
        
        //
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        UIImage *btnImage = image;
                        
                        [sectionButton setImage:btnImage forState:UIControlStateNormal];
                        
                    });
                }
            }
        }];
        [task resume];
        
        
        
        
        
        
        [sectionButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        [sectionButton addTarget:self action:@selector(gotoItempage:) forControlEvents:UIControlEventTouchUpInside];
        
        sectionButton.tag = indexPath.section;
        
        [view addSubview:sectionButton];
        
        [view setBackgroundColor:[UIColor whiteColor ]];
        
        [cell.contentView addSubview:view];
        
        
        UILabel *placeholderTextView = [[UILabel alloc]initWithFrame:CGRectMake(0, view.frame.size.height, tableView.frame.size.width , 35)];
        
        UILabel *placeholderDescriptionTextView = [[UILabel alloc]initWithFrame:CGRectMake(0, placeholderTextView.frame.origin.y + placeholderTextView.frame.size.height, tableView.frame.size.width , 35)];
        
        
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 0 && [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3){
            
            
            //placeholderTextView.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"businessname"];
            //placeholderDescriptionTextView.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"businessdescription"];
            
            placeholderTextView.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            placeholderDescriptionTextView.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"description"];
            
            
            
        }
        
        else {
            
            
            
            placeholderTextView.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            placeholderDescriptionTextView.text = [[jsonArray objectAtIndex:indexPath.row] objectForKey:@"description"];
            
            
        }
        
        
        placeholderTextView.textColor = [UIColor whiteColor];
        
        [placeholderTextView setFont:[UIFont boldSystemFontOfSize:14]];
        
        placeholderTextView.numberOfLines = 0;
        
        placeholderTextView.backgroundColor = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
        
        [cell.contentView addSubview:placeholderTextView];
        
        
        
        placeholderDescriptionTextView.numberOfLines = 0;
        
        placeholderDescriptionTextView.textColor = [UIColor whiteColor];
        
        [placeholderDescriptionTextView setFont:[UIFont boldSystemFontOfSize:14]];
        
        placeholderDescriptionTextView.backgroundColor = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
        
        [cell.contentView addSubview:placeholderDescriptionTextView];
        
        
        cell.backgroundColor = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
        
        
        
        return cell;
        
        
    }else{
        
        
        return cell;
        
    }
    
    
    
    
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
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue] != 0){
        
        id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 5){
            
            
            
            
            [parentViewController gotoItemdescriptionpage:[jsonArray objectAtIndex:indexPath.row]];
            
            
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 4){
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[[jsonArray objectAtIndex:indexPath.row] objectForKey:@"location"] forKey:@"location"];
            
            
            [parentViewController gotoTripplannerpageList];
            
            
            
            
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
            
            
            
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3){
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[[jsonArray objectAtIndex:indexPath.row] objectForKey:@"location"] forKey:@"location"];
            
            
            [parentViewController gotoTripplannerpageList];
            
            
            
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
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionsPage"] intValue] == 4 || ([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue] == 0 && [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionsPage"] intValue] == 3)){
        
        
        id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[[jsonArray objectAtIndex: [sender tag]] objectForKey:@"location"] forKey:@"location"];
        
        
        [parentViewController gotoTripplannerpageList];
        
        
        
        
        
    } else {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue] != 0){
            
            id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
            
            
            [parentViewController gotoItemdescriptionpage:[jsonArray objectAtIndex: [sender tag]]];
            
            
        }else{
            
            id <guestContainer> parentViewController = (id)self.parentViewController;
            
            
            [parentViewController gotoItemdescriptionpage:[jsonArray objectAtIndex: [sender tag]]];
            
        }
        
        
    }
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row != [jsonArray count] + 1){
        
        
        return 270;
    }
    
    
    return 1;
    
    
}
@end
