//
//  itemDescription.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "itemDescription.h"

@interface itemDescription ()

@end

@implementation itemDescription


@synthesize width;

@synthesize height;

@synthesize jsonObject;

@synthesize mainTableView;

@synthesize myColor;

@synthesize sinopia;

@synthesize gotoPersonalDetails;

@synthesize ingredients;

@synthesize method;

UIVisualEffectView *blurEffectView;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithObject:(NSDictionary*)item{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonObject = item;
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    
    sinopia = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 44.0;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    
    
    imageView.image = [UIImage imageNamed:@"room1.JPG"];
    
    
    
    
    [headerView addSubview:imageView];
    
    gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    gotoPersonalDetails.frame = CGRectMake(headerView.frame.size.width - 75 ,headerView.frame.size.height - 25 ,50,50);
    
    [gotoPersonalDetails addTarget:self action:@selector(gotoDetailspage:) forControlEvents:UIControlEventTouchUpInside];
    
    [[gotoPersonalDetails layer] setBorderWidth:0.5f];
    
    [[gotoPersonalDetails layer] setBorderColor:myColor.CGColor];
    
    [[gotoPersonalDetails layer] setBackgroundColor:myColor.CGColor];
    
    [gotoPersonalDetails setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    
    gotoPersonalDetails.layer.cornerRadius = gotoPersonalDetails.frame.size.width / 2;
    
    gotoPersonalDetails.layer.borderWidth = 3.0f;
    
    gotoPersonalDetails.clipsToBounds = YES;
    
    
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 5 ){
        
        
        
        
        [gotoPersonalDetails setImage:[[UIImage imageNamed:@"ic_local_library"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]  forState:UIControlStateNormal];
        
        
    } else {
        
        
        [gotoPersonalDetails setImage:[[UIImage imageNamed:@"ic_restaurant"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]  forState:UIControlStateNormal];
        
        
        
    }
    
    
    [headerView bringSubviewToFront:gotoPersonalDetails];
    
    [headerView addSubview:gotoPersonalDetails];
    
    [self.tableView bringSubviewToFront:headerView];
    
    self.tableView.tableHeaderView = headerView;
    
    ingredients = [[NSArray alloc] initWithArray:[jsonObject objectForKey:@"ingridients"]];
    
    method = [[NSArray alloc] initWithArray:[jsonObject objectForKey:@"method"]];
    
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
        blurEffectView.frame =  CGRectMake(0, [UIScreen mainScreen].bounds.size.height , [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height  );
        
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        //[blurEffectView addSubview:[self addTable:mainTableView]];
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
        
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
        
        [blurEffectView addSubview:mainTableView];
        
        [self.view addSubview:blurEffectView];
        
        
        
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    if(tableView == mainTableView){
        
        return 4;
    }
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    
    
    
    
    if (tableView == mainTableView) {
        
        
        
        if(section == 0){
            
            
            return 1;
            
            
        }else if(section == 1){
            
            
            
            return [ingredients count];
            
            
        }else if(section == 2){
            
            
            
            
            return [method count];
            
            
        }
        
        else if(section == 3){
            
            return 2;
            
            
        }
    }
    
    
    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(tableView == mainTableView){
        
        return 50;
    }
    
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    
    
    if(tableView == mainTableView){
        
        UILabel *mainImage = [[UILabel alloc] initWithFrame:CGRectMake(10,10,tableView.frame.size.width - 20 , 50)];
        
        if(section == 0){
            
            mainImage.text = @"";
            
        }else if(section == 1){
            
            mainImage.text = @"Ingredients";
            
        }else if (section == 2){
            
            mainImage.text = @"Method";
            
        }else{
            
            mainImage.text = @"";
        }
        
        [view addSubview:mainImage];
        
        [view setBackgroundColor: [UIColor clearColor]];
        
        return view;
        
    }
    
    
    
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    if(tableView == mainTableView){
        
        
        if(indexPath.section == 0){
            
            
            cell.textLabel.text = [jsonObject objectForKey:@"description"];
            
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
            
            return cell;
            
        }
        else if (indexPath.section == 1) {
            
            
            cell.textLabel.text = [ingredients objectAtIndex:indexPath.row];
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
            return cell;
            
        }
        else if (indexPath.section == 2) {
            
            cell.textLabel.text = [method objectAtIndex:indexPath.row];
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
            return cell;
            
        }else if (indexPath.section == 3) {
            
            if(indexPath.row < 1){
                
                
                gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                gotoPersonalDetails.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
                
                [gotoPersonalDetails setTitle:@"Check Availability" forState:UIControlStateNormal];
                
                [gotoPersonalDetails.titleLabel setTextAlignment: NSTextAlignmentCenter];
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                gotoPersonalDetails.titleLabel.font = cellFont;
                
                [gotoPersonalDetails addTarget:self action:@selector(removeOverlay:) forControlEvents:UIControlEventTouchUpInside];
                
                [[gotoPersonalDetails layer] setBorderWidth:0.5f];
                
                [[gotoPersonalDetails layer] setBorderColor:myColor.CGColor];
                
                [gotoPersonalDetails setTitleColor:myColor forState:UIControlStateNormal];
                
                [cell.contentView addSubview:gotoPersonalDetails];
                
                
            } else {
                
                
                
                
            }
            
            
        }
        
        
        return cell;
        
    }
    
    if(indexPath.section == 0){
        
        
        cell.textLabel.text = [jsonObject objectForKey:@"name"];
        
        return cell;
        
    }else{
        
        
        
        cell.textLabel.text = [jsonObject objectForKey:@"description"];
        return cell;
    }
    
    
    
    return cell;
    
    
}

- (IBAction) removeOverlay:(id) sender

{
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    blurEffectView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height ,[UIScreen mainScreen].bounds.size.width ,0);
    
    [UIView commitAnimations];
    
}


- (IBAction) gotoDetailspage:(id) sender

{
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 2 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue ] == 3 ){
        
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:1];
        
        blurEffectView.frame=CGRectMake(0, 0 ,[UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height);
        
        [UIView commitAnimations];
        
        
        
    }else{
        
        
        
        
        NSLog(@"%@",[jsonObject objectForKey:@"pdf"] );
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
        
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:file password:nil];
        
        if (document != nil)
            
        {
            
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            readerViewController.delegate = self;
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            //[self presentModalViewController:readerViewController animated:YES];
            
            [self presentViewController:readerViewController animated:YES completion:nil];
            
            
        }
        
    }
    
    
}




- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

@end
