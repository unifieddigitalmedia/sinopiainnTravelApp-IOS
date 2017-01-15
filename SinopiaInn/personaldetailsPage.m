//
//  personaldetailsPage.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "personaldetailsPage.h"

@interface personaldetailsPage ()

@end

@implementation personaldetailsPage
@synthesize  emailTEXT;

@synthesize  phoneTEXT;
@synthesize width;

@synthesize height;
@synthesize  nameTEXT;
@synthesize mainTableView;
@synthesize checkAvailabilitybutton;
@synthesize myColor;
@synthesize personaldetailserror;
@synthesize gotoPersonalDetails;
@synthesize imageView;

- (id)initWithHeight:(int)thewidth initWithWidth:(int)theheight{
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    
    
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width,height) style:UITableViewStylePlain];
    
    self.tableView.bounces = NO;
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100.0;
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"sinopia_inn.png"];
    
    
    [headerView addSubview:imageView];
    
    gotoPersonalDetails = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    gotoPersonalDetails.frame = CGRectMake(headerView.frame.size.width - 75 ,headerView.frame.size.height - 25 ,50,50);
    
    
    UIImage *btnImage = [UIImage imageNamed:@"ic_local_see"];
    
    
    
    [gotoPersonalDetails setImage:btnImage forState:UIControlStateNormal];
    
    
    [gotoPersonalDetails addTarget:self action:@selector(takeProfilePic:) forControlEvents:UIControlEventTouchUpInside];
    
    [[gotoPersonalDetails layer] setBorderWidth:0.5f];
    
    [[gotoPersonalDetails layer] setBorderColor:myColor.CGColor];
    
    [[gotoPersonalDetails layer] setBackgroundColor:myColor.CGColor];
    
    gotoPersonalDetails.layer.cornerRadius = gotoPersonalDetails.frame.size.width / 2;
    
    gotoPersonalDetails.layer.borderWidth = 3.0f;
    
    gotoPersonalDetails.clipsToBounds = YES;
    
    [headerView bringSubviewToFront:gotoPersonalDetails];
    
    [headerView addSubview:gotoPersonalDetails];
    
    
    
    self.tableView.tableHeaderView = headerView;
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        
        UIAlertController * myAlertView = [UIAlertController
                                           alertControllerWithTitle:@"Error"
                                           message:@"Device has no camera"
                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:myAlertView animated:YES completion:nil];
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    if(section == 0){
        
        return 1;
        
    }
    return 4;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if(indexPath.section == 0 ){
        
        personaldetailserror = [[UITextView alloc] initWithFrame:CGRectMake(10,10+cell.frame.size.height/2 ,cell.frame.size.width - 20 ,cell.frame.size.height / 2)];
        
        personaldetailserror.text = @"Please upload a photo so we know who to expect";
        
        [personaldetailserror setTextAlignment:NSTextAlignmentCenter];
        
        
        [personaldetailserror setTextColor:[UIColor redColor]];
        
        personaldetailserror.editable = NO;
        
        [cell.contentView addSubview:personaldetailserror];
        
        
        
        return cell;
    }else {
        
        
        
        if(indexPath.row == 0 )
            
        {
            
            
            UITextField *rooms = [[UITextField alloc] initWithFrame:CGRectMake(10,5,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            rooms.rightViewMode = UITextFieldViewModeAlways;
            
            
            rooms.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            rooms.rightView.tintColor = myColor;
            
            
            rooms.placeholder = @"Name:";
            
            
            
            [rooms setBackgroundColor:[UIColor clearColor]];
            
            rooms.textColor = myColor;
            
            [rooms setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            rooms.tag = 0;
            
            rooms.delegate = self;
            
            rooms.text = nameTEXT;
            
            
            
            [cell.contentView addSubview:[self addBorder:rooms]];
            
            return  cell;
            
            
        }
        
        else if(indexPath.row == 1 )
            
        {
            
            UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(10,5,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            phone.rightViewMode = UITextFieldViewModeAlways;
            
            
            phone.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_local_phone"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            phone.rightView.tintColor = myColor;
            
            phone.placeholder = @"Phone:";
            
            
            [phone setBackgroundColor:[UIColor clearColor]];
            
            phone.textColor = myColor;
            
            
            
            [phone setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            phone.tag = 1;
            
            phone.delegate = self;
            
            phone.text = phoneTEXT;
            
            
            [cell.contentView addSubview:[self addBorder:phone]];
            
            return  cell;
            
            
        } else if(indexPath.row == 2) {
            
            
            
            UITextField *email = [[UITextField alloc] initWithFrame:CGRectMake(10,5,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            email.rightViewMode = UITextFieldViewModeAlways;
            
            
            email.rightView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_email"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            
            email.rightView.tintColor = myColor;
            
            email.placeholder = @"Email:";
            
            
            [email setBackgroundColor:[UIColor clearColor]];
            
            email.textColor = myColor;
            
            [email setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            email.tag = 2;
            
            email.delegate = self;
            
            email.text = emailTEXT;
            
            
            
            [cell.contentView addSubview:[self addBorder:email]];
            
            
            
        }
        
        else if(indexPath.row == 3 )
            
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


- (IBAction)takeProfilePic:(id)sender {
    
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    parentViewController.jpgData = UIImageJPEGRepresentation(chosenImage, 0.2);
    
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)gotoPayment:(id)sender {
    
    
    
    
    
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    
    NSLog(@"emailTEXT %@",emailTEXT);
    if([nameTEXT isEqualToString: @""] || [phoneTEXT isEqualToString: @""]  ||[emailTEXT isEqualToString: @""]   )
        
    {
        
        
        personaldetailserror.text = @"All fields are required";
        
    }
    
    else if ([emailTest evaluateWithObject:emailTEXT] == NO )
        
    {
        
        
        personaldetailserror.text = @"Please check your email";
        
        
    }else {
        
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        
        
        
        parentViewController.name = nameTEXT;
        
        NSLog(@"Parent name - :%@",parentViewController.name);
        
        NSLog(@"%@",nameTEXT);
        
        parentViewController.phone = phoneTEXT;
        
        NSLog(@"Parent phone - : %@",parentViewController.phone);
        
        NSLog(@"%@",phoneTEXT);
        
        parentViewController.email = emailTEXT;
        
        NSLog(@"Parent email - : %@",parentViewController.email);
        
        NSLog(@"%@",emailTEXT);
        
        
        [parentViewController gotoPayment];
        
        
        
    }
    
    
}



-(void)textFieldDidEndEditing:(UITextField*)textField {
    
    
    
    NSLog(@"TEXTFIELD TAG : %ld",(long)textField.tag);
    
    if(textField.tag == 0)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        nameTEXT = t.text;
        
    }
    else if(textField.tag == 1)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:1];
        
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        phoneTEXT = t.text;
        
    }
    else if(textField.tag == 2)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:1];
        
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        emailTEXT = t.text;
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
