//
//  BigPhotoViewController.m
//  SinopiaInn
//
//  Created by Machel Slack on 26/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "BigPhotoViewController.h"
#import "checkedinguestContainer.h"

@interface BigPhotoViewController ()

@end

@implementation BigPhotoViewController
@synthesize mainButton;
@synthesize width;
@synthesize height;
@synthesize myColor;
@synthesize sinopia;
@synthesize messageField;
@synthesize locationField;
@synthesize messageString;
@synthesize locationString;
@synthesize jpeg;
@synthesize mainTableView;
@synthesize mainScrollview;
@synthesize mainPagecontroller;
@synthesize message;
@synthesize sendBtn;
@synthesize jpgDict;
- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithObject:(UIImage*)thejpeg{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jpeg = thejpeg;
    
    return self;
}

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSArray*)theArray{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jpgDict = theArray;
    
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
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
    
    //[mainScrollview addSubview:mainTableView];
    
    [self.view addSubview:mainTableView];
    
    NSLog(@"siz eof array %lu",(unsigned long)[jpgDict count]);
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
    CGFloat viewWidth = mainScrollview.frame.size.width;
    // content offset - tells by how much the scroll view has scrolled.
    
    int pageNumber = floor((mainScrollview.contentOffset.x - viewWidth/50) / viewWidth) +1;
    
    mainPagecontroller.currentPage=pageNumber;
    
}

- (void)pageChanged {
    
    long pageNumber = mainPagecontroller.currentPage;
    
    CGRect frame = mainScrollview.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [mainScrollview scrollRectToVisible:frame animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 3;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0 ){
        
        
        
        //cell.imageView.image =  [jpgDict objectAtIndex:0] ;
        
        //cell.textLabel.text = @"Write a caption.";
        
        /* messageField = [[UITextField alloc] initWithFrame:CGRectMake(cell.imageView.frame.origin.x + cell.imageView.frame.size.width + 10,10, cell.frame.size.width - (cell.imageView.frame.origin.x + cell.imageView.frame.size.width + 10) , cell.frame.size.height - 10)];
         
         
         messageField.leftViewMode = UITextFieldViewModeAlways;
         
         
         messageField.leftView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_all_inclusive"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
         
         messageField.leftView.tintColor = myColor;
         
         
         messageField.placeholder = @"Write a caption:";
         
         
         [messageField setBackgroundColor:[UIColor clearColor]];
         
         myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
         
         messageField.text = messageString;
         
         messageField.layer.borderColor = (__bridge CGColorRef _Nullable)(myColor);
         
         messageField.textColor = myColor;
         
         messageField.enabled = YES;
         
         
         [messageField setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
         
         messageField.delegate = self;
         
         
         [cell.contentView addSubview:messageField ];*/
        
        return  cell;
        
        
        
    }
    else if(indexPath.section == 1 )
        
    {
        
        
        
        locationField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
        
        
        locationField.leftViewMode = UITextFieldViewModeAlways;
        
        
        locationField.leftView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_place"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        locationField.leftView.tintColor = myColor;
        
        
        locationField.placeholder = @"Add a location:";
        
        
        [locationField setBackgroundColor:[UIColor clearColor]];
        
        myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
        
        
        locationField.text = locationString;
        
        
        locationField.leftViewMode = UITextFieldViewModeAlways;
        
        locationField.leftView.tintColor = myColor;
        
        locationField.textColor = myColor;
        
        [locationField setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        locationField.delegate = self;
        
        locationField.enabled = NO;
        
        
        [cell.contentView addSubview:[self addBorder:locationField]];
        
        
        
        return  cell;
        
        
    }
    
    else if(indexPath.section == 2 )
        
    {
        
        mainButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        mainButton.tag = tableView.tag;
        
        mainButton.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
        
        [mainButton setTitle:[[jpgDict objectAtIndex:mainButton.tag] objectForKey:@"text" ] forState:UIControlStateNormal];
        
        [mainButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        
        mainButton.titleLabel.font = cellFont;
        
        //[mainButton addTarget:self action:@selector(gotoOptionpage:) forControlEvents:UIControlEventTouchUpInside];
        
        [[mainButton layer] setBorderWidth:0.5f];
        
        [[mainButton layer] setBorderColor:myColor.CGColor];
        
        [mainButton setTitleColor:myColor forState:UIControlStateNormal];
        
        [cell.contentView addSubview:mainButton];
        
        
        return  cell;
        
        
    }
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 ){
        
        
    }else{
        
        
        if(indexPath.row == 0 ){
            
            id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
            
            [parentViewController gotoMap];
            
        }
    }
    
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    sectionName = @" ";
    
    return sectionName;
}

- (IBAction)uploadPhoto:(id)sender {
    
    id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
    
    [parentViewController uploadSnap:messageString withLocation:locationString];
    
    
    
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
    
    if(indexPath.section == 0 ){
        
        return 100;
    }
    return 50;
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField {
    
    
    
    NSLog(@"TEXTFIELD TAG : %ld",(long)textField.tag);
    
    if(textField.tag == 0)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:1];
        
        UITableViewCell* cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        locationString = t.text;
        
    }
    else if(textField.tag == 1)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:1];
        
        UITableViewCell* cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        messageString = t.text;
        
    }
    
    
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
