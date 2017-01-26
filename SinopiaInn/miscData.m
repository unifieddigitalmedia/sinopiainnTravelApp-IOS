//
//  miscData.m
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import "miscData.h"

@interface miscData ()

@end

@implementation miscData


@synthesize photoFiles;
@synthesize timelineFiles;
UIImage *imageforArray;
@synthesize imageFiles;
@synthesize commentFiles;
@synthesize menuFiles;
@synthesize bookFiles;
@synthesize imageDictFiles;
@synthesize genre;
@synthesize Menufiles;
@synthesize bookgenre;
@synthesize Booksfiles;

@synthesize timeline;

@synthesize picturefiles;

@synthesize Commentfiles;

+ (id)sharedManager {
    static miscData *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)reloadpicturefiles {
    
    picturefiles = false;
    
    dispatch_group_t myGroup = dispatch_group_create();
    
    dispatch_group_async(myGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        
        
        imageDictFiles = [[NSMutableArray alloc] init];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configuration.URLCache = NULL;
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/images/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                photoFiles =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                for (int x = 0 ; x < [photoFiles count] ; x++){
                    
                    [imageDictFiles addObject:[photoFiles objectAtIndex:x]];
                    
                }
                
            });
            
            
        }];
        
        [dataTask resume];
        
        [NSThread sleepForTimeInterval:5.0];
        
        NSLog(@"Block1a End");
        
    });
    
    dispatch_group_async(myGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        
        
        
        imageFiles = [[NSMutableArray alloc] init];
        
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            
            for(int x = 0 ; x < [photoFiles count]; x++){
                
                
                
                NSString *fullurl  = [[NSString stringWithFormat:@"http://www.sinopiainn.com/%@",[[photoFiles objectAtIndex:x] objectForKey:@"image_url"]]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                
                
                
                NSData *imgData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:fullurl]];
                
                
                [imageFiles addObject:imgData];
                
                
                
                
                
                
            }
            
            
        });
        
        [NSThread sleepForTimeInterval:5.0];
        
        NSLog(@"Block2a End");
        
    });
    
    dispatch_group_notify(myGroup,dispatch_get_main_queue(), ^{
        
        picturefiles = true;
        
        NSLog(@"a Work is done!");
        
        
    });
    
    
}


- (void)reloadtimelinefiles:(NSString *)url {
    
    timeline = false;
    
    dispatch_group_t myGroup = dispatch_group_create();
    
    dispatch_group_async(myGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        // block1
        
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configuration.URLCache = NULL;
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:[[NSString stringWithFormat:url, [[NSUserDefaults standardUserDefaults] objectForKey:@"email"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                timelineFiles =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                
            });
            
            
            
        }];
        
        [dataTask resume];
        
        [NSThread sleepForTimeInterval:5.0];
        
        NSLog(@"Block1b End");
        
    });
    
    dispatch_group_notify(myGroup,dispatch_get_main_queue(), ^{
        
        
        timeline = true;
        
        NSLog(@"b Work is done!");
        
        
    });
    
    
}



- (void)getCommentfiles {
    
    Commentfiles = false;
    
    
    dispatch_group_t myGroup = dispatch_group_create();
    
    dispatch_group_async(myGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        
        
        commentFiles = [[NSMutableArray alloc] init];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configuration.URLCache = NULL;
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/reviews/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSArray *RESULT = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            for(int x = 0 ; x < [RESULT count]; x++){
                
                
                NSData *imgData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[[RESULT objectAtIndex:x] objectForKey:@"photofile"]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    NSMutableDictionary *review = [[NSMutableDictionary alloc] init];
                    
                    if(imgData != nil){
                        
                        [review setObject: imgData forKey:@"image"];
                        
                        
                    }
                    [review setObject:[[RESULT objectAtIndex:x] objectForKey:@"name"] forKey:@"name"];
                    
                    [review setObject:[[RESULT objectAtIndex:x] objectForKey:@"date"] forKey:@"date"];
                    
                    [review setObject:[[RESULT objectAtIndex:x] objectForKey:@"comment"] forKey:@"comment"];
                    
                    [review setObject:[[RESULT objectAtIndex:x] objectForKey:@"rating"] forKey:@"rating_img"];
                    
                    
                    [commentFiles addObject:review ];
                    
                    
                });
                
                
                
            }
            
            
        }];
        
        [dataTask resume];
        
        
        [NSThread sleepForTimeInterval:5.0];
        
        NSLog(@"Block1c End");
        
    });
    
    dispatch_group_notify(myGroup,dispatch_get_main_queue(), ^{
        
        
        Commentfiles = true;
        NSLog(@"c Work is done!");
        
        
    });
    
    
}


- (void)getMenufiles:(NSString*)url {
    
    Menufiles = false;
    
    
    dispatch_group_t myGroup = dispatch_group_create();
    
    dispatch_group_async(myGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        
        
        menuFiles = [[NSMutableArray alloc] init];
        
        
        genre = [[NSMutableArray alloc] init];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configuration.URLCache = NULL;
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSArray *RESULT = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            for(int x = 0 ; x < [RESULT count]; x++){
                
                
                NSArray *innerRESULT = [ [RESULT objectAtIndex:x] objectForKey:@"items"] ;
                
                genre = [[NSMutableArray alloc] init];
                
                
                for(int y = 0 ; y < [innerRESULT count]; y++){
                    
                    
                    
                    NSMutableDictionary *review = [[NSMutableDictionary alloc] init];
                    
                    
                    
                    //[review setObject:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[innerRESULT objectAtIndex:y] objectForKey:@"image_url"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]] forKey:@"image"];
                    
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"image_url"] forKey:@"image"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"type"] forKey:@"type"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"name"] forKey:@"name"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"description"] forKey:@"description"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"method"] forKey:@"method"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"pdf"] forKey:@"pdf"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"ingridients"] forKey:@"ingridients"];
                    
                    
                    
                    
                    [genre addObject:review ];
                    
                    
                }
                
                
                
                
                [menuFiles addObject:genre ];
                
            }
            
            
        }];
        
        [dataTask resume];
        
        
        
        [NSThread sleepForTimeInterval:5.0];
        
        NSLog(@"Block1d End");
        
    });
    
    dispatch_group_notify(myGroup,dispatch_get_main_queue(), ^{
        
        
        Menufiles = true;
        NSLog(@"d Work is done!");
        
        
    });
    
    
}

- (void)getBooksfiles:(NSString*)url{
    
    Booksfiles = false;
    
    
    dispatch_group_t myGroup = dispatch_group_create();
    
    dispatch_group_async(myGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        
        
        bookFiles = [[NSMutableArray alloc] init];
        
        bookgenre = [[NSMutableArray alloc] init];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configuration.URLCache = NULL;
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSArray *RESULT = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            for(int x = 0 ; x < [RESULT count]; x++){
                
                NSArray *innerRESULT = [ [RESULT objectAtIndex:x] objectForKey:@"items"] ;
                
                bookgenre = [[NSMutableArray alloc] init];
                
                for(int y = 0 ; y < [innerRESULT count]; y++){
                    
                    
                    NSMutableDictionary *review = [[NSMutableDictionary alloc] init];
                    
                    //[review setObject:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[innerRESULT objectAtIndex:y] objectForKey:@"image_url"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]] forKey:@"image"];
                    
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"image_url"] forKey:@"image"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"type"] forKey:@"type"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"name"] forKey:@"name"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"description"] forKey:@"description"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"method"] forKey:@"method"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"pdf"] forKey:@"pdf"];
                    
                    
                    [bookgenre addObject:review ];
                    
                    
                    
                    
                    
                    
                }
                
                
                [bookFiles addObject:bookgenre ];
                
                
                
            }
            
            
        }];
        
        [dataTask resume];
        
        [NSThread sleepForTimeInterval:5.0];
        
        NSLog(@"Block1d End");
        
    });
    
    dispatch_group_notify(myGroup,dispatch_get_main_queue(), ^{
        
        
        Booksfiles = true;
        NSLog(@"e Work is done!");
        
        
    });
    
    
}
@end
