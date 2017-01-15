//
//  guestContainerViewController.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "checkedInProtocol.h"
#import "BraintreeCore.h"
#import "BraintreeDropIn.h"


@interface guestContainerViewController : UIViewController <NSURLConnectionDelegate>

{
    NSMutableData *_responseData;
    
}

@property UIViewController  *currentDetailViewController;

@property UIViewController  *lastDetailViewController;

@property (retain, nonatomic) IBOutlet UIView *detailView;

@property (nonatomic, strong) NSData *jpgData;


- (void) gotoMap:(double) myLatitude withLongitude:(double) myLongitude  ;

- (void)calculateTotal;

-(void) addDetailController:(NSArray*)jsonArray;

-(void) postNonceToServer:(NSString*) paymentMethodNonce;

-(void) gotoPersonalDetails;

-(void) gotoBill;

-(void) gotoPayment;



-(void) confirmPersonaldetails;

-(void) confirmPayment;

-(void) gotoReservationpage;

-(void) gotoTripplannerpage;

-(void) gotoRecipespage;

-(void) gotoOptionspage:(NSArray*)jsonArray;

-(void) gotoOptionspageWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray ;

-(void) gotoItemdescriptionpage:(NSDictionary*)jsonDictionary;

-(void) returnedbuinessTypesArray:(NSArray*)jsonArray;

-(void) returnedserviceTypesArray:(NSArray*)jsonArray;

-(void) returnedplacesTypesArray:(NSArray*)jsonArray;

-(void) returnedroomsArray:(NSArray*)jsonArray;

-(void) returnedoffersArray:(NSArray*)jsonArray ;

-(void) returnedamenitiesArray:(NSArray*)jsonArray;

- (void)calculateDateDifference:(NSDate*)fromDateTime todate:(NSDate*)toDateTime;

-(void) gotoplacedescriptionpage:(NSDictionary*)jsonDictionary;

-(void) gotoItemlist:(NSArray*)jsonArray;



@property (retain, nonatomic) IBOutlet UIToolbar *HomePageToolbar;

@property(nonatomic,retain) NSArray *businessesArray;

@property(nonatomic,retain) NSMutableArray *businessLoctionArray;

@property(nonatomic,retain) NSArray *businessTypesArray;

@property(nonatomic,retain) NSArray *serviceTypesArray;

@property(nonatomic,retain) NSArray *placesArray;


@property(nonatomic,retain) NSString *str_types;
@property(nonatomic,retain) NSString *str_services;
@property(nonatomic,retain) NSString *str_places;



@property(nonatomic,retain) UIColor *myColor;

@property(nonatomic,retain) UIColor *sinopia;

@property(nonatomic,retain) NSArray *roomsArray;

@property(nonatomic,retain) NSArray *offersArray;

@property(nonatomic,retain) NSArray *amentitiesArray;

@property(nonatomic,retain) NSArray *validation;

@property(nonatomic,retain) NSString *str_rooms;

@property(nonatomic,retain) NSString *str_amenities;

@property(nonatomic,retain) NSString *fromdate;

@property(nonatomic,retain) NSString *todate;

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *email;

@property(nonatomic,retain) NSString *fullurl;

@property(nonatomic,assign) int numofadults;
@property(nonatomic,assign) int numofchildren;
@property(nonatomic,assign) int numofinfants;

@property(nonatomic,assign) int num_guest;


@property(nonatomic,assign) NSInteger num_days;
@property(nonatomic,assign) float total;
@property(nonatomic,assign) float tax;
@property(nonatomic,assign) float amenity_amt;
@property(nonatomic,assign) float subtotal;


@property(nonatomic,assign) float discount;

@property(nonatomic,retain) NSMutableArray *itineraryArray;




@end
