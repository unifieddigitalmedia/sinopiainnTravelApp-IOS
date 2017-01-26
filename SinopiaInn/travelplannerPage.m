//
//  travelplannerPage.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "travelplannerPage.h"

@interface travelplannerPage ()

@end

@implementation travelplannerPage


@synthesize mainTableView;
@synthesize checkAvailabilitybutton;
@synthesize myColor;
@synthesize sinopia;
@synthesize jsonbusinessTypesArray;
@synthesize jsonbusinessServiceArray;
@synthesize jsonbusinessPlacesArray;
@synthesize jsonArray;
@synthesize width;
@synthesize height;
@synthesize typesstring;
@synthesize servicestring;
@synthesize placesstring;

NSArray *typesArray ;

NSArray *imagesArray;


- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
    
}



- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight initWithtypes:(NSString*)types initWithservices:(NSString*)services initWithplaces:(NSString*)places initWithArray:(NSArray*)thejsonArray{
    
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    typesstring = types;
    
    servicestring = services;
    
    placesstring = places;
    
    jsonbusinessTypesArray = [[NSMutableArray alloc] init];
    
    jsonArray = thejsonArray;
    
    for (NSUInteger i = 0; i < [thejsonArray count]; i++) {
        
        NSArray *Array = [[NSArray alloc] init];
        
        Array = [[thejsonArray objectAtIndex:i] objectForKey:@"activity"];
        
        
        if([jsonbusinessTypesArray containsObject:[[Array objectAtIndex:0] objectForKey:@"typeofbusiness" ]])
        {
            
            
        }else  {
            
            [jsonbusinessTypesArray addObject:[[Array objectAtIndex:0] objectForKey:@"typeofbusiness" ]];
            
            
        }
        
        
    }
    
    
    return self;
    
    
    
}

- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight initWithArray:(NSArray*)thejsonArray{
    
    self = [super init];
    
    jsonbusinessTypesArray = [[NSMutableArray alloc] init];
    
    jsonArray = thejsonArray;
    
    for (NSUInteger i = 0; i < [thejsonArray count]; i++) {
        
        NSArray *Array = [[NSArray alloc] init];
        
        Array = [[thejsonArray objectAtIndex:i] objectForKey:@"activity"];
        
        
        if([jsonbusinessTypesArray containsObject:[[Array objectAtIndex:0] objectForKey:@"typeofbusiness" ]])
        {
            
            
        }else  {
            
            [jsonbusinessTypesArray addObject:[[Array objectAtIndex:0] objectForKey:@"typeofbusiness" ]];
            
            
        }
        
        
    }
    
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    typesArray = @[@"Culture" , @"Beaches", @"Event" , @"Food and Drink", @"Lesiure and Nightlife", @"Nightlife", @"Shopping"];
    
    imagesArray = @[@"ic_local_see" , @"ic_beach_access", @"ic_event_seat" , @"ic_restaurant", @"ic_local_activity" ,@"ic_favorite", @"ic_favorite"];
    
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _iconArray = [[NSMutableArray alloc] init];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    CGRect fullScreenRect=[[UIScreen mainScreen] bounds];
    
    UIView *rootView = [[UIView alloc] initWithFrame:fullScreenRect];
    
    rootView.backgroundColor = [UIColor redColor];
    
    rootView.opaque = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
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
    
    
    jsonbusinessPlacesArray = [[NSMutableArray alloc] init];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    if(section == 0){
        
        return 1;
        
    }
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if(indexPath.section == 0 ){
        
        
        UITextView *reservationerrormessage = [[UITextView alloc] initWithFrame:CGRectMake(0,cell.frame.size.height / 2 , cell.frame.size.width ,cell.frame.size.height )];
        
        reservationerrormessage.textAlignment = NSTextAlignmentCenter;
        
        myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
        
        reservationerrormessage.textColor = myColor;
        
        reservationerrormessage.text = @"Where would you like to go ? ";
        
        [reservationerrormessage setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        [cell.contentView addSubview:reservationerrormessage];
        
        
        return cell;
        
    }else{
        
        
        if(indexPath.row == 0 )
            
        {
            
            
            UITextField *rooms =  [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            rooms.rightViewMode = UITextFieldViewModeAlways;
            
            
            rooms.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            rooms.rightView.tintColor = myColor;
            
            rooms.placeholder = @"Select a special interest:";
            
            
            [rooms setBackgroundColor:[UIColor clearColor]];
            
            rooms.textColor = myColor;
            
            rooms.text = typesstring;
            
            [rooms setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            rooms.delegate = self;
            
            rooms.enabled = NO;
            
            [cell.contentView addSubview:[self addBorder:rooms]];
            
            return  cell;
            
            
        }
        
        else if(indexPath.row == 1 )
            
        {
            
            UITextField *phone =  [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            phone.rightViewMode = UITextFieldViewModeAlways;
            
            
            phone.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_room_service"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            phone.rightView.tintColor = myColor;
            
            
            phone.placeholder = @"Choose a type of service:";
            
            
            [phone setBackgroundColor:[UIColor clearColor]];
            
            phone.textColor = myColor;
            
            phone.text = servicestring;
            
            [phone setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            phone.delegate = self;
            
            phone.enabled = NO;
            
            [cell.contentView addSubview:[self addBorder:phone]];
            
            return  cell;
            
            
        } else if(indexPath.row == 2) {
            
            
            
            UITextField *email =  [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            email.rightViewMode = UITextFieldViewModeAlways;
            
            
            email.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_place"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            email.rightView.tintColor = myColor;
            
            
            email.placeholder = @"Add places of interest :";
            
            
            [email setBackgroundColor:[UIColor clearColor]];
            
            email.textColor = myColor;
            
            email.text = placesstring;
            
            [email setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            email.delegate = self;
            
            email.enabled = NO;
            
            [cell.contentView addSubview:[self addBorder:email]];
            
            
            return cell;
            
        }  else if(indexPath.row == 3 )
            
        {
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = @"... and thats it. Once youve confirmed a room, we'll add your trip to your bill";
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            
        }
        else if(indexPath.row == 4 )
            
        {
            
            checkAvailabilitybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            checkAvailabilitybutton.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
            
            [checkAvailabilitybutton setTitle:@"Check Availability" forState:UIControlStateNormal];
            
            [checkAvailabilitybutton.titleLabel setTextAlignment: NSTextAlignmentCenter];
            
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            checkAvailabilitybutton.titleLabel.font = cellFont;
            
            [checkAvailabilitybutton addTarget:self action:@selector(gotoPayment:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [[checkAvailabilitybutton layer] setBorderWidth:0.5f];
            
            [[checkAvailabilitybutton layer] setBorderColor:myColor.CGColor];
            
            [checkAvailabilitybutton setTitleColor:myColor forState:UIControlStateNormal];
            
            [cell.contentView addSubview:checkAvailabilitybutton];
            
            return  cell;
            
            
        }
        
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"optionSelected"];
    
    
    
    if( indexPath.section == 0){
        
        
        
    }else{
        
        if (indexPath.row == 0 ) {
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                
                
                
                for (NSUInteger i = 0; i < [jsonbusinessTypesArray count]; i++) {
                    
                    for (NSUInteger x = 0; x < [typesArray count]; x++) {
                        
                        
                        
                        if([[jsonbusinessTypesArray objectAtIndex:i] isEqualToString:[typesArray objectAtIndex:x]]){
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [_iconArray addObject:[imagesArray objectAtIndex:x]];
                                
                            });
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 1 ){
                        
                        id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
                        
                        
                        [parentViewController gotoOptionspageBWithimages:jsonbusinessTypesArray withImages:_iconArray];
                        
                    }else{
                        
                        id <guestContainer> parentViewController = (id)self.parentViewController;
                        
                        
                        [parentViewController gotoOptionspageBWithimages:jsonbusinessTypesArray withImages:_iconArray];
                        
                    }
                    
                    
                });
                
                
            });
            
            
            
            
            
        } else if (indexPath.row == 1 ) {
            
            
            
            jsonbusinessServiceArray = [[NSMutableArray alloc] init];
            
            
           /* if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 1 ){
                
                id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
                
                
                
                [parentViewController gotoOptionspage:jsonbusinessServiceArray];
                
                
            }else{
                
                id <guestContainer> parentViewController = (id)self.parentViewController;
                
                
                
                [parentViewController gotoOptionspage:jsonbusinessServiceArray];
                
                
            }*/
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                
                
                for (NSUInteger i = 0; i < [jsonArray count]; i++) {
                    
                    NSArray *Array = [[NSArray alloc] init];
                    
                    Array = [[jsonArray objectAtIndex:i] objectForKey:@"activity"];
                    
                    for (NSUInteger i = 0; i < [jsonbusinessTypesArray count]; i++) {
                        
                        if([[jsonbusinessTypesArray objectAtIndex:i] isEqualToString:[[Array objectAtIndex:0] objectForKey:@"typeofbusiness" ] ]){
                            
                            
                            
                            for (NSUInteger x = 0; x < [typesArray count]; x++) {
                                
                                
                                
                                if([[jsonbusinessTypesArray objectAtIndex:i] isEqualToString:[typesArray objectAtIndex:x]]){
                                    
                                    
                                    
                                    if([jsonbusinessServiceArray containsObject: [[Array objectAtIndex:0] objectForKey:@"typeofservice" ]])
                                        
                                    {
                                        
                                        
                                    }else  {
                                        
                                        [_iconArray addObject:[imagesArray objectAtIndex:x]];
                                        
                                        [jsonbusinessServiceArray addObject:[[Array objectAtIndex:0] objectForKey:@"typeofservice" ]];
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 1 ){
                        
                        id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
                        
                        
                        
                        [parentViewController gotoOptionspageBWithimages:jsonbusinessServiceArray withImages:_iconArray];
                        
                        
                    }else{
                        
                        id <guestContainer> parentViewController = (id)self.parentViewController;
                        
                        
                        
                        [parentViewController gotoOptionspageBWithimages:jsonbusinessServiceArray withImages:_iconArray];
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                });
                
                
            });
            
            
            
            
            
            
        }  else if( indexPath.row == 2 ) {
            
            
            
            
            for (NSUInteger i = 0; i < [jsonArray count]; i++) {
                
                NSArray *Array = [[NSArray alloc] init];
                
                Array = [[jsonArray objectAtIndex:i] objectForKey:@"activity"];
                
                for (NSUInteger i = 0; i < [parentViewController.serviceTypesArray count]; i++) {
                    
                    
                    if([[parentViewController.serviceTypesArray objectAtIndex:i] isEqualToString:[[Array objectAtIndex:0] objectForKey:@"typeofservice" ] ]){
                        
                        
                        if([jsonbusinessPlacesArray containsObject: [jsonArray objectAtIndex:i]])
                            
                        {
                            
                            
                        }else  {
                            
                            for (NSUInteger x = 0; x < [typesArray count]; x++) {
                                
                                
                                if([[[Array objectAtIndex:0] objectForKey:@"typeofbusiness" ] isEqualToString:[typesArray objectAtIndex:x]]){
                                    
                                    
                                    
                                    [_iconArray addObject:[imagesArray objectAtIndex:x]];
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                            [jsonbusinessPlacesArray addObject:[jsonArray objectAtIndex:i]];
                            
                            
                        }
                        
                    }
                    
                    
                }
                
                
                
            }
            
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] == 1 ){
                
                id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
                
                
                
                [parentViewController gotoOptionspageBWithimages:jsonbusinessPlacesArray withImages:_iconArray];
                
                
            }else{
                
                id <guestContainer> parentViewController = (id)self.parentViewController;
                
                
                
                [parentViewController gotoOptionspageBWithimages:jsonbusinessPlacesArray withImages:_iconArray];
                
                
                
            }
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
}


- (IBAction)gotoPayment:(id)sender {
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue]!= 0){
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        [parentViewController gotoReservationpage];
        
        
    }else{
        
        id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
        
        [parentViewController gotoReservationpage];
        
        
        
    }
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-110,320,460)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,320,460)];
}
@end
