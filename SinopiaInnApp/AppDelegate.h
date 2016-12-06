//
//  AppDelegate.h
//  SinopiaInnApp
//
//  Created by Machel Slack on 13/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

