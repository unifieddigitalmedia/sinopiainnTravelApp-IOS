//
//  ViewController.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "ViewController.h"

#import "guestContainerViewController.h"
#import "LoginViewController.h"
#import "checkedinguestContainer.h"

@interface ViewController ()

@end

@implementation ViewController


@synthesize mainControllerOptions;
@synthesize checkAvailabilitybutton;
@synthesize topRootview;
@synthesize bottomRootview;
@synthesize myColor;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sinopia_inn.png"]];
    
    topRootview = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.frame.size.height/3)];
    
    bottomRootview = [[UIView alloc] initWithFrame:CGRectMake(0,topRootview.frame.size.height,self.view.bounds.size.width,(self.view.frame.size.height/3)*2)];
    
    topRootview.backgroundColor = [UIColor clearColor];
    
    bottomRootview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:topRootview];
    
    mainControllerOptions = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    
    mainControllerOptions.delegate = self;
    
    mainControllerOptions.dataSource = self;
    
    mainControllerOptions.bounces = NO;
    
    mainControllerOptions.scrollEnabled = YES;
    
    mainControllerOptions.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    mainControllerOptions.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    mainControllerOptions.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    mainControllerOptions.rowHeight = UITableViewAutomaticDimension;
    
    mainControllerOptions.estimatedRowHeight = 44.0;
    
    mainControllerOptions.backgroundColor = [UIColor clearColor];
    
    [bottomRootview  addSubview:mainControllerOptions];
    
    [self.view addSubview:bottomRootview];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    
    return 4;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row == 0 )
        
    {
        
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"WELCOME TO SINOPIA INN";
        
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:28.0];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.backgroundColor = [UIColor clearColor];
        
        return  cell;
        
        
    }
    
    else if(indexPath.row == 1 )
        
    {
        
        
        checkAvailabilitybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        checkAvailabilitybutton.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
        
        [checkAvailabilitybutton setTitle:@"CHECK IN" forState:UIControlStateNormal];
        
        [checkAvailabilitybutton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        checkAvailabilitybutton.titleLabel.font = cellFont;
        
        [checkAvailabilitybutton addTarget:self action:@selector(gotoCheckin:) forControlEvents:UIControlEventTouchUpInside];
        
        [[checkAvailabilitybutton layer] setBorderWidth:0.5f];
        
        [[checkAvailabilitybutton layer] setBorderColor:myColor.CGColor];
        
        [checkAvailabilitybutton setTitleColor:myColor forState:UIControlStateNormal];
        
        cell.backgroundColor = [UIColor clearColor];
        
        
        [cell.contentView addSubview:checkAvailabilitybutton];
        
        
        return  cell;
        
        
    }
    else if(indexPath.row == 2 )
        
    {
        
        [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        cell.textLabel.text = @"- OR - ";
        
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.backgroundColor = [UIColor clearColor];
        
        
        return  cell;
        
        
    }
    else if (indexPath.row == 3 ){
        
        
        
        
        checkAvailabilitybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        checkAvailabilitybutton.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
        
        [checkAvailabilitybutton setTitle:@"CONTINUE" forState:UIControlStateNormal];
        
        [checkAvailabilitybutton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        checkAvailabilitybutton.titleLabel.font = cellFont;
        
        [checkAvailabilitybutton addTarget:self action:@selector(gotoHomepage:) forControlEvents:UIControlEventTouchUpInside];
        
        [[checkAvailabilitybutton layer] setBorderWidth:0.5f];
        
        [[checkAvailabilitybutton layer] setBorderColor: [UIColor clearColor].CGColor];
        
        [checkAvailabilitybutton setTitleColor:myColor  forState:UIControlStateNormal];
        
        cell.backgroundColor = [UIColor clearColor];
        
        
        [cell.contentView addSubview:checkAvailabilitybutton];
        
        
    }
    
    return cell;
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if(indexPath.row == 2 ){
        
        
        return ([bottomRootview bounds].size.height / 5)/2;
        
        
    }
    
    return [bottomRootview bounds].size.height / 5;
    
    
    
    
}



- (IBAction)gotoCheckin:(id)sender {
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/login"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSArray *Array = [[NSArray alloc] init];
        
        Array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            for (NSUInteger i = 0; i < [Array count]; i++) {
                
                
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] isEqualToString: [[Array objectAtIndex:i] objectForKey:@"token"]]) {
                    
                    
                    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"checkedIn"];
                    
                    
                    
                }
                
                
                
            }
            
            
            
            
        });
        
        
    }];
    
    [dataTask resume];
    
    
    if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] != 0 ){
        
        
        
        checkedinguestContainer *checkinPage = [[checkedinguestContainer alloc] init];
        
        [self.navigationController pushViewController:checkinPage animated:YES];
        
    }else {
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"checkedIn"];
        
        LoginViewController *checkinPage = [[LoginViewController alloc] init];
        
        [self.navigationController pushViewController:checkinPage animated:YES];
        
        
    }
    
    
    
    
    
    
}


- (IBAction)gotoHomepage:(id)sender {
    
    
    NSLog(@"back button pressed");
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"checkedIn"];
    
    guestContainerViewController *homePage = [[guestContainerViewController alloc] init];
    
    [self.navigationController pushViewController:homePage animated:YES];
    
    
}
- (IBAction)backbuttonpressed:(id)sender {
    
    NSLog(@"back button pressed");
    
    
}



@end
