//
//  miscData.h
//  SinopiaInnTravelApp
//
//  Created by Machel Slack on 12/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface miscData : NSObject

@property (strong, nonatomic) NSArray *photoFiles;

@property (strong, nonatomic) NSArray *timelineFiles;

@property (strong, nonatomic) NSMutableArray *imageFiles;

@property (strong, nonatomic) NSMutableArray *imageDictFiles;

@property (strong, nonatomic) NSMutableArray *commentFiles;

@property (strong, nonatomic) NSMutableArray *menuFiles;

@property (strong, nonatomic) NSMutableArray *bookFiles;

@property (strong, nonatomic) NSMutableArray *genre;



+ (id)sharedManager;

- (void)reloadpicturefiles;

- (void)reloadtimelinefiles;

- (void)getPhotofiles:(NSArray*)imageFiles;

- (void)getCommentfiles;

- (void)getMenufiles:(NSString*)url;

- (void)getBooksfiles:(NSString*)url;

@end
