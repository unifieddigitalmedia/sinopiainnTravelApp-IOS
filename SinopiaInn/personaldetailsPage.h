//
//  personaldetailsPage.h
//  SinopiaInn
//
//  Created by Machel Slack on 15/01/2017.
//  Copyright © 2017 Machel Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guestContainerViewController.h"


@interface personaldetailsPage : UITableViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,guestContainer,UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate>
{
    
    
    NSString* emailTEXT;
    
    NSString* phoneTEXT;
    
    NSString* nameTEXT;
    
}

@property(nonatomic,retain) UIButton *gotoPersonalDetails;

@property(nonatomic,retain) UITableView *mainTableView;

@property(nonatomic,retain) UIButton *checkAvailabilitybutton;

@property(nonatomic,retain) UIColor *myColor;

@property(nonatomic, readwrite) int width;

@property(nonatomic, readwrite) int height;

@property(nonatomic,retain) NSString* emailTEXT;

@property(nonatomic,retain) NSString* phoneTEXT;

@property(nonatomic,retain) NSString* nameTEXT;

@property(nonatomic,retain) UITextView* personaldetailserror;

@property(nonatomic,retain) UIImageView* imageView;


- (id)initWithHeight:(int)width initWithWidth:(int)height;

@end
