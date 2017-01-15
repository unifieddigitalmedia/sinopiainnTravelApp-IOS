//
//  guestContainerViewController.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "guestContainerViewController.h"
#import "optionPageD.h"
#import "optionPageC.h"
#import "optionPageB.h"
#import "reservationPage.h"
#import "receptionPage.h"
#import "optionsPage.h"
#import "personaldetailsPage.h"
#import "billPage.h"
#import "travelplannerPage.h"
#import "recipesPage.h"
#import "travelGuide.h"
#import "itemDescription.h"
#import "placeDescriptionpage.h"
#import "miscData.h"
#import "MapViewController.h"
#import "ContactTableViewController.h"

@interface guestContainerViewController ()

@end

@implementation guestContainerViewController


@synthesize subtotal;

@synthesize fullurl;

@synthesize num_guest;

@synthesize num_days;

@synthesize currentDetailViewController;

@synthesize detailView;

@synthesize myColor;

@synthesize sinopia;

@synthesize HomePageToolbar;

@synthesize roomsArray;

@synthesize offersArray;

@synthesize amentitiesArray;

@synthesize str_rooms;

@synthesize str_amenities;

@synthesize fromdate;

@synthesize todate;

@synthesize total;

@synthesize discount;

@synthesize amenity_amt;

@synthesize lastDetailViewController;

@synthesize businessTypesArray;

@synthesize serviceTypesArray;

@synthesize placesArray;

@synthesize jpgData;
@synthesize validation;
@synthesize str_types;
@synthesize str_services;
@synthesize str_places;
@synthesize itineraryArray;
@synthesize name;
@synthesize phone;
@synthesize email;
@synthesize numofadults;
@synthesize numofchildren;
@synthesize numofinfants;
@synthesize tax;
miscData *sharedManagerGuest;

NSArray* guestjsonArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    miscData *sharedManagerGuest;
    jpgData = [[NSData alloc] init];
    
    sharedManagerGuest = [miscData sharedManager];
    
    itineraryArray = [[NSMutableArray alloc] init];
    
    validation = [[NSArray alloc] init];
    
    guestjsonArray = [[NSArray alloc] init];
    
    roomsArray = [[NSArray alloc] init];
    
    offersArray = [[NSArray alloc] init];
    
    amentitiesArray = [[NSArray alloc] init];
    
    _businessLoctionArray  = [[NSMutableArray alloc] init];
    
    businessTypesArray = [[NSArray alloc] init];
    
    serviceTypesArray = [[NSArray alloc] init];
    
    placesArray = [[NSArray alloc] init];
    
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:203.0f/255.0f green:65.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    
    
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_chevron_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonpressed:)];
    
    
    
    newBackButton.tintColor = myColor;
    
    
    
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    
    
    [self.navigationController setHidesBarsOnSwipe:YES];
    
    HomePageToolbar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height*1.3,self.view.frame.size.width,self.navigationController.navigationBar.frame.size.height * 1.3 )];
    
    HomePageToolbar.tintColor = [UIColor whiteColor];
    
    HomePageToolbar.barTintColor = sinopia;
    
    
    
    
    UIButton *HomePageCalButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width/3,HomePageToolbar.frame.size.height  )];
    
    [HomePageCalButton setTitle:@"RESERVATION" forState:UIControlStateNormal];
    
    [HomePageCalButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
    
    HomePageCalButton.titleLabel.font = cellFont;
    
    [HomePageCalButton addTarget:self action:@selector(gotoReservation:) forControlEvents:UIControlEventTouchUpInside];
    
    [[HomePageCalButton layer] setBorderWidth:0.5f];
    
    [[HomePageCalButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    [HomePageCalButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    
    [HomePageCalButton setImage:[UIImage imageNamed:@"ic_logo_white"] forState:UIControlStateNormal];
    
    
    
    [HomePageToolbar addSubview:[self designButtonwithText:HomePageCalButton]];
    
    
    UIButton *HomePageAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageCalButton.frame.size.width,0,self.view.frame.size.width/3,HomePageToolbar.frame.size.height )];
    
    
    [HomePageAccountButton addTarget:self action:@selector(gotoTraveltips:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [HomePageAccountButton setTitle:@"GUIDE" forState:UIControlStateNormal];
    
    [[HomePageAccountButton layer] setBorderWidth:0.5f];
    
    HomePageAccountButton.titleLabel.font = cellFont;
    
    
    [[HomePageAccountButton layer] setBorderColor:[UIColor clearColor].CGColor];
    
    [HomePageAccountButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    [HomePageAccountButton setImage:[UIImage imageNamed:@"ic_card_travel_white"] forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:[self designButtonwithText:HomePageAccountButton]];
    
    UIButton *HomePageHelpButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageAccountButton.frame.origin.x + HomePageAccountButton.frame.size.width,0,self.view.frame.size.width/3,HomePageToolbar.frame.size.height  )];
    
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
    
    
    UIViewController *rpage = [[receptionPage alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int) self.view.frame.size.width ];
    
    [rpage setModalPresentationStyle:UIModalPresentationCustom];
    
    [rpage setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    
    [self presentDetailController:rpage];
    
    
    [self.view addSubview:HomePageToolbar];
    
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
    
    lastDetailViewController = self.currentDetailViewController;
    
    self.currentDetailViewController = detailVC;
    
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
    
    // set starting state of the transition/Users/Home/Desktop/SinopiaInn/SinopiaInn/receptionPage.h
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



- (void)addDetailController:(NSArray*)jsonArray {
    
    
    
    
}





-(void) confirmPersonaldetails {
    
    
}


-(void) confirmPayment {
    
    
    
}


-(void) gotoReservationpage {
    
    
    
    [self presentDetailController:[[reservationPage alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithWidth:(int)self.view.frame.size.width]];
    
    
}


-(void) gotoMap:(double) myLatitude withLongitude:(double) myLongitude  {
    
    
    [self presentDetailController:[[MapViewController alloc] initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width initWithLatitude:(double)myLatitude initWithLongitude:(double)myLongitude ]];
    
    
    
}


-(void) gotoOptionspage:(NSArray*)jsonArray {
    
    
    [self presentDetailController:[[optionsPage alloc]  initWithHeight:(int) self.view.frame.size.height - (HomePageToolbar.frame.size.height) initWithWidth:(int)self.view.frame.size.width initWithArray:jsonArray]];
    
    
}



-(void) gotoOptionspageBWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray {
    
    
    [self presentDetailController:[[optionPageB alloc]  initWithHeight:(int) self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int)self.view.frame.size.width  initWithArray:jsonArray initWithIcons:iconArray]];
    
}

-(void) gotoOptionspageWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray {
    
    
    [self presentDetailController:[[optionsPage alloc]  initWithHeight:(int) self.view.frame.size.height - (HomePageToolbar.frame.size.height  )initWithWidth:(int)self.view.frame.size.width  initWithArray:jsonArray initWithIcons:iconArray]];
    
}
-(void) gotoItemdescriptionpage:(NSDictionary*)jsonDictionary {
    
    
    [self presentDetailController:[[itemDescription alloc]  initWithHeight:(int)self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int) self.view.frame.size.width initWithObject:jsonDictionary]];
    
}





- (void)gotoPersonalDetails {
    
    
    [self presentDetailController:[[personaldetailsPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )]];
    
    
}

-(void) gotoBill {
    
    [self presentDetailController:[[billPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height)]];
    
    
}


-(void) gotoPayment {
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURL *clientTokenURL = [NSURL URLWithString:@"http://www.sinopiainn.com/api/checkout/"];
    
    NSMutableURLRequest *clientTokenRequest = [NSMutableURLRequest requestWithURL:clientTokenURL];
    
    [clientTokenRequest setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:clientTokenRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: Handle errors
        NSString *clientTokenOrTokenizationKey = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
      
        BTDropInRequest *request = [[BTDropInRequest alloc] init];
        
        BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:clientTokenOrTokenizationKey request:request handler:^(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error) {
            
            if (error != nil) {
                NSLog(@"ERROR");
            } else if (result.cancelled) {
                NSLog(@"CANCELLED");
            } else {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
        }];
        [self presentViewController:dropIn animated:YES completion:nil];
        
    }] resume];
    
    
    
 
    
}

- (void)userDidCancelPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
- (void)dropInViewController:(BTDropInViewController *)viewController
  didSucceedWithTokenization:(BTPaymentMethodNonce *)paymentMethodNonce {
    // Send payment method nonce to your server for processing
    [self postNonceToServer:paymentMethodNonce.nonce];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
*/

-(void) postNonceToServer:(NSString*) paymentMethodNonce {
    
    
    
    int amt = total * .50 ;
    
    fullurl  = [NSString stringWithFormat:@"http://www.sinopiainn.com/api/mobile/payment/?"];
    
    
    fullurl  = [[NSString stringWithFormat:@"%@&fname=%@&lname=&phone=%@&email=%@&numofdays=%ld&guests=%d&numofadults=%d&numofchildren=%d&numofinfants=%d&fromdate=%@&todate=%@&amenityTotal=%f&deposit=%d&subtotal=%f&discount=%f&tax=%f&total=%f&payment_method_nonce=%@&amount=%d",fullurl,name,phone,email,(long)num_days,num_guest,numofadults,numofchildren,numofinfants,fromdate,todate,amenity_amt,amt,subtotal,discount,tax,total,paymentMethodNonce,amt] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    NSData *roomArrayjsonData = [NSJSONSerialization dataWithJSONObject:roomsArray options:0 error:nil];
    
    NSString * myString = [[NSString alloc] initWithData:roomArrayjsonData encoding:NSUTF8StringEncoding];
    
    fullurl  = [NSString stringWithFormat:@"%@&roomarray[]=%@",fullurl,myString];
    
    
    roomArrayjsonData = [NSJSONSerialization dataWithJSONObject:amentitiesArray options:0 error:nil];
    
    myString = [[NSString alloc] initWithData:roomArrayjsonData encoding:NSUTF8StringEncoding];
    
    fullurl  = [NSString stringWithFormat:@"%@&amenityarray[]=%@",fullurl,myString];
    
    
    roomArrayjsonData = [NSJSONSerialization dataWithJSONObject:offersArray options:0 error:nil];
    
    myString = [[NSString alloc] initWithData:roomArrayjsonData encoding:NSUTF8StringEncoding];
    
    fullurl  = [NSString stringWithFormat:@"%@&offerarray[]=%@",fullurl,myString];
    
    
    if( [itineraryArray count ] != 0 ){
        
        
        // fullurl  = [[NSString stringWithFormat:@"%@&subtotaladmission=%@&subtotalavergae=%@&tripID=1&carhire=%@&triptax=%@&triptotal=%@",fullurl,] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        roomArrayjsonData = [NSJSONSerialization dataWithJSONObject:itineraryArray options:0 error:nil];
        
        myString = [[NSString alloc] initWithData:roomArrayjsonData encoding:NSUTF8StringEncoding];
        
        fullurl  = [NSString stringWithFormat:@"&tripID=1%@&places[]=%@",fullurl,myString];
        
        
        
        
    }
    
    NSString *str = @"displayImage";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    
    
    [request setURL:[NSURL URLWithString:@"http://www.sinopiainn.com/upload-image"]];
    
    [request setURL:[NSURL URLWithString:fullurl]];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *boundary = [NSString stringWithFormat:@"---------------------------14737809831464368775746641449"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"currentEventID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"52344457901000006" dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (jpgData) {
        
        NSLog(@"there is data");
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // [body appendData:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"displayImage\"; filename=\"myimage.jpg\"\r\n"]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"myimage.jpg\"\r\n", str] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:jpgData];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [request setHTTPBody:body];
    
    
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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
    NSLog(@"data = %@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    NSLog(@"data = %@",data);
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

-(void) gotoTripplannerpage {
    
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"optionPage"];
    
    
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
            
            
            // NSLog(@"%@",[[[_businessesArray objectAtIndex:i] objectForKey:@"location"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"location"]]  );
            
            if(  [[[_businessesArray objectAtIndex:i] objectForKey:@"location"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"location"]]  ){
                
                
                
                [_businessLoctionArray addObject:[_businessesArray objectAtIndex:i]];
                
                
                
            }
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",_businessLoctionArray);
            
            [self presentDetailController:[[travelplannerPage alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithArray:_businessLoctionArray]];
            
            
        });
        
        
    }];
    
    [dataTask resume];
    
}

/*-(void) gotoRecipespage {
    
    
    
    sharedManagerGuest = [miscData sharedManager];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"optionPage"];
    
    NSLog(@"menu items:%lu",(unsigned long)[sharedManagerGuest.menuFiles count ]);
    
    
    
    if(sharedManagerGuest.Menufiles == 0 ){
        
        
        [NSThread sleepForTimeInterval:3.0];
        
        [self presentDetailController:[[optionPageD alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray:  sharedManagerGuest.menuFiles   ]];
        
        
    }else{
        
        
        [self presentDetailController:[[optionPageD alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray:  sharedManagerGuest.menuFiles   ]];
        
    }
    
    
    
    
}*/


-(void) gotoItemlist:(NSArray*)jsonArray {
    
    [self presentDetailController:[[optionPageC alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width  initWithArray: jsonArray  ]];
    
}


-(void) returnedroomsArray:(NSArray*)jsonArray {
    
    
    roomsArray = jsonArray;
    
    str_rooms = @"";
    
    
    for (NSUInteger i = 0; i < [roomsArray count]; i++) {
        
        
        
        
        str_rooms = [str_rooms stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[[roomsArray objectAtIndex: i] objectForKey:@"name"]] ];
        
        
    }
    
    
    [self presentDetailController:[[reservationPage alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithWidth:(int) self.view.frame.size.width initWithFrom:fromdate initWithTo:todate initWithrooms:str_rooms initWithamenities:str_amenities]];
    
}

-(void) returnedoffersArray:(NSArray*)jsonArray {
    
    offersArray = jsonArray;
    
    
    
}

-(void) returnedamenitiesArray:(NSArray*)jsonArray {
    
    amentitiesArray = jsonArray;
    
    str_amenities = @"";
    
    
    for (NSUInteger i = 0; i < [amentitiesArray count]; i++) {
        
        
        
        
        str_amenities = [str_amenities stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[[amentitiesArray objectAtIndex: i] objectForKey:@"name"]] ];
        
        
    }
    
    [self presentDetailController:[[reservationPage alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithWidth:(int)self.view.frame.size.width initWithFrom:fromdate initWithTo:todate initWithrooms:str_rooms initWithamenities:str_amenities]];
}



-(void) returnedbuinessTypesArray:(NSArray*)jsonArray {
    
    businessTypesArray = jsonArray;
    
    str_types = @"";
    
    
    for (NSUInteger i = 0; i < [businessTypesArray count]; i++) {
        
        
        
        
        str_types = [str_types stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[jsonArray objectAtIndex: i] ] ];
        
        
    }
    
    
    [self presentDetailController:[[travelplannerPage alloc] initWithHeight:self.view.frame.size.width initWithWidth:self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithtypes:str_types initWithservices:str_services initWithplaces:str_places initWithArray:_businessesArray ]];
    
    
    
}

-(void) returnedserviceTypesArray:(NSArray*)jsonArray{
    
    
    serviceTypesArray = jsonArray;
    
    str_services = @"";
    
    
    for (NSUInteger i = 0; i < [serviceTypesArray count]; i++) {
        
        
        
        
        str_services = [str_services stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[jsonArray objectAtIndex: i] ] ];
        
        
    }
    
    
    [self presentDetailController:[[travelplannerPage alloc] initWithHeight:self.view.frame.size.width initWithWidth:self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithtypes:str_types initWithservices:str_services initWithplaces:str_places initWithArray:_businessesArray]];
    
    
}

-(void) returnedplacesTypesArray:(NSArray*)jsonArray{
    
    
    placesArray = itineraryArray;
    
    str_places = @"";
    
    
    for (NSUInteger i = 0; i < [placesArray count]; i++) {
        
        
        
        
        str_places = [str_places stringByAppendingString:[NSString stringWithFormat:@"%@ ,",[[jsonArray objectAtIndex: i] objectForKey:@"businessname"  ]] ];
        
        
    }
    
    
    
    
    [self presentDetailController:[[travelplannerPage alloc] initWithHeight:self.view.frame.size.width initWithWidth:self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithtypes:str_types initWithservices:str_services initWithplaces:str_places initWithArray:_businessesArray]];
    
    
}


-(void) gotoplacedescriptionpage:(NSDictionary*)jsonDictionary{
    
    
    
    [self presentDetailController:[[placeDescriptionpage alloc]  initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) initWithObject:jsonDictionary]];
    
    
    
    
}

- (void)calculateDateDifference:(NSDate*)fromDateTime todate:(NSDate*)toDateTime


{
    
    
    NSDate *fromDate;
    
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    num_days =  [difference day];
    
    NSLog(@"%ld",(long)num_days);
    
    
}




- (void)calculateTotal


{
    
    
    
    NSInteger room_amt = 0;
    
    
    for (NSUInteger i = 0; i < [roomsArray count]; i++) {
        
        
        
        room_amt = room_amt + ([[[roomsArray objectAtIndex: i] objectForKey:@"price"] intValue] * num_days );
        
        
    }
    
    
    total = room_amt;
    
    discount = 0;
    
    for (NSUInteger i = 0; i < [offersArray count]; i++) {
        
        discount = discount + ((total * [[[offersArray objectAtIndex: i]objectForKey:@"amount"] intValue]  ) /100 );
        
        total = total - ((total * [[[offersArray objectAtIndex: i]objectForKey:@"amount"] intValue]  ) /100 ) ;
        
        
    }
    
    amenity_amt = 0;
    
    
    for (NSUInteger i = 0; i < [amentitiesArray count]; i++) {
        
        
        if([[[amentitiesArray objectAtIndex: i] objectForKey:@"frequency" ]  isEqualToString: @"person"])
        {
            
            amenity_amt = amenity_amt +  ([[[amentitiesArray objectAtIndex: i] objectForKey:@"price" ] floatValue] * num_guest);
            
            
            
        }
        else if ([[[amentitiesArray objectAtIndex: i] objectForKey:@"frequency" ]  isEqualToString: @"room"])
        {
            
            amenity_amt = amenity_amt +  ([[[amentitiesArray objectAtIndex: i] objectForKey:@"price" ] floatValue] * [roomsArray count]);
            
        }
        else if ([[[amentitiesArray objectAtIndex: i] objectForKey:@"frequency" ]  isEqualToString: @"night"])
        {
            
            
            amenity_amt = amenity_amt +  ([[[amentitiesArray objectAtIndex: i] objectForKey:@"price" ] floatValue] * num_days);
        }
        
        
        
    }
    
    
    
    total = total + amenity_amt;
    
    subtotal = total + amenity_amt;
    
    tax = (total * 0.25);
    
    
    total = total + (total * 0.25);
    
    
    
    
}

- (IBAction)gotoReservation:(id)sender {
    
    [self presentDetailController:[[receptionPage alloc] initWithHeight:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height )initWithWidth:(int)self.view.frame.size.width]];
    
    
    
}

- (IBAction)gotoTraveltips:(id)sender {
    [self presentDetailController:[[travelGuide alloc] initWithHeight:(int)self.view.frame.size.width initWithWidth:(int)self.view.frame.size.height - (HomePageToolbar.frame.size.height ) ]];
    
    
    
}

- (IBAction)gotoContact:(id)sender {
    
    
    //[self presentDetailController:[[ContactTableViewController alloc] initWithHeight:(int) self.view.frame.size.height - HomePageToolbar.frame.size.height initWithWidth:(int) self.view.frame.size.width]];
    
}


- (IBAction)backbuttonpressed:(id)sender {
    
    
    [self presentDetailController:lastDetailViewController];
    
    
    
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
