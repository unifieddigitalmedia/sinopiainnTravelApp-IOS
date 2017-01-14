//
//  confirmationPage.m
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "confirmationPage.h"
#import "miscData.h"
#import "checkedinguestContainer.h"


@interface confirmationPage ()

@end

@implementation confirmationPage

@synthesize width;
@synthesize height;
@synthesize gotoPersonalDetails;
@synthesize HomePageToolbar;
@synthesize myColor;
@synthesize sinopia;
@synthesize fromdatestringConfirm;

@synthesize todatestringConfirm;

NSArray *imagesConfirm;

NSArray *menuItems;

@synthesize FromDate;
@synthesize ToDate;


UIColor *myColor_confirmation;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    imagesConfirm = @[@"ic_logo" , @"ic_watch_later" , @"ic_cloud", @"ic_restaurant",@"ic_airport_shuttle" , @"ic_bookmark", @"ic_local_library",@"ic_theaters" , @"ic_email", @"ic_email" ];
    
    menuItems = @[@"Our Villa" , @"Local Time", @"Local Weather",@"Menu" , @"Trip Planner", @"Bookshelf",@"Guest Book" , @"Channels" ];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    fromdatestringConfirm = [self returnDateString:[[NSUserDefaults standardUserDefaults] objectForKey:@"fromdate"]];
    
    todatestringConfirm = [self returnDateString:[[NSUserDefaults standardUserDefaults] objectForKey:@"todate"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
   
    self.tableView.dataSource = self;
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100.0;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    myColor_confirmation = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"weekender.jpg"];
    
    [headerView addSubview:imageView];
    
    self.tableView.tableHeaderView = headerView;
    
    //[self.view addSubview:self.mainTableView];

    
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

- (IBAction)gotoDetailspage:(id)sender {
  
    id <checkedinguestContainer > parentViewController = (id)self.parentViewController;
    
    
        
        [parentViewController showmenu];
        
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 3;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if(section != 2){
        
        
        return 1;
        
        
    }
    
    return 9;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    

    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
   
    
    cell.imageView.tintColor = myColor;
    
    tableView.tintColor = myColor;
    
    
    if(indexPath.section == 0){
        
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FromDate = [[UITextField alloc] initWithFrame:CGRectMake(10,5, cell.frame.size.width /2 - 20 ,cell.frame.size.height - 10)];
        
        FromDate.rightViewMode = UITextFieldViewModeAlways;
        
        UIImage *myImage = [UIImage imageNamed:@"ic_date_range"];
        
        //myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        FromDate.rightView = [[UIImageView alloc] initWithImage:myImage];
        
        //FromDate.rightView.tintColor = myColor;
        
        
          FromDate.enabled = false;
        
    
        FromDate.text = fromdatestringConfirm;
        
        FromDate.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        
        FromDate.textAlignment = NSTextAlignmentLeft;
        
        
        
        
        [FromDate setBackgroundColor:[UIColor clearColor]];
        
        myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
        
        
        //FromDate.textColor = myColor;
        
        
        [FromDate setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
      
        
        [cell.contentView addSubview:[self addBorder:FromDate]];
        
        
        
        ToDate = [[UITextField alloc] initWithFrame:CGRectMake(FromDate.bounds.size.width + 20,5, cell.frame.size.width /2 - 20 ,cell.frame.size.height - 10)];
        
        
        ToDate.rightViewMode = UITextFieldViewModeAlways;
        
        
        ToDate.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_date_range"] ];
        
        //ToDate.rightView.tintColor = myColor;
        
        
        
        ToDate.enabled = false;
    
        ToDate.text =  todatestringConfirm;
        
        ToDate.tag = 1;
        
        ToDate.textAlignment = NSTextAlignmentCenter;
        
        ToDate.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        
        
        ToDate.textAlignment = NSTextAlignmentLeft;
        
        
        [ToDate setBackgroundColor:[UIColor clearColor]];
        
        myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
        
        //ToDate.textColor = myColor;
        
        
        [ToDate setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        
        
        [cell.contentView addSubview:[self addBorder:ToDate]];
        

    
        return cell;
        
    } else if (indexPath.section == 1){
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        HomePageToolbar  = [[UIToolbar alloc] initWithFrame:CGRectMake(5,0 ,cell.frame.size.width - 10 ,cell.frame.size.height  )];
        
        HomePageToolbar.backgroundColor = [UIColor whiteColor];

       //HomePageToolbar.tintColor = [UIColor whiteColor];
        
        HomePageToolbar.barTintColor = [UIColor whiteColor];

        UIButton *HomePageCalButton = [[UIButton alloc] initWithFrame:CGRectMake(0,10,self.view.frame.size.width/3,HomePageToolbar.frame.size.height  )];
        
        [HomePageCalButton setTitle:@"CONTACT" forState:UIControlStateNormal];
        
        [HomePageCalButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        HomePageCalButton.titleLabel.font = cellFont;
        
        [HomePageCalButton addTarget:self action:@selector(gotoChat:) forControlEvents:UIControlEventTouchUpInside];
        
        [[HomePageCalButton layer] setBorderWidth:0.0f];
        
        [[HomePageCalButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        [HomePageCalButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        
        //HomePageCalButton.tintColor = myColor;
        
        [HomePageCalButton setImage: [[UIImage imageNamed:@"ic_record_voice_over"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        HomePageCalButton.backgroundColor = [UIColor whiteColor];
        
        HomePageCalButton.tintColor  = myColor;
        
        [HomePageToolbar addSubview:[self designButtonwithText:HomePageCalButton]];
        
        
        UIButton *HomePageAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageCalButton.frame.size.width,10,self.view.frame.size.width/3,HomePageToolbar.frame.size.height )];
        
        
        [HomePageAccountButton addTarget:self action:@selector(gotoMap:) forControlEvents:UIControlEventTouchUpInside];
        
       HomePageAccountButton.tintColor  = myColor;

        [HomePageAccountButton setTitle:@"MAP" forState:UIControlStateNormal];
        
        [[HomePageAccountButton layer] setBorderWidth:0.5f];
        
        HomePageAccountButton.titleLabel.font = cellFont;
        
        [[HomePageAccountButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        [HomePageAccountButton setTitleColor:[UIColor blackColor]   forState:UIControlStateNormal];
        
        [HomePageAccountButton setImage: [[UIImage imageNamed:@"ic_map"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
 forState:UIControlStateNormal];
        
        HomePageAccountButton.backgroundColor = [UIColor whiteColor];
       
        
        [HomePageToolbar addSubview:[self designButtonwithText:HomePageAccountButton]];
        
        UIButton *HomePageHelpButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageAccountButton.frame.origin.x + HomePageAccountButton.frame.size.width,10,self.view.frame.size.width/3,HomePageToolbar.frame.size.height  )];
        
        [HomePageHelpButton setTitle:@"PHOTOS" forState:UIControlStateNormal];
        
        HomePageHelpButton.titleLabel.font = cellFont;
        
        [[HomePageHelpButton layer] setBorderWidth:0.5f];
        
        HomePageHelpButton.titleLabel.font = cellFont;
        
        //[[HomePageHelpButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        
        [HomePageHelpButton addTarget:self action:@selector(gotoPhotos:) forControlEvents:UIControlEventTouchUpInside];
        
        [[HomePageHelpButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
        [HomePageHelpButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        
        [HomePageHelpButton setImage:[[UIImage imageNamed:@"ic_photo_library"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        HomePageHelpButton.backgroundColor = [UIColor whiteColor];
    
         HomePageHelpButton.tintColor  = myColor;
        
        [HomePageToolbar addSubview:[self designButtonwithText:HomePageHelpButton]];
        
        [cell.contentView addSubview:HomePageToolbar];
        
      
        
        return  cell;
        
    } else if( indexPath.section == 2){
        
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        if(indexPath.row != 8){
            
            
            cell.imageView.image = [UIImage imageNamed:[imagesConfirm objectAtIndex:indexPath.row]];
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = [menuItems objectAtIndex:indexPath.row ] ;
            
            cell.textLabel.numberOfLines = 0;
            
            cell.backgroundColor = [UIColor clearColor];
            
            return  cell;
            

            
            
        }else{
            
           // cell.imageView.image = [[UIImage imageNamed:[imagesConfirm objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
           
            
            cell.accessoryType = UITableViewCellAccessoryNone;

            return cell;
            
        }
        
    
        
    }
    
    
    
    return cell;
    
    
}

-(UIButton*) designButtonwithText:(UIButton*) button  {
    
    
    
    CGFloat spacing = 6.0;
    
    
    CGSize imageSize = button.imageView.image.size;
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
    
    button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 10.0, edgeOffset, 0.0);
    
    return button;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"optionPage"];
    
    if(indexPath.section == 2 ){
        
        
        if(indexPath.row == 0){
            
         
            [parentViewController gottoOurVilla];
            
        }
        else if (indexPath.row == 1 ){
            
        
        
            
            [parentViewController gotoTime];
            
        }
        else if (indexPath.row == 2 ){
            
            
            
            [parentViewController goToWeather];
        
        
        }
        else if (indexPath.row == 3 ){
            
            
             [parentViewController gotoMenu];
            
            
                  }
        else if (indexPath.row == 4 ){
            
            
            [parentViewController gotoTravel];

        }
        else if (indexPath.row == 5 ){
            [parentViewController gotoBooks];
            
            
        }
        else if (indexPath.row == 6 ){
            
            [parentViewController goToReviews];
            
        }
        else if (indexPath.row == 7 ){
            
            
            [parentViewController gotoChannels];
        }
        else if (indexPath.row == 8 ){
            
            
            
        }

        
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;

            sectionName = @" ";
 
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

- (IBAction) gotoChat:(id) sender

{
  
    
}


- (IBAction) gotoMap:(id) sender

{
   
    
    id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
    
    [parentViewController gotoMap];
    
    
    
}


- (IBAction) gotoPhotos:(id) sender

{
    id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
    
    miscData *sharedManager = [miscData sharedManager];
    
    
    if(sharedManager.picturefiles == 0 ){
        
        
        [NSThread sleepForTimeInterval:5.0];
        
        [parentViewController gotPhotos:sharedManager.imageFiles];

    }
    else{
        
        [parentViewController gotPhotos:sharedManager.imageFiles];

        
    }
   
    //NSLog(@"photos %hhu", sharedManager.picturefiles);
    
    
}


@end
