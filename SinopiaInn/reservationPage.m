//
//  reservationPage.m
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "reservationPage.h"



@interface reservationPage ()

@end

@implementation reservationPage
@synthesize width;
@synthesize height;


@synthesize mainTableView;
@synthesize mainButton;

@synthesize  resID;
@synthesize myColor;

@synthesize selectedroomlist;

@synthesize selectedofferslist;

@synthesize selectedaddonlist;

@synthesize roomsField;

@synthesize num_guest;

@synthesize fromdatestring;

@synthesize todatestring;

@synthesize roomsstring;

@synthesize offersstring;

@synthesize amenitiesstring;

@synthesize totalstring;

@synthesize todatepickerstring;
@synthesize fromdatepickerstring;


NSString *fromdate;

NSString *todate;




UITextView *checkoutdate;

UITextView *checkindate;

UITextField *FromDate;

UITextField *ToDate;

UIDatePicker *fromdateDatePicker;

UIDatePicker *todateDatePicker;

UIPickerView *ReservationNumofTravellers;

UITextField *NumofTravellers;

UITextField *Promo;

UITextView *reservationerrormessage ;

UIColor *myColor;

NSString *fullurl;

@synthesize SignUpTable;

@synthesize amenitiesField;

@synthesize offersField;

@synthesize str_addons;

@synthesize str_offers;

@synthesize str_rooms;

@synthesize num_days;

@synthesize gotoPersonalDetails;

@synthesize jsonRoomsArray;

@synthesize jsonAmenitiesArray;

@synthesize guestField;

- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight initWithFrom:(NSString*)fromdate initWithTo:(NSString*)todate initWithrooms:(NSString*)rooms initWithamenities:(NSString*)amenities {
    
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    fromdatestring = fromdate;
    
    todatestring = todate;
    
    roomsstring = rooms;
    
  
    amenitiesstring = amenities;
    
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
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,height) style:UITableViewStylePlain];

    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 44.0;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"room1.JPG"];
    
    [headerView addSubview:imageView];
    
    self.tableView.tableHeaderView = headerView;
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 3;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if(section == 0){
        
        
        return 1;
        
        
    }else if(section == 1){
        
        
        return 1;
        
        
    }
    
    return 8;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    if(indexPath.section == 0){

        reservationerrormessage = [[UITextView alloc] initWithFrame:CGRectMake(0,cell.frame.size.height / 2 , cell.frame.size.width ,cell.frame.size.height )];
        
        reservationerrormessage.textAlignment = NSTextAlignmentCenter;
        
        myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
        
        reservationerrormessage.textColor = myColor;
        
        reservationerrormessage.text = @"When would you like to stay with us ?";
        
        
        reservationerrormessage.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        
        [reservationerrormessage setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        [cell.contentView addSubview:reservationerrormessage];
        

        return cell;
        
    } else if (indexPath.section == 1){
        
        

        
        FromDate = [[UITextField alloc] initWithFrame:CGRectMake(10,5, cell.frame.size.width /2 - 20 ,cell.frame.size.height - 10)];
        
        FromDate.rightViewMode = UITextFieldViewModeAlways;
        
        UIImage *myImage = [UIImage imageNamed:@"ic_date_range"];
        
        myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        FromDate.rightView = [[UIImageView alloc] initWithImage:myImage];
        
        FromDate.rightView.tintColor = myColor;
        
        
        FromDate.placeholder = @"From:";
        
        FromDate.delegate = self;
        
        FromDate.text = fromdatestring;
        
        FromDate.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        
        FromDate.textAlignment = NSTextAlignmentLeft;
        
        
      
        
        [FromDate setBackgroundColor:[UIColor clearColor]];
        
        myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
        
        
        FromDate.textColor = myColor;
        
        
        [FromDate setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        fromdateDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/2)];
        
        [fromdateDatePicker setDatePickerMode:UIDatePickerModeDate];
        
        [FromDate setInputView:fromdateDatePicker];
        
        
        UIToolbar *toolbar =[[UIToolbar alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,cell.frame.size.height)];
        
        toolbar.barStyle = UIBarStyleDefault;
        
        
        UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(choosefrom:)];
        
        
        [toolbar setItems:@[doneButton]];
        
        
        [FromDate setInputAccessoryView:toolbar];
        
        
        [cell.contentView addSubview:[self addBorder:FromDate]];
        
   
        
        ToDate = [[UITextField alloc] initWithFrame:CGRectMake(FromDate.bounds.size.width + 20,5, cell.frame.size.width /2 - 20 ,cell.frame.size.height - 10)];
        
        
        ToDate.rightViewMode = UITextFieldViewModeAlways;
        
        
        ToDate.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_date_range"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        ToDate.rightView.tintColor = myColor;
        
        
        ToDate.placeholder = @"To:";
        
        
        ToDate.delegate = self;
        
        ToDate.text =  todatestring;
        
        ToDate.tag = 1;
        
        ToDate.textAlignment = NSTextAlignmentCenter;
        
        ToDate.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        
        
        ToDate.textAlignment = NSTextAlignmentLeft;
        
        
        [ToDate setBackgroundColor:[UIColor clearColor]];
        
        myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
        
        ToDate.textColor = myColor;
        
        
        [ToDate setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        todateDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/2)];
        
        [todateDatePicker setDatePickerMode:UIDatePickerModeDate];
        
        [ToDate setInputView:todateDatePicker];
        
        
        UIToolbar *toolbar1 =[[UIToolbar alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,cell.frame.size.height)];
        
        toolbar1.barStyle = UIBarStyleDefault;
        
        
        UIBarButtonItem *doneButton1 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(chooseto:)];
        
        
        [toolbar1 setItems:@[doneButton1]];
        
        
        [ToDate setInputAccessoryView:toolbar1];
        
        
        
        //[toview addSubview:ToDate];
        
        
        
        [cell.contentView addSubview:[self addBorder:ToDate]];

        return cell;
        
    }else {
        
       if(indexPath.row == 0 )
            
        {
            
            UITextField *rooms = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            rooms.rightViewMode = UITextFieldViewModeAlways;
            
            
            rooms.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_card_giftcard"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            rooms.rightView.tintColor = myColor;
        
            
            rooms.placeholder = @"Promo Code:";
            
            
            [rooms setBackgroundColor:[UIColor clearColor]];
            
            myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
            
            
            rooms.textColor = myColor;
            
            [rooms setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            rooms.delegate = self;
            
            
            [cell.contentView addSubview:[self addBorder:rooms]];
            
            return  cell;
            
            
        }
        else if(indexPath.row == 1 )
            
        {
            
            roomsField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            
            roomsField.rightViewMode = UITextFieldViewModeAlways;
            
            
            roomsField.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_hotel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            roomsField.rightView.tintColor = myColor;
        
            
            roomsField.placeholder = @"Choose a room:";
            
            
            [roomsField setBackgroundColor:[UIColor clearColor]];
            
            myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
            
            
            roomsField.text = roomsstring;
            
            
            roomsField.rightViewMode = UITextFieldViewModeAlways;
            
            roomsField.rightView.tintColor = myColor;
            
            roomsField.textColor = myColor;
            
            [roomsField setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            roomsField.delegate = self;
            
            roomsField.enabled = NO;
            
            
            [cell.contentView addSubview:[self addBorder:roomsField]];
            
            
            cell.backgroundColor = [UIColor clearColor];
            
            return  cell;
            
            
        }
        else if(indexPath.row == 2 )
            
        {
            
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = @"any available offers will be added at the checkout";
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            
            
            return  cell;
            
            
        }
        else if(indexPath.row == 3 )
            
        {
            amenitiesField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            
            amenitiesField.rightViewMode = UITextFieldViewModeAlways;
            
            
            amenitiesField.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_all_inclusive"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            amenitiesField.rightView.tintColor = myColor;
            
            
            amenitiesField.placeholder = @"Add an amenity:";
            
             
            [amenitiesField setBackgroundColor:[UIColor clearColor]];
            
            myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
            
            amenitiesField.text = amenitiesstring;
            
            amenitiesField.layer.borderColor = (__bridge CGColorRef _Nullable)(myColor);
            
            amenitiesField.textColor = myColor;
            
            amenitiesField.enabled = NO;
            
            [amenitiesField setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            amenitiesField.delegate = self;

            
            
            [cell.contentView addSubview:[self addBorder:amenitiesField]];
            
            
            cell.backgroundColor = [UIColor clearColor];
            
            
            return  cell;
            
            
        }
        else if(indexPath.row == 4 )
            
        {
            
          guestField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            guestField.rightViewMode = UITextFieldViewModeAlways;
            
            
            guestField.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_people_outline"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            guestField.rightView.tintColor = myColor;
            
            
            guestField.placeholder = @"How many guest can we expect ?";
            
            
            [guestField setBackgroundColor:[UIColor clearColor]];
            
            myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
            
            
            guestField.rightViewMode = UITextFieldViewModeAlways;
            
            guestField.rightView.tintColor = myColor;
            
            guestField.textColor = myColor;
            
            [guestField setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            guestField.delegate = self;
            
           
            
            ReservationNumofTravellers = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/2)];
            
            
            
            
            [ReservationNumofTravellers setDataSource: self];
            [ReservationNumofTravellers setDelegate: self];
            ReservationNumofTravellers.showsSelectionIndicator = YES;
        
            [guestField setInputView:ReservationNumofTravellers];
            
            
            UIToolbar *toolbar1 =[[UIToolbar alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,cell.frame.size.height)];
            
            toolbar1.barStyle = UIBarStyleDefault;
            
            
            UIBarButtonItem *doneButton1 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(returnGuest:)];
            
            
            [toolbar1 setItems:@[doneButton1]];
            
            
            [guestField setInputAccessoryView:toolbar1];
            
            [cell.contentView addSubview:[self addBorder:guestField]];
            
            
            cell.backgroundColor = [UIColor clearColor];
            
            
                       return  cell;
            
            
        }
        else if(indexPath.row == 5 )
            
        {
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            cell.textLabel.text = @"thats it you're ready to checkout";
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            return  cell;
            
            
        }
        else if(indexPath.row == 6 )
            
        {
            
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
    
    
    [parentViewController calculateTotal];

    
    [parentViewController gotoBill];
    
    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"optionSelected"];

   
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    
    if (indexPath.row == 1 ){
        
        
         NSLog(@"ROW %lu",(unsigned long)[parentViewController.validation[0] count]);
        
        if([parentViewController.validation[0] count] > 0 ){
            
              [parentViewController gotoOptionspage:parentViewController.validation[0]];
            
        }else{
            
            
              [self checkAvailability:fullurl];
            
        }
        

            
   
        
        
    }
        
        else if(indexPath.row == 3){
            
            
            
            
            if([parentViewController.validation count] > 2 ){
                
                
                if([parentViewController.validation[2] count] > 0 ){
                    
                    [parentViewController gotoOptionspage:parentViewController.validation[2]];

                    
                }
                
                
                
                
            }else{
                
                
                if([parentViewController.validation[1] count] > 0 ){
                    
                  [parentViewController gotoOptionspage:parentViewController.validation[1]];
                    
                    
                }
                
                
               
                
                
                
                
            }

            
            
         
            
        }
        else if(indexPath.row == 6){
            
            id <guestContainer> parentViewController = (id)self.parentViewController;
        
            [parentViewController calculateTotal];
            
      
            
            [parentViewController gotoBill];
            

        }
    
}


- (IBAction) chooseto:(id) sender

{
    
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result;
    
    result = [now compare:todateDatePicker.date];
    
    todatepickerstring = todateDatePicker.date;
    
    if(result == -1)
        
    {
        
        
        if([ todatepickerstring compare: fromdatepickerstring] == -1)
            
        {
            
            
            NSLog(@"fromdate os greater than to");
            
            
        }
        else
        {
            reservationerrormessage.text = @"";
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            
            [dateFormatter setDateFormat:@"EEE"];
            
            NSString *dayWk = [dateFormatter stringFromDate:todateDatePicker.date];
            
            
            [dateFormatter setDateFormat:@"MMM dd yyyy"];
            
            
            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            
            [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
            
            todate = [dateFormatter1 stringFromDate:todateDatePicker.date];
            
            todatestring = [NSString stringWithFormat:@"%@ , %@",dayWk,[dateFormatter stringFromDate:todateDatePicker.date]];
            
            id <guestContainer> parentViewController = (id)self.parentViewController;
            
            [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
            
    
            parentViewController.todate = [NSString stringWithFormat:@"%@",[dateFormatter1 stringFromDate:todateDatePicker.date]];
            
            [ToDate resignFirstResponder];
            
            [ToDate setPlaceholder:@" "];
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            
         
            [parentViewController calculateDateDifference:fromdatepickerstring todate:todatepickerstring];
            
            
            if(Promo.text == NULL){
                
                fullurl  = [[NSString stringWithFormat:@"http://www.sinopiainn.com/api/checkhotelavailability/?fromdate=%@&todate=%@&promo=&nights=%ld",fromdate,todate,(long)parentViewController.num_days] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                
            }else{
                
                fullurl  = [[NSString stringWithFormat:@"http://www.sinopiainn.com/api/checkhotelavailability/?fromdate=%@&todate=%@&promo=%@&nights=%ld",fromdate,todate,Promo.text,(long)parentViewController.num_days] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
          
            
                
            }
            
            NSLog(@"fullurl :- %@",fullurl);
            
            
            [self checkAvailability:fullurl];

            
        }
        
        
        
    }
    else
        
    {
        
        
        
        reservationerrormessage.text = @"Please choose a future check out date";
        
        [ToDate resignFirstResponder];
        
        
    }
    
    
    
    
    
    
    
    
}


- (IBAction) choosefrom:(id) sender

{
    
    fromdatestring = @"asdasdds";
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result;
    
    result = [now compare:fromdateDatePicker.date];
    
    fromdatepickerstring = fromdateDatePicker.date;
 
    if([now compare:fromdateDatePicker.date] == -1)
        
    {
        
        
        todatestring = @"Select Date";
        
        reservationerrormessage.text = @"";
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"EEE"];
        
        
        NSString *dayWk = [dateFormatter stringFromDate:fromdateDatePicker.date];
        
        [dateFormatter setDateFormat:@"MMM dd yyyy"];
        
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        
        [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
        
        fromdate = [dateFormatter1 stringFromDate:fromdateDatePicker.date];
        
        fromdatestring = [NSString stringWithFormat:@"%@ , %@",dayWk,[dateFormatter stringFromDate:fromdateDatePicker.date]];
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        
        [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
        
        parentViewController.fromdate = [NSString stringWithFormat:@"%@",[dateFormatter1 stringFromDate:fromdateDatePicker.date]];
        
      
        
        
        [FromDate resignFirstResponder];
        
        [FromDate setPlaceholder:@"" ];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];

        
    }
    
    else
        
    {
        
        
        if(result != NSOrderedDescending)
            
        {
            
            
            todatestring = @"Select Date";
            
            reservationerrormessage.text = @"";
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"EEE"];
            
            
            NSString *dayWk = [dateFormatter stringFromDate:fromdateDatePicker.date];
            
            [dateFormatter setDateFormat:@"MMM dd yyyy"];
            
            
            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            
            [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
            
            fromdate = [dateFormatter1 stringFromDate:fromdateDatePicker.date];
            
            fromdatestring = [NSString stringWithFormat:@"%@ , %@",dayWk,[dateFormatter stringFromDate:fromdateDatePicker.date]];
            
            id <guestContainer> parentViewController = (id)self.parentViewController;
            
            [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
            
            parentViewController.fromdate = [NSString stringWithFormat:@"%@",[dateFormatter1 stringFromDate:fromdateDatePicker.date]];
            
            [FromDate resignFirstResponder];
            
              [FromDate setPlaceholder:@"" ];
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            
            
            
            
            
        }
        else
            
        {
            
            
            reservationerrormessage.text = @"Please choose a future check in date";
            
            [FromDate resignFirstResponder];
            
            
        }
        
        
        
    }
    
    
}

- (IBAction) returnGuest:(id) sender

{
   [guestField resignFirstResponder]; 
    
}





- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 11;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component


{
    
    
    
    
    return [NSString stringWithFormat:@"%ld",(long)row];
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    guestField.text = [NSString stringWithFormat:@"%ld",(long)row];
    
    [guestField resignFirstResponder];
    
}


-(UITextField*) addBorder:(UITextField*) textfield {
    
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height + 10, textfield.frame.size.width, borderWidth);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = YES;
    
    return textfield;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)checkAvailability:(NSString*)initalDate{
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:initalDate] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        parentViewController.validation= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            if([parentViewController.validation count ]  > 2 ){
                
                [parentViewController returnedoffersArray:parentViewController.validation[1]];
                
                
            }
            
        });
        
        
    }];
    
    [dataTask resume];

    
    
}


-(NSString*) returnDateString:(NSString*)initalDate{
    
    NSString *datestring = @"";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    
    NSDate *date = [dateFormat dateFromString:initalDate];
    

    
    [dateFormat setDateFormat:@"EE, MMM dd yyyy"];
    
    
    datestring = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
    
    return datestring;
    
    
    
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
