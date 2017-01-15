//
//  checkedInProtocol.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#ifndef checkedInProtocol_h
#define checkedInProtocol_h
#endif /* checkedInProtocol_h */

@protocol checkedinguestContainer <NSObject>

@optional
- (void)showmenu;
- (void)gottoOurVilla ;
- (void)gotoTime ;
- (void)goToWeather ;
- (void)gotoTravel ;
- (void)gotoMenu ;
- (void)gotoBooks ;
- (void)goToReviews ;
- (void)gotoChannels ;
- (void)gotoMap ;
- (void)gotPhotos:(NSArray*)jsonArray;
- (void)gotoNewCommentpage ;
- (void)gotoItemdescriptionpage:(NSDictionary*)jsonDictionary;
- (void)gotoOptionspage:(NSArray*)jsonArray;
- (void)returnedbuinessTypesArray:(NSArray*)jsonArray;
- (void)returnedserviceTypesArray:(NSArray*)jsonArray;
- (void)returnedplacesTypesArray:(NSArray*)jsonArray;
- (void)gotoplacedescriptionpage:(NSDictionary*)jsonDictionary;
- (void)gotoTripplannerpageList;
- (void)gotoItemlist:(NSArray*)jsonArray;
- (void)gotoPersonalDetails;
- (void)gotoMap:(double)myLatitude withLongitude:(double)myLongitude;
- (void)gotoOptionspageWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray ;
- (void)gotoOptionspageBWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray ;
- (void)gotoReservationpage;
- (void)gotoBigPhoto:(NSDictionary*)jsonArray;
- (void)uploadSnap:(NSString*)message withLocation:(NSString*)location;


@optional
@property(nonatomic,retain) NSMutableArray *itineraryArray;
@property(nonatomic,retain) NSArray *businessesArray;
@property(nonatomic,retain) NSArray *businessTypesArray;
@property(nonatomic,retain) NSArray *serviceTypesArray;
@property(nonatomic,retain) NSArray *placesArray;

@end

@protocol guestContainer <NSObject>


@optional
- (void)gotoReservationpage;
- (void)gotoTripplannerpage;
- (void)gotoRecipespage;
- (void)gotoBill;
- (void)gotoOptionspage:(NSArray*)jsonArray;
- (void)calculateTotal;
- (void)returnedoffersArray:(NSArray*)jsonArray ;
- (void)calculateDateDifference:(NSDate*)fromDateTime todate:(NSDate*)toDateTime;
- (void)gotoItemdescriptionpage:(NSDictionary*)jsonDictionary;
- (void)returnedroomsArray:(NSArray*)jsonArray;
- (void)returnedamenitiesArray:(NSArray*)jsonArray;
- (void)returnedbuinessTypesArray:(NSArray*)jsonArray;
- (void)returnedserviceTypesArray:(NSArray*)jsonArray;
- (void)returnedplacesTypesArray:(NSArray*)jsonArray;
- (void)gotoplacedescriptionpage:(NSDictionary*)jsonDictionary;
- (void)gotoTripplannerpageList;
- (void)gotoItemlist:(NSArray*)jsonArray;
- (void)gotoPersonalDetails;
- (void)gotoPayment;
- (void)gotoOptionspageWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray ;
- (void)gotoOptionspageBWithimages:(NSArray*)jsonArray withImages:(NSMutableArray*)iconArray ;
- (void)gotoMap:(double)myLatitude withLongitude:(double)myLongitude;
- (void)uploadSnap:(NSString*)message withLocation:(NSString*)location;

@optional
@property(nonatomic,retain) NSString *fromdate;
@property(nonatomic,retain) NSString *todate;
@property(nonatomic,retain) NSArray *validation;
@property(nonatomic,assign) NSInteger num_days;
@property(nonatomic,retain) NSMutableArray *itineraryArray;
@property(nonatomic,retain) NSArray *roomsArray;
@property(nonatomic,retain) NSArray *offersArray;
@property(nonatomic,retain) NSArray *amentitiesArray;
@property(nonatomic,assign) int num_guest;
@property(nonatomic,assign) float total;
@property(nonatomic,assign) float tax;
@property (nonatomic, strong) NSData *jpgData;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSArray *businessesArray;
@property(nonatomic,retain) NSArray *businessTypesArray;
@property(nonatomic,retain) NSArray *serviceTypesArray;
@property(nonatomic,retain) NSArray *placesArray;


@end
