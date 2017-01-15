//
//  recipesPage.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "recipesPage.h"

@interface recipesPage ()

@end

@implementation recipesPage

@synthesize jsonArray;
@synthesize width;
@synthesize height;
@synthesize imagedata;
@synthesize jsonDictArray;
@synthesize blurEffectView;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSArray*)thejsonArray initWithDictArray:(NSArray*)thejsonDictArray{
    
    self = [super init];
    
    
    
    jsonDictArray = thejsonDictArray;
    
    jsonArray = thejsonArray;
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}


- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSArray*)thejsonArray {
    
    self = [super init];
    
    jsonArray = thejsonArray;
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0,0,width,height) ];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin   |
                                  UIViewAutoresizingFlexibleRightMargin  |
                                  UIViewAutoresizingFlexibleTopMargin    |
                                  UIViewAutoresizingFlexibleBottomMargin);
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    [_collectionView setDataSource:self];
    
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    
    /* _collectionView.minimumInteritemSpacing = 1;
     minimumLineSpacing = 1
     scrollDirection = .Vertical*/
    
    _collectionView.center = CGPointMake(CGRectGetMidX(self.view.superview.bounds), CGRectGetMidY(self.view.superview.bounds));
    
    _collectionView.backgroundColor = [UIColor blackColor] ;
    
    //[self.view addSubview:_collectionView];
    
    // UIImageView* imageView = [UIImageView myLoadImage:@"image_filename" at:CGPointMake(150,100)];
    
    //[self.view addSubview:[self myLoadImage:@"room1.JPG" at:CGPointMake(0,0)]];
    
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    blurEffectView.frame =  CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height  );
    
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(( blurEffectView.frame.size.width / 2 -  (blurEffectView.frame.size.height / 4)),( blurEffectView.frame.size.height / 2 -  (blurEffectView.frame.size.height / 4 )), blurEffectView.frame.size.height / 2 , blurEffectView.frame.size.height / 2)];
    
    imageView.image = [UIImage imageNamed:@"room1.JPG"];
    
    
    [blurEffectView addSubview:imageView];
    
    [self.view addSubview:blurEffectView];
    
    
    NSLog(@"CENTER : - %ld", ( width / 2 -  (100)));
    
    //yourSubView.center = CGPointMake(yourView.frame.size.width  / 2,
    //yourView.frame.size.height / 2);
    
    UIView *viewObj = [[UIView alloc] initWithFrame:CGRectMake(( width / 2 -  (100)), ( height / 2 -  (50)), 200, 100)];
    viewObj.backgroundColor = [UIColor redColor];
    viewObj.translatesAutoresizingMaskIntoConstraints = NO;
    // [self.view addSubview:viewObj];
    
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:viewObj
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:200];
    //[viewObj addConstraint:cn];
    
    cn = [NSLayoutConstraint constraintWithItem:viewObj
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                     multiplier:1
                                       constant:200];
    //[viewObj addConstraint: cn];
    
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
    
    
}

-(UIImageView*)myLoadImage:(NSString*)named at:(CGPoint)location

{
    
    
    //UIView *viewObj = [[UIView alloc] initWithFrame:CGRectMake(( width / 2 -  (100)), ( height / 2 -  (50)), 200, 100)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:named]];
    
    CGRect frame = imgView.frame;
    
    //frame.origin.x = CGRectGetMidX(self.view.bounds) - CGRectGetMidX(imgView.bounds);
    
    //frame.origin.y = location.y;
    
    frame.size.width = 200;
    
    frame.size.height = 200;
    
    frame.origin.x = ( width / 2 -  (width / 4 ));
    
    frame.origin.y = ( height / 2 -  (height / 4 ));
    
    
    return imgView;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [jsonDictArray count];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    
    
    NSLog(@"url : - %@",[[jsonDictArray objectAtIndex:indexPath.row] objectForKey:@"image_url" ]);
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString: [[jsonDictArray objectAtIndex:indexPath.row] objectForKey:@"image_url" ]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"data returned");
        
        if (data) {
            
            NSLog(@"data returned not null ");
            
            UIImage *image = [UIImage imageWithData:data];
            
            if (image) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSLog(@"image returned");
                    
                    recipeImageView.image = image ;
                    
                    //cell.backgroundView = image ;
                    
                    cell.backgroundView = [[UIImageView alloc] initWithImage:image];
                    
                    [self.view addSubview:recipeImageView];
                    
                    [collectionView reloadData];
                    
                });
            }
        }else{
            
            NSLog(@"data returned  null ");
            
        }
    }];
    [task resume];
    
    
    
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger d = [jsonArray count] - 1;
    
    width = width - d;
    
    if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue] != 10 ){
        
        return CGSizeMake(width/2, width/2);
        
    }
    return CGSizeMake(width/3, width/3);
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkedIn"] intValue ] != 0){
        
        id <checkedinguestContainer> parentViewController = (id)self.parentViewController;
        
        
        if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"optionPage"] intValue] == 10 ){
            
            
            [parentViewController gotoBigPhoto:[jsonDictArray objectAtIndex:indexPath.row] ];
            
            
        }else{
            
            
            [parentViewController gotoOptionspage:[jsonArray objectAtIndex:indexPath.row] ];
            
            
        }
        
        
        
        
    }else{
        
        
        
        id <guestContainer> parentViewController = (id)self.parentViewController;
        
        [parentViewController gotoOptionspage:[jsonArray objectAtIndex:indexPath.row]];
        
        
        
    }
    
    
    
}

@end
