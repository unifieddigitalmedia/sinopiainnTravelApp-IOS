//
//  LoginViewController.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "LoginViewController.h"
#import "checkedinguestContainer.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


@synthesize mainControllerOptions;
@synthesize checkAvailabilitybutton;
@synthesize topRootview;
@synthesize bottomRootview;
UITextField* roomsField;
@synthesize myColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view endEditing:YES];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    
    
    [self.navigationController setHidesBarsOnSwipe:YES];
    
    topRootview = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.frame.size.height/2)];
    
    bottomRootview = [[UIView alloc] initWithFrame:CGRectMake(0,topRootview.frame.size.height,self.view.bounds.size.width,self.view.frame.size.height/2)];
    
    topRootview.backgroundColor = [UIColor whiteColor];
    
    bottomRootview.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:topRootview];
    
    mainControllerOptions = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    
    mainControllerOptions.delegate = self;
    
    mainControllerOptions.dataSource = self;
    
    mainControllerOptions.bounces = NO;
    
    mainControllerOptions.scrollEnabled = YES;
    
    mainControllerOptions.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    mainControllerOptions.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    mainControllerOptions.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [bottomRootview  addSubview:mainControllerOptions];
    
    [self.view addSubview:bottomRootview];
    
    
    //self.view = rootView;
    
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
    
    
    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if(indexPath.row == 0 )
        
    {
        
        
        
        return  cell;
        
        
    }
    
    
    else if(indexPath.row == 1 )
        
    {
        
        
        roomsField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
        
        roomsField.placeholder = @"Please enter the check token you received in your email:";
        
        
        
        [roomsField setBackgroundColor:[UIColor clearColor]];
        
        
        roomsField.rightViewMode = UITextFieldViewModeAlways;
        
        
        roomsField.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_security"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        roomsField.rightView.tintColor = myColor;
        
        [roomsField setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        roomsField.delegate = self;
        
        [cell.contentView addSubview:[self addBorder:roomsField]];
        
        
        cell.backgroundColor = [UIColor clearColor];
        
        return  cell;
        
        
    }
    else if(indexPath.row == 2 )
        
    {
        
        checkAvailabilitybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        checkAvailabilitybutton.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
        
        [checkAvailabilitybutton setTitle:@"Check Availability" forState:UIControlStateNormal];
        
        [checkAvailabilitybutton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        checkAvailabilitybutton.titleLabel.font = cellFont;
        
        [checkAvailabilitybutton addTarget:self action:@selector(gotoHomepage:) forControlEvents:UIControlEventTouchUpInside];
        
        [[checkAvailabilitybutton layer] setBorderWidth:0.5f];
        
        [[checkAvailabilitybutton layer] setBorderColor:[UIColor blackColor].CGColor];
        
        [checkAvailabilitybutton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        
        [cell.contentView addSubview:checkAvailabilitybutton];
        
        return  cell;
        
        
    }
    
    return cell;
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    
    return [bottomRootview bounds].size.height / 4;
    
    
    
    
}

- (IBAction)gotoHomepage:(id)sender {
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/login"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSArray *Array = [[NSArray alloc] init];
        
        Array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            for (NSUInteger i = 0; i < [Array count]; i++) {
                
                
                if ([roomsField.text isEqualToString: [[Array objectAtIndex:i] objectForKey:@"token"]]) {
                    
                    
                    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"checkedIn"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:roomsField.text forKey:@"token"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[Array objectAtIndex:i] objectForKey:@"_id"] forKey:@"reservationID"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[Array objectAtIndex:i] objectForKey:@"fname"] forKey:@"fname"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[Array objectAtIndex:i] objectForKey:@"lname"] forKey:@"lname"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[Array objectAtIndex:i] objectForKey:@"fromdate"] forKey:@"fromdate"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[Array objectAtIndex:i] objectForKey:@"todate"] forKey:@"todate"];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ %@",[[Array objectAtIndex:i] objectForKey:@"fname"] ,[[Array objectAtIndex:i] objectForKey:@"lname"]] forKey:@"name"];
                    
                    
                    [self.navigationController pushViewController:[[checkedinguestContainer alloc] init] animated:YES];
                    
                }
                
                
                
            }
            
            
            
            
        });
        
        
    }];
    
    [dataTask resume];
    
    
    
    
    
    
    
}

-(UITextField*) addBorder:(UITextField*) textfield {
    
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor darkGrayColor].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height + 10, textfield.frame.size.width, borderWidth);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = YES;
    
    return textfield;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
