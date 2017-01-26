//
//  miscData.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface miscData : NSObject

@property (strong, nonatomic) NSArray *photoFiles;

@property (strong, nonatomic) NSArray *timelineFiles;

@property (strong, nonatomic) NSMutableArray *imageFiles;

@property (strong, nonatomic) NSMutableArray *imageDictFiles;

@property (strong, nonatomic) NSMutableArray *commentFiles;

@property (strong, nonatomic) NSMutableArray *menuFiles;

@property (strong, nonatomic) NSMutableArray *bookFiles;

@property (strong, nonatomic) NSMutableArray *genre;

@property (strong, nonatomic) NSMutableArray *bookgenre;

@property (assign) Boolean Menufiles;

@property (assign) Boolean Booksfiles;

@property (assign) Boolean timeline;

@property (assign) Boolean picturefiles;

@property (assign) Boolean Commentfiles;

+ (id)sharedManager;

- (void)reloadpicturefiles;

- (void)reloadtimelinefiles:(NSString *)url;

- (void)getCommentfiles;

- (void)getMenufiles:(NSString*)url;

- (void)getBooksfiles:(NSString*)url;




@end
