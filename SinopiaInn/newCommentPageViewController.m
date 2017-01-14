//
//  newCommentPageViewController.m
//  SinopiaInnApp
//
//  Created by Machel Slack on 16/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "newCommentPageViewController.h"
#import "miscData.h"
#import "GuestBookViewController.h"


@interface newCommentPageViewController ()

@end

@implementation newCommentPageViewController


@synthesize width;
@synthesize height;
@synthesize jsonArray;
@synthesize sinopia_cell;
@synthesize nameTEXT;
@synthesize commentEXT;
@synthesize checkAvailabilitybutton;
@synthesize rating;
@synthesize mainScrollview;
@synthesize mainPagecontroller;

miscData *sharedManagerNewComment;


- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth {
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
  
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
     sharedManagerNewComment = [miscData sharedManager];
    
    _myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia_cell = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100.0;
    
   
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height/2)];
    
    
    mainScrollview =[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,width,height)];
    
    mainScrollview.backgroundColor=[UIColor blackColor];
    
    [mainScrollview setShowsHorizontalScrollIndicator:NO];
    
    [mainScrollview setShowsVerticalScrollIndicator:NO];
    
    mainScrollview.delegate=self;
    
    mainScrollview.pagingEnabled=YES;
    
    [mainScrollview setContentSize:CGSizeMake(mainScrollview.frame.size.width*4, mainScrollview.frame.size.height)];
    
    mainPagecontroller = [[UIPageControl alloc]initWithFrame: CGRectMake(0,0,mainScrollview.frame.size.width,200)];
    
    
    [mainPagecontroller setCurrentPageIndicatorTintColor:_myColor];
    
    mainPagecontroller.numberOfPages = 4;
    
    mainPagecontroller.currentPage = 0;
    
    
    [headerView addSubview:mainPagecontroller];
    
    
    
    for(int i=0;i < 6 ; i++)
        
    {
        
        CGRect frame;
        
        frame.origin.x = mainScrollview.frame.size.width * i;
        
        frame.origin.y = 0;
        
        frame.size =  mainScrollview.frame.size;
        
       
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(mainScrollview.frame.origin.x, mainScrollview.frame.origin.y, mainScrollview.frame.size.width, mainScrollview.frame.size.height)];
        
        imageView.image = [UIImage imageNamed:@"sinopia_inn.png"];
        
        [mainScrollview addSubview:imageView];
        
        
        
    }
    
    //[headerView addSubview:mainScrollview];
    
    
    
    
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


        
        return 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if(indexPath.section == 0 ){
        
        UITextField *rooms = [[UITextField alloc] initWithFrame:CGRectMake(10,5,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
        
        rooms.rightViewMode = UITextFieldViewModeAlways;
        
        
        rooms.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        rooms.rightView.tintColor = _myColor;
        
        
        rooms.placeholder = @"Name:";
        
        rooms.text = nameTEXT;
        
        
        
        [rooms setBackgroundColor:[UIColor clearColor]];
        
        rooms.textColor = _myColor;
        
        [rooms setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        rooms.tag = indexPath.row;
        
        rooms.delegate = self;
        
        
        
        [cell.contentView addSubview:[self addBorder:rooms]];
        
    } else if(indexPath.section == 1){
        
        UIFont *cellFont = [UIFont fontWithName:@"Arial-BoldMT" size:14];
        
        cell.textLabel.font = cellFont;
        
        cell.textLabel.text =  @"Please give a rating out of five" ;
        
    } else if(indexPath.section == 2){
        
        
        UIImage *btnImage = [UIImage imageNamed:@"ic_star_border"];
        
        UIButton *star1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       
        star1.tintColor  = _myColor;

        star1.frame = CGRectMake(0,0,cell.frame.size.width / 5 , cell.frame.size.height);
        
        [star1 setImage:btnImage forState:UIControlStateNormal];
    
        [star1 setTag:1];
        
        [star1 addTarget:self action:@selector(setRating:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.contentView addSubview:star1];
        
        
        
        UIButton *star2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        star2.tintColor  = _myColor;
        
        star2.frame = CGRectMake(star1.frame.origin.x + star1.frame.size.width, cell.frame.size.height / 2 - (star1.frame.size.height / 2 ),cell.frame.size.width / 5 , cell.frame.size.height);
        
        [star2 setImage:btnImage forState:UIControlStateNormal];
        
        [star2 setTag:2];
        
        [star2 addTarget:self action:@selector(setRating:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.contentView addSubview:star2];
        
        
        
        UIButton *star3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        star3.tintColor  = _myColor;
        
        star3.frame = CGRectMake(star2.frame.origin.x + star1.frame.size.width, cell.frame.size.height / 2 - (star1.frame.size.height / 2 ) ,cell.frame.size.width / 5 , cell.frame.size.height);
        
        [star3 setImage:btnImage forState:UIControlStateNormal];
        
        [star3 setTag:3];
        
        [star3 addTarget:self action:@selector(setRating:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.contentView addSubview:star3];
        
        
        
        UIButton *star4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        star4.tintColor  = _myColor;
        
        star4.frame = CGRectMake(star3.frame.origin.x + star1.frame.size.width,cell.frame.size.height / 2 - (star1.frame.size.height / 2 ),cell.frame.size.width / 5 , cell.frame.size.height);
        
        [star4 setImage:btnImage forState:UIControlStateNormal];
        
        [star4 setTag:4];
        
        [star4 addTarget:self action:@selector(setRating:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.contentView addSubview:star4];
        
        
        
        UIButton *star5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        star5.tintColor  = _myColor;
        
        star5.frame = CGRectMake(star4.frame.origin.x + star1.frame.size.width,cell.frame.size.height / 2 - (star1.frame.size.height / 2 ),cell.frame.size.width / 5 , cell.frame.size.height);
        
        [star5 setImage:btnImage forState:UIControlStateNormal];
        
        [star5 setTag:5];
        
        [star5 addTarget:self action:@selector(setRating:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.contentView addSubview:star5];
        
        
        
        return cell;
        
    }else if(indexPath.section == 3){
        
        
        
        UITextField *rooms = [[UITextField alloc] initWithFrame:CGRectMake(10,5,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
        
        rooms.rightViewMode = UITextFieldViewModeAlways;
        
        
        rooms.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        rooms.rightView.tintColor = _myColor;
        
        
        rooms.placeholder = @"Comment:";
        
        rooms.text = commentEXT;
        
        
        
        [rooms setBackgroundColor:[UIColor clearColor]];
        
        rooms.textColor = _myColor;
        
        [rooms setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        rooms.tag = indexPath.row + 1;
        
        rooms.delegate = self;
        
        
        [cell.contentView addSubview:[self addBorder:rooms]];
        
        return cell;

        
        
    }else if(indexPath.section == 4){
        
     
            
            checkAvailabilitybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            checkAvailabilitybutton.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
            
            [checkAvailabilitybutton setTitle:@"Post Your Review" forState:UIControlStateNormal];
            
            [checkAvailabilitybutton.titleLabel setTextAlignment: NSTextAlignmentCenter];
            
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            checkAvailabilitybutton.titleLabel.font = cellFont;
            
            [checkAvailabilitybutton addTarget:self action:@selector(postReview:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [[checkAvailabilitybutton layer] setBorderWidth:0.5f];
            
            [[checkAvailabilitybutton layer] setBorderColor:_myColor.CGColor];
            
            [checkAvailabilitybutton setTitleColor:_myColor forState:UIControlStateNormal];
            
            [cell.contentView addSubview:checkAvailabilitybutton];
            
            return cell;
      
        
        
        
    }

    
    return cell;
}



- (IBAction) setRating:(id) sender

{
    
    
    
    UIButton *btn = (UIButton *)sender;
    
    [btn setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
    
   NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"CELL TAG : - %ld",(long)[sender tag]);
    

    UIButton *BTN1 = (UIButton*)[cell.contentView viewWithTag:1];
    UIButton *BTN2 = (UIButton*)[cell.contentView viewWithTag:2];
    UIButton *BTN3 = (UIButton*)[cell.contentView viewWithTag:3];
    UIButton *BTN4 = (UIButton*)[cell.contentView viewWithTag:4];
    UIButton *BTN5 = (UIButton*)[cell.contentView viewWithTag:5];

 
    
    
    if([sender tag] == 1){
        
        [BTN1 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN2 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        [BTN3 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        [BTN4 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        [BTN5 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
   
        
        
    } else if ([sender tag] == 2){
        
        
        [BTN1 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN2 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN3 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        [BTN4 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        [BTN5 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        
    }else if ([sender tag] == 3 ){
        
        [BTN1 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN2 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN3 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN4 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        [BTN5 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        
        
    }else if ([sender tag] == 4 ){
        
        [BTN1 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN2 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN3 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN4 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN5 setImage:[UIImage imageNamed:@"ic_star_border"] forState:UIControlStateNormal];
        
        
    }else if ([sender tag] == 5 ){
        
        
        [BTN1 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN2 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN3 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN4 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        [BTN5 setImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateNormal];
        
    }
    
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    sectionName = @" ";
    
    return sectionName;
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



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.tag != 1){
    
        [textField resignFirstResponder];
        
    }
    return YES;
}

-(NSString*) returnDateString{
    
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    return [dateFormat stringFromDate:now];
    
    
    
}


- (IBAction) postReview:(id) sender

{
    
    NSString *url = [NSString stringWithFormat:@"http://www.sinopiainn.com/api/reviews/?name=%@&date=%@&rating=%d&comment=%@",nameTEXT,[self returnDateString],rating,commentEXT];
                     
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
          [sharedManagerNewComment getCommentfiles];
        
       // NSArray *RESULT = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
                    
                    
                    [parentViewController goToReviews];
                 

                    
                });
    
        
        
    }];
    
    [dataTask resume];
    
    
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
