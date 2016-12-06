//
//  miscData.m
//  SinopiaInnTravelApp
//
//  Created by Machel Slack on 12/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "miscData.h"
#import <UIKit/UIKit.h>

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
+ (id)sharedManager {
    static miscData *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)reloadpicturefiles {
 
    imageDictFiles = [[NSMutableArray alloc] init];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.sinopiainn.com/api/images/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
         photoFiles =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
      
        [self getPhotofiles:photoFiles];
        
        
            for (int x = 0 ; x < [photoFiles count] ; x++){
                
                [imageDictFiles addObject:[photoFiles objectAtIndex:x]];
            }
        });
        
        
        
    }];
    
    [dataTask resume];

    
}


- (void)getPhotofiles:(NSArray*)photoFiles {
    
    
    imageFiles = [[NSMutableArray alloc] init];
    
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
     
        for(int x = 0 ; x < [photoFiles count]; x++){
            
            
    
NSString *fullurl  = [[NSString stringWithFormat:@"http://www.sinopiainn.com/%@",[[photoFiles objectAtIndex:x] objectForKey:@"image_url"]]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
         

            
            NSData *imgData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:fullurl]];

         
                    [imageFiles addObject:imgData];
                
            
          
        
            

        }
        
       
    });

    
}
- (void)reloadtimelinefiles {
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.URLCache = NULL;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://www.sinopiainn.com/api/timeline?name=Machel Slack", [[NSUserDefaults standardUserDefaults] objectForKey:@"name"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            timelineFiles =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            
        });
        
        
        
    }];
    
    [dataTask resume];
    
    
}

- (void)getCommentfiles {
    
    
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
    
    
}

- (void)getMenufiles:(NSString*)url {
    
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
                     
                 
                         
                    [review setObject:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[innerRESULT objectAtIndex:y] objectForKey:@"image_url"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]] forKey:@"image"];
                         
                         
                 
 
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

    
    
}

- (void)getBooksfiles:(NSString*)url{
    
    bookFiles = [[NSMutableArray alloc] init];

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
                
                [review setObject:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[innerRESULT objectAtIndex:y] objectForKey:@"image_url"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]] forKey:@"image"];
                
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"type"] forKey:@"type"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"name"] forKey:@"name"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"description"] forKey:@"description"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"method"] forKey:@"method"];
                    
                    [review setObject:[[innerRESULT objectAtIndex:y] objectForKey:@"pdf"] forKey:@"pdf"];
                

                    [genre addObject:review ];
                    
                
          
                
                
                
            }
            
            
            [bookFiles addObject:genre ];
            
            
            
        }
        
        
    }];
    
    [dataTask resume];

}

@end
