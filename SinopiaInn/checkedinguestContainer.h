//
//  checkedinguestContainer.h
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "checkedInProtocol.h"

@interface checkedinguestContainer : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIApplicationDelegate ,UIPickerViewDelegate, UIPickerViewDataSource, NSURLConnectionDelegate>

{
    NSMutableData *_responseData;
}

@property UIViewController  *currentDetailViewController;

@property UIViewController  *lastDetailViewController;

@property (retain, nonatomic) IBOutlet UIView *detailView;

@property (nonatomic, strong) NSData *jpgData;

-(void) addDetailController:(NSArray*)jsonArray;

-(void) gotoPersonalDetails;

-(void) gotoBill;

-(void) confirmPayment;

-(void) gotoReservationpage;

-(void) gotoRecipespage;

-(void) gotoMap;

-(void) gotPhotos:(NSArray*)jsonArray;

-(void) gotoOptionspage:(NSArray*)jsonArray;

-(void) gotoItemdescriptionpage:(NSDictionary*)jsonDictionary;

-(void) returnedbuinessTypesArray:(NSArray*)jsonArray;

-(void) returnedserviceTypesArray:(NSArray*)jsonArray;

-(void) returnedplacesTypesArray:(NSArray*)jsonArray;

-(void) uploadSnap:(NSString*)message withLocation:(NSString*)location;


-(void) gotoplacedescriptionpage:(NSDictionary*)jsonDictionary;
-(void) gotoTripplannerpageList;
-(void) gotoBigPhoto:(NSDictionary*)jsonDict;
-(void) gotoItemlist:(NSArray*)jsonArray ;
-(void)showmenu;
-(void) gottoOurVilla ;
-(void) gotoTime ;
-(void) goToWeather ;
-(void) gotoTravel ;
-(void) gotoMenu ;
-(void) gotoBooks ;
-(void) goToReviews ;
-(void) gotoChannels ;

@property (retain, nonatomic) IBOutlet UIToolbar *HomePageToolbar;

@property(nonatomic,retain) UIColor *myColor;

@property(nonatomic,retain) UIColor *sinopia;

@property (strong, nonatomic) NSArray *menuNames;

@property (strong, nonatomic) NSArray *imageData;

@property (strong, nonatomic) UIPickerView *bottomMenu;

@property(nonatomic,retain) NSArray *businessTypesArray;

@property(nonatomic,retain) NSArray *serviceTypesArray;

@property(nonatomic,retain) NSArray *placesArray;

@property(nonatomic,retain) NSString *str_types;

@property(nonatomic,retain) NSString *str_services;

@property(nonatomic,retain) NSString *str_places;

@property(nonatomic,retain) NSArray *guestjsonArray;

@property(nonatomic,retain) NSMutableArray *businessLoctionArray;
@property(nonatomic,retain) NSArray *businessesArray;

@property(nonatomic,retain) NSMutableArray *itineraryArray;


@property(nonatomic,retain) UIView *snackBar;

@property(nonatomic,retain) UILabel *snackBarLabel;


@end

