//
//  checkedinguestContainer.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "checkedinguestContainer.h"
#import "TimelineViewController.h"
#import "checkedinguestContainer.h"
#import "guestContainerViewController.h"
#import "reservationPage.h"
#import "receptionPage.h"
#import "optionsPage.h"
#import "personaldetailsPage.h"
#import "billPage.h"
#import "travelplannerPage.h"
#import "recipesPage.h"
#import "confirmationPage.h"
#import "travelGuide.h"
#import "itemDescription.h"
#import "placeDescriptionpage.h"
#import "OurVillaViewController.h"
#import "TimeViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "miscData.h"
#import "BigPhotoViewController.h"
#import "miscData.h"
#import "GuestBookViewController.h"
#import "newCommentPageViewController.h"
#import "optionPageD.h"
#import "optionPageC.h"
#import "optionPageB.h"
#import "ContactTableViewController.h"

@interface checkedinguestContainer ()

@end

@implementation checkedinguestContainer

miscData *sharedManagerCheckedIn;

@synthesize currentDetailViewController;

@synthesize lastDetailViewController;

@synthesize detailView;

@synthesize myColor;

@synthesize sinopia;

@synthesize HomePageToolbar;

@synthesize menuNames;

@synthesize bottomMenu;

@synthesize businessTypesArray;

@synthesize serviceTypesArray;

@synthesize placesArray;

@synthesize str_types;

@synthesize str_services;
@synthesize str_places;

@synthesize guestjsonArray;

@synthesize itineraryArray;

@synthesize imageData;

@synthesize jpgData;

@synthesize snackBar;

@synthesize snackBarLabel;


NSArray* jsonArray;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    sharedManagerCheckedIn = [miscData sharedManager];
    
    guestjsonArray = [[NSArray alloc] init];
    
    businessTypesArray = [[NSArray alloc] init];
    
    serviceTypesArray = [[NSArray alloc] init];
    
    placesArray = [[NSArray alloc] init];
    
    itineraryArray = [[NSMutableArray alloc] init];
    
    jsonArray = [[NSArray alloc] init];
    
    menuNames = @[@"Home",@"Menu", @"Concierge", @"Bookshelf", @"Guestbook", @"TV"];
    
    imageData = @[@"ic_home_white" , @"ic_restaurant", @"ic_card_travel" , @"ic_bookmark_border", @"ic_local_library", @"ic_local_movies_white"];
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    
    
    
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_chevron_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonpressed:)];
    
    
    
    newBackButton.tintColor = myColor;
    
    
    
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    
    
    [self.navigationController setHidesBarsOnSwipe:YES];
    
    HomePageToolbar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height*1.3,self.view.frame.size.width,self.navigationController.navigationBar.frame.size.height * 1.3 )];
    
    HomePageToolbar.tintColor = [UIColor whiteColor];
    
    HomePageToolbar.barTintColor = sinopia;
    
    
    
    UIButton *HomePageCalButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width/5,HomePageToolbar.frame.size.height  )];
    
    [HomePageCalButton setTitle:@"HOME" forState:UIControlStateNormal];
    
    [HomePageCalButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
    
    HomePageCalButton.titleLabel.font = cellFont;
    
    [HomePageCalButton addTarget:self action:@selector(gotoReservation:) forControlEvents:UIControlEventTouchUpInside];
    
    [[HomePageCalButton layer] setBorderWidth:0.5f];
    
    [[HomePageCalButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    [HomePageCalButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    [HomePageCalButton setImage:[UIImage imageNamed:@"ic_logo_white"] forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:[self designButtonwithText:HomePageCalButton]];
    
    
    
    
    
    UIButton *HomePagetimelineButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageCalButton.frame.size.width,0,self.view.frame.size.width/5,HomePageToolbar.frame.size.height  )];
    
    [HomePagetimelineButton setTitle:@"TIMELINE" forState:UIControlStateNormal];
    
    [HomePagetimelineButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    HomePagetimelineButton.titleLabel.font = cellFont;
    
    [HomePagetimelineButton addTarget:self action:@selector(gotoTimeline:) forControlEvents:UIControlEventTouchUpInside];
    
    [[HomePagetimelineButton layer] setBorderWidth:0.5f];
    
    [[HomePagetimelineButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    [HomePagetimelineButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    
    [HomePagetimelineButton setImage:[UIImage imageNamed:@"ic_timeline_white"] forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:[self designButtonwithText:HomePagetimelineButton]];
    
    
    
    
    
    UIButton *HomePagePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePagetimelineButton.frame.origin.x + HomePagetimelineButton.frame.size.width,0,self.view.frame.size.width/5,HomePageToolbar.frame.size.height  )];
    
    [HomePagePhotoButton setTitle:@"" forState:UIControlStateNormal];
    
    [HomePagePhotoButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    HomePagePhotoButton.titleLabel.font = cellFont;
    
    [HomePagePhotoButton addTarget:self action:@selector(takeProfilePic:) forControlEvents:UIControlEventTouchUpInside];
    
    [[HomePagePhotoButton layer] setBorderWidth:0.5f];
    
    [[HomePagePhotoButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    [HomePagePhotoButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    
    [HomePagePhotoButton setImage:[UIImage imageNamed:@"ic_local_see_white"] forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:[self designButtonwithText:HomePagePhotoButton]];
    
    
    
    
    
    
    
    UIButton *HomePageAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePagePhotoButton.frame.origin.x + HomePagePhotoButton.frame.size.width ,0,self.view.frame.size.width/5,HomePageToolbar.frame.size.height )];
    
    
    [HomePageAccountButton addTarget:self action:@selector(gotoTraveltips:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [HomePageAccountButton setTitle:@"GUIDE" forState:UIControlStateNormal];
    
    [[HomePageAccountButton layer] setBorderWidth:0.5f];
    
    HomePageAccountButton.titleLabel.font = cellFont;
    
    [[HomePageAccountButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    [HomePageAccountButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    [HomePageAccountButton setImage:[UIImage imageNamed:@"ic_card_travel_white"] forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:[self designButtonwithText:HomePageAccountButton]];
    
    
    
    
    
    UIButton *HomePageHelpButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageAccountButton.frame.origin.x +  HomePageAccountButton.frame.size.width,0,self.view.frame.size.width/5,HomePageToolbar.frame.size.height  )];
    
    [HomePageHelpButton setTitle:@"HELP" forState:UIControlStateNormal];
    
    HomePageHelpButton.titleLabel.font = cellFont;
    
    
    
    [[HomePageHelpButton layer] setBorderWidth:0.5f];
    
    HomePageHelpButton.titleLabel.font = cellFont;
    
    
    [[HomePageHelpButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    
    [HomePageHelpButton addTarget:self action:@selector(gotoContact:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [[HomePageHelpButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    [HomePageHelpButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    [HomePageHelpButton setImage:[UIImage imageNamed:@"ic_help_outline_white"] forState:UIControlStateNormal];
    
    
    
    [HomePageToolbar addSubview:[self designButtonwithText:HomePageHelpButton]];
    
    
    detailView=[[UIView alloc]  initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - (HomePageToolbar.frame.size.height) )];
    
    detailView.backgroundColor = [UIColor whiteColor];
    
    detailView.opaque = YES;
    
    [detailView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    
    [self.view addSubview:detailView];
    
    
    
    
    
    bottomMenu = [[UIPickerView alloc] init];
    
    bottomMenu.backgroundColor = [UIColor blackColor];
    
    
    [bottomMenu setDataSource: self];
    [bottomMenu setDelegate: self];
    
    [bottomMenu setFrame: CGRectMake(0, [UIScreen mainScreen].bounds.size.height , [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height / 3 )];
    
    bottomMenu.showsSelectionIndicator = YES;
    
    
    [self.view addSubview: bottomMenu];
    
    
    confirmationPage *detailOne = [[confirmationPage alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width];
    
    
    [self presentDetailController:detailOne];
    
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        
        UIAlertController * myAlertView = [UIAlertController
                                           alertControllerWithTitle:@"Error"
                                           message:@"Device has no camera"
                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:myAlertView animated:YES completion:nil];
        
    }
    
    
    snackBar = [[UIView alloc] initWithFrame:CGRectMake(0,(self.view.frame.size.height / 3 ) * 2 , self.view.frame.size.width , self.view.frame.size.height / 3  )];
    
    
    snackBar.backgroundColor = [UIColor redColor];
    
    snackBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,snackBar.frame.size.height / 2 ,self.view.frame.size.width/5,snackBar.frame.size.height / 3  )];
    
    [snackBar addSubview:snackBarLabel];
    
    
    //[self.view addSubview:snackBar];
    
    
    [self.view addSubview:HomePageToolbar];
    
    
}

- (IBAction)backbuttonpressed:(id)sender {
    
    
    [self presentDetailController:lastDetailViewController];
    
    
    
}

- (IBAction)gotoTimeline:(id)sender {
    
    
    miscData *sharedManager = [miscData sharedManager];
    
    if(sharedManager.timeline == 0 ){
        
        
        [NSThread sleepForTimeInterval:5.0];
        
        [self presentDetailController:[[TimelineViewController alloc] initWithHeight:self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:self.view.frame.size.width initWithArray:sharedManagerCheckedIn.timelineFiles]];
        
        
    }
    else{
        
        
        [self presentDetailController:[[TimelineViewController alloc] initWithHeight:self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:self.view.frame.size.width initWithArray:sharedManagerCheckedIn.timelineFiles]];
        
        
    }
    
    
    
    
}


- (IBAction)takeProfilePic:(id)sender {
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:12 forKey:@"optionPage"];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSMutableArray *jsonDict =  [[NSMutableArray alloc] init];
    
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    jpgData = UIImageJPEGRepresentation(chosenImage, 0.2);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [jsonDict addObject:chosenImage];
    
    [self presentDetailController:[[BigPhotoViewController alloc]  initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width initWithArray:jsonDict]];
    
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)presentDetailController:(UIViewController*)detailVC{
    
    if(self.currentDetailViewController){
        
        [self removeCurrentDetailViewController];
    }
    
    self.currentDetailViewController = detailVC;
    
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    lastDetailViewController = self.currentDetailViewController;
    
    self.currentDetailViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addChildViewController:detailVC];
    
    //detailVC.view.frame = [self frameForDetailController];
    
    [self.detailView addSubview:detailVC.view];
    
    [detailVC didMoveToParentViewController:self];
    
    
}



- (void)removeCurrentDetailViewController{
    
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    [self.currentDetailViewController.view removeFromSuperview];
    
    [self.currentDetailViewController removeFromParentViewController];
}



- (void)swapCurrentControllerWith:(UIViewController*)viewController{
    
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    [self addChildViewController:viewController];
    
    [self.detailView addSubview:viewController.view];
    
    
    [viewController.view layoutIfNeeded];
    
    // set starting state of the transition
    viewController.view.alpha = 0;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         //viewController.view.alpha = 1;
                         //self.currentDetailViewController.view.alpha = 0;
                         [viewController.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [self.currentDetailViewController.view removeFromSuperview];
                         [self.currentDetailViewController removeFromParentViewController];
                         [viewController didMoveToParentViewController:self];
                     }];
    
}


- (CGRect)frameForDetailController{
    
    CGRect detailFrame = self.detailView.frame;
    
    return detailFrame;
}

- (void)closemenu  {
    
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    self.bottomMenu.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height ,[UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height / 3);
    
    [UIView commitAnimations];
    
}


- (void)showmenu  {
    
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    self.bottomMenu.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height - bottomMenu.frame.size.height ,[UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height / 3);
    
    [UIView commitAnimations];
    
}



- (void)addDetailController:(NSArray*)jsonArray {
    
    
    
    
}





-(void) uploadSnap:(NSString*)message withLocation:(NSString*)location {
    
    
    NSString *urlString =  [NSString stringWithFormat:@"http://www.sinopiainn.com/api/upload-reservation-photo?resID=%@name=%@&message=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"reservationID"],[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],message];
    
    
    NSString *str = @"displayImage";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithFormat:@"---------------------------14737809831464368775746641449"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"currentEventID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"52344457901000006" dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (jpgData) {
        
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // [body appendData:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"displayImage\"; filename=\"myimage.jpg\"\r\n"]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"myimage.jpg\"\r\n", str] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:jpgData];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSLog(@"HttpBody = %@",request);
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:body
                                                      completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                              
                                              
                                              NSLog(@"data = %@",data);
                                              
                                          }];
    
    [uploadTask resume];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
    miscData *sharedManager = [miscData sharedManager];
    
    [sharedManager reloadpicturefiles];
    
    
    [sharedManager reloadtimelinefiles: [NSString stringWithFormat:@"http://www.sinopiainn.com/api/timeline?name=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]]];
    
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}




-(void) confirmPayment {
    
    
    
}

- (void) gotoNewCommentpage {
    
    
    [self presentDetailController:[[newCommentPageViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width ]];
    
}

-(void) gotoBigPhoto:(NSDictionary*)jsonDict {
    
    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
    
    [imagesArray addObject:jsonDict];
    
    [self presentDetailController:[[BigPhotoViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width initWithArray:imagesArray]];
    
}

-(void) gotoReservationpage {
    
    
    
    [self presentDetailController:[[newCommentPageViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width]];
    
    
}

-(void) gotoOptionspage:(NSArray*)jsonArray {
    
    
    [self presentDetailController:[[optionsPage alloc] initWithHeight:self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:self.view.frame.size.width initWithArray:jsonArray]];
    
    
}


-(void) gotoItemlist:(NSArray*)jsonArray {
    
    [self presentDetailController:[[optionPageC alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray: jsonArray  ]];
    
}


-(void) gotoItemdescriptionpage:(NSDictionary*)jsonDictionary {
    
    
    
    [self presentDetailController:[[itemDescription alloc]  initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width initWithObject:jsonDictionary]];
    
}



- (void)gotoPersonalDetails {
    
    
    [self presentDetailController:[[personaldetailsPage alloc] init]];
    
    
}




-(void) gotoBill {
    
    
    
    [self presentDetailController:[[billPage alloc] init]];
    
    
}
-(void) gotoTravel  {
    
    
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"optionPage"];
    
    
    /*NSArray *names = [NSArray arrayWithObjects:@"key1", @"key2", nil];
     NSArray *description = [NSArray arrayWithObjects:@"key1", @"key2", nil];
     NSArray *url = [NSArray arrayWithObjects:@"key1", @"key2", nil];
     NSArray *location = [NSArray arrayWithObjects:@"key1", @"key2", nil];*/
    
    
    dispatch_queue_t queue = dispatch_queue_create("", NULL);
    
    for (int i = 0 ; i < 4 ; i++){
        
        
        NSArray *keys = [NSArray arrayWithObjects:@"name", @"description", @"url",  @"location" , nil];
        NSArray *objects = [NSArray arrayWithObjects:@"value1", @"value2", @"" , @"portland" , nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        
        [locations addObject:dictionary];
        
        
        
        
    }
    
    
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self presentDetailController:[[optionPageC alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithWidth:(int)self.view.frame.size.width initWithArray:locations]];
            
            
        });
    });
    
    
    
    
    
}



-(void) gotoTripplannerpageList {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/businesses"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        _businessesArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        for (int i = 0; i < [_businessesArray count]; i++) {
            
            
            if(  [[[_businessesArray objectAtIndex:i] objectForKey:@"location"] caseInsensitiveCompare:[[NSUserDefaults standardUserDefaults] objectForKey:@"location"]] == NSOrderedSame ){
                
                
                
                [_businessLoctionArray addObject:[_businessesArray objectAtIndex:i]];
                
                
                
            }
            
            
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self presentDetailController:[[travelplannerPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithArray:_businessLoctionArray]];
            
            
        });
        
        
    }];
    
    [dataTask resume];
    
    
    
    
    
    
    
}

-(void) gotoOptionspageBWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray {
    
    
    [self presentDetailController:[[optionPageB alloc]  initWithHeight:(int) self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width  initWithArray:jsonArray initWithIcons:iconArray]];
    
}



-(void) gotoRecipespage {
    
    
    miscData *sharedManager = [miscData sharedManager];
    
    
    
    if(sharedManager.Menufiles == 0 ){
        
        
        [NSThread sleepForTimeInterval:5.0];
        
        
        [self presentDetailController:[[recipesPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithArray:sharedManager.menuFiles]];
        
        
    }else{
        
        
        
        
        [self presentDetailController:[[recipesPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithArray:guestjsonArray]];
        
        
        
    }
    
    
    
    
    
    
    
    
}



-(void) returnedbuinessTypesArray:(NSArray*)jsonArray {
    
    businessTypesArray = jsonArray;
    
    str_types = @"";
    
    
    for (NSUInteger i = 0; i < [businessTypesArray count]; i++) {
        
        
        
        
        str_types = [str_types stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[jsonArray objectAtIndex: i] ] ];
        
        
    }
    
    
    [self presentDetailController:[[travelplannerPage alloc] initWithHeight:self.view.frame.size.width initWithWidth:self.view.frame.size.height - HomePageToolbar.frame.size.height initWithtypes:str_types initWithservices:str_services initWithplaces:str_places initWithArray:_businessesArray ]];
    
    
    
}

-(void) returnedserviceTypesArray:(NSArray*)jsonArray{
    
    
    serviceTypesArray = jsonArray;
    
    str_services = @"";
    
    
    for (NSUInteger i = 0; i < [serviceTypesArray count]; i++) {
        
        
        
        
        str_services = [str_services stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[jsonArray objectAtIndex: i] ] ];
        
        
    }
    
    
    [self presentDetailController:[[travelplannerPage alloc] initWithHeight:self.view.frame.size.width initWithWidth:self.view.frame.size.height - HomePageToolbar.frame.size.height initWithtypes:str_types initWithservices:str_services initWithplaces:str_places initWithArray:_businessesArray]];
    
    
}

-(void) returnedplacesTypesArray:(NSArray*)jsonArray{
    
    
    placesArray = jsonArray;
    
    str_places = @"";
    
    
    for (NSUInteger i = 0; i < [placesArray count]; i++) {
        
        
        
        
        str_places = [str_places stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[[jsonArray objectAtIndex: i] objectForKey:@"businessname"  ]] ];
        
        
    }
    
    
    
    
    [self presentDetailController:[[travelplannerPage alloc] initWithHeight:self.view.frame.size.width initWithWidth:self.view.frame.size.height - HomePageToolbar.frame.size.height initWithtypes:str_types initWithservices:str_services initWithplaces:str_places initWithArray:_businessesArray]];
    
    
}
-(void) gotoplacedescriptionpage:(NSDictionary*)jsonDictionary{
    
    
    
    [self presentDetailController:[[placeDescriptionpage alloc]  initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithObject:jsonDictionary]];
    
    
    
    
}


- (IBAction)gotoReservation:(id)sender {
    
    
    [self presentDetailController:[[confirmationPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height ]];
    
    
    
}

- (IBAction)gotoTraveltips:(id)sender {
    [self presentDetailController:[[travelGuide alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height ]];
    
    
    
}

- (IBAction)gotoContact:(id)sender {
    
    
    [self presentDetailController:[[ContactTableViewController alloc] initWithHeight:(int) self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int) self.view.frame.size.width]];
    
    
}


-(void) gotoMap {
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:9 forKey:@"optionPage"];
    
    //[self presentDetailController:[[MapViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width  ]];
    
    [self presentDetailController:[[MapViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width initWithLatitude:(int)18.166716 initWithLongitude:(int)-76.380764 ]];
    
}


-(void) gotPhotos:(NSArray*)jsonArray {
    
    
    
    sharedManagerCheckedIn = [miscData sharedManager];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"optionPage"];
    
    
    [self presentDetailController:[[recipesPage alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width  initWithArray:jsonArray initWithDictArray:sharedManagerCheckedIn.imageDictFiles]];
    
    
    
}


-(void) gotoChat {
    
    
    
    
}

-(void) gottoOurVilla {
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"optionPage"];
    
    [self presentDetailController:[[OurVillaViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width  ]];
    
    
}

-(void) gotoTime {
    
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"optionPage"];
    
    [self presentDetailController:[[TimeViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width  ]];
    
}

-(void) goToWeather  {
    
    
    
    
}



-(void) gotoMenu  {
    
    
    sharedManagerCheckedIn = [miscData sharedManager];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"optionPage"];
    
    
    if(!sharedManagerCheckedIn.menuFiles  || !sharedManagerCheckedIn.menuFiles.count  ){
        
        
        [NSThread sleepForTimeInterval:3.0];
        
        
        [self presentDetailController:[[optionPageD alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray: sharedManagerCheckedIn.menuFiles  ]];
        
        
    }else{
        
        
        [self presentDetailController:[[optionPageD alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray: sharedManagerCheckedIn.menuFiles  ]];
        
    }
    
    
}

-(void) gotoBooks  {
    
    
    sharedManagerCheckedIn = [miscData sharedManager];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:@"optionPage"];
    
    if(sharedManagerCheckedIn.Booksfiles == 0 ){
        
        
        [NSThread sleepForTimeInterval:3.0];
        
        [self presentDetailController:[[optionPageD alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray: sharedManagerCheckedIn.bookFiles  ]];
        
        
    }else{
        
        
        [self presentDetailController:[[optionPageD alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray: sharedManagerCheckedIn.bookFiles  ]];
        
    }
    
    
    
    
    
}

-(void) goToReviews {
    
    
    sharedManagerCheckedIn = [miscData sharedManager];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:6 forKey:@"optionPage"];
    
    
    if(sharedManagerCheckedIn.Commentfiles == 0 ){
        
        
        [NSThread sleepForTimeInterval:3.0];
        
        
        [self presentDetailController:[[GuestBookViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width initWithArray: sharedManagerCheckedIn.commentFiles  ]];
        
        
        
    }else{
        
        
        
        [self presentDetailController:[[GuestBookViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width initWithArray: sharedManagerCheckedIn.commentFiles  ]];
        
        
    }
    
    
}

-(void) gotoChannels  {
    
    [[NSUserDefaults standardUserDefaults] setInteger:7 forKey:@"optionPage"];
    
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component{
    
    
    return 60;
}
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return menuNames.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return menuNames[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *pickerCustomView = (id)view;
    UILabel *pickerViewLabel;
    UIImageView *pickerImageView;
    
    if (!pickerCustomView) {
        pickerCustomView= [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                   [pickerView rowSizeForComponent:component].width - 10.0f, [pickerView       rowSizeForComponent:component].height)];
        pickerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 35.0f, 35.0f)];
        pickerViewLabel= [[UILabel alloc] initWithFrame:CGRectMake(137.0f, -5.0f,
                                                                   [pickerView rowSizeForComponent:component].width - 10.0f, [pickerView rowSizeForComponent:component].height)];
        
        [pickerCustomView addSubview:pickerImageView];
        [pickerCustomView addSubview:pickerViewLabel];
    }
    
    pickerImageView.image = [[ UIImage imageNamed:imageData[row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    pickerImageView.tintColor = myColor;
    pickerViewLabel.backgroundColor = [UIColor clearColor];
    pickerViewLabel.text = menuNames[row];
    pickerViewLabel.textColor = [UIColor whiteColor];
    return pickerCustomView;
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    [[NSUserDefaults standardUserDefaults] setInteger:row forKey:@"optionPage"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [[NSURLSessionDataTask alloc]init];
    
    switch (row) {
            
        case 0:{
            
            
            
            [self presentDetailController:[[confirmationPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height ]];
            
            [self closemenu];
            
        }
        case 1:
        {
            
            [self gotoRecipespage];
            [self closemenu];
        }
            break;
        case 2:
        {
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            configuration.URLCache = NULL;
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
            
            
            
            
            NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/businesses"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    _businessesArray =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    [self presentDetailController:[[travelplannerPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithArray:_businessesArray]];
                    
                    [self closemenu];
                    
                });
                
                
            }];
            
            [dataTask resume];
            
            
            
        }
            
            break;
        case 3:
            
            
            
        {
            
            dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/books/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    
                    
                    [self presentDetailController:[[recipesPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]];
                    [self closemenu];
                });
                
                
            }];
            
            [dataTask resume];
            
        }
            break;
            
            
        case 4:
            
            
        {
            
            /*reviews*/
            
            dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/menu/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    
                    
                    [self presentDetailController:[[recipesPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]];
                    [ self closemenu];
                });
                
                
            }];
            
            [dataTask resume];
            
        }
            
            break;
            
        case 5:
            
            
            
        {
            
            dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/menu/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    
                    
                    [self presentDetailController:[[recipesPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]];
                    [self closemenu];
                });
                
                
                
            }];
            
            [dataTask resume];
            
            
        }
            break;
            
            
            
        default:
            break;
    }
    
    
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:menuNames[row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}

-(UIButton*) designButtonwithText:(UIButton*) button  {
    
    
    
    CGFloat spacing = 6.0;
    
    
    CGSize imageSize = button.imageView.image.size;
    
    button.titleEdgeInsets = UIEdgeInsetsMake(
                                              0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
    
    button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
    
    return button;
}
@end
