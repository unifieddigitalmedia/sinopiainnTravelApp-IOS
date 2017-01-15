//
//  recipesPage.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guestContainerViewController.h"
#import "checkedinguestContainer.h"


@interface recipesPage : UIViewController <checkedinguestContainer,guestContainer,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    UICollectionView *_collectionView;
    
    
    
}

@property(nonatomic,retain) NSArray* jsonArray;
@property(nonatomic,retain) NSArray* jsonDictArray;

@property(nonatomic, readwrite) NSInteger width;
@property(nonatomic, readwrite) NSInteger height;
@property(nonatomic, readwrite) NSData *imagedata;
@property(nonatomic, readwrite) UIVisualEffectView *blurEffectView;

- (id)initWithHeight:(int)width initWithWidth:(int)height initWithArray:(NSArray*)width initWithDictArray:(NSArray*)thejsonDictArray;


- (id)initWithHeight:(int)width initWithWidth:(int)height initWithArray:(NSArray*)width ;


-(UIImageView*)myLoadImage:(NSString*)named at:(CGPoint)location;
@end
