//
//  ChatViewController.m
//  SinopiaInnApp
//
//  Created by Machel Slack on 14/11/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

@synthesize message;
@synthesize width;
@synthesize height;
@synthesize jsonArray;
@synthesize sendBtn;
@synthesize messageLog;
@synthesize messages;
@synthesize cellheight;
static CGFloat padding = 20.0;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth initWithArray:(NSArray*)thejsonArray{
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    jsonArray = thejsonArray;
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
      message = [[UITextField alloc] initWithFrame:CGRectMake(width / 1.5,height - 200,width,200)];

      [self.view addSubview:message];
    
    
      sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(message.frame.size.width,height - 200,width - message.frame.size.width , 200)];
    
      [self.view addSubview:message];
    
    
    messageLog = [[UITableView alloc] initWithFrame:CGRectMake(0,0,width  , height - 200)];
    
    messageLog.bounces = NO;
    
    messageLog.scrollEnabled = YES;
    
    messageLog.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
    messageLog.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    messageLog.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    messageLog.rowHeight = UITableViewAutomaticDimension;
    
    messageLog.estimatedRowHeight = 44.0;


    [self.view addSubview:messageLog];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage {
    
    NSString *messageStr = self.message.text;
    
    if([messageStr length] > 0) {
        
    
        NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
        [msg setObject:@"you" forKey:@"sender"];
        [msg setObject:[self getCurrentTime] forKey:@"time"];
        [messages addObject:msg];
        
        
    }
    
  
}


-(NSString *) getCurrentTime {
    NSDate *nowUTC = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    return [dateFormatter stringFromDate:nowUTC];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = (NSDictionary *)[messages objectAtIndex:indexPath.row];
 
    
    CGSize  textSize = { 260.0, 10000.0 };
    
//sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]
    
    
//boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary<NSString *,id> *)attributes context:;
    
    CGRect textRect = [[dict objectForKey:@"msg"] boundingRectWithSize:textSize
                                             options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                          attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13] }
                                             context:nil];
   
    //CGSize size = [[dict objectForKey:@"msg"] sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    
    textRect.size.height += padding*2;
    
    cellheight =  textRect.size.height < 65 ? 65 :  textRect.size.height;
    
    
    return cellheight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [messages count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *s = (NSDictionary *) [messages objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
   
    NSString *sender = [s objectForKey:@"sender"];
 
   // NSString *time = [s objectForKey:@"time"];
    
    CGSize  textSize = { 260.0, 10000.0 };
    
   // CGSize size = [ [s objectForKey:@"msg"] sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    
    
    CGRect textRect = [ [s objectForKey:@"msg"] boundingRectWithSize:textSize
                                                               options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                            attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13] }
                                                               context:nil];
   
    
    textRect.size.width += (padding/2);
    
    
    cell.textLabel.text =  [s objectForKey:@"msg"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    
    UIImage *bgImage = nil;
    
    
    if ([sender isEqualToString:@"you"]) { // left aligned
        
        bgImage = [[UIImage imageNamed:@"orange.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
        
        [cell.textLabel setFrame:CGRectMake(padding, padding*2, textRect.size.width, textRect.size.height)];
        
       // [cell.textLabel bgImageView setFrame:CGRectMake( cell.messageContentView.frame.origin.x - padding/2,cell.text.frame.origin.y - padding/2,size.width+padding,size.height+padding)];
        
    } else {
        
        bgImage = [[UIImage imageNamed:@"aqua.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
        
        [cell.textLabel setFrame:CGRectMake(320 - textRect.size.width - padding,
                                                     padding*2,
                                                     textRect.size.width,
                                                     textRect.size.height)];
        
        //[cell.bgImageView setFrame:CGRectMake(cell.messageContentView.frame.origin.x - padding/2,cell.messageContentView.frame.origin.y - padding/2,size.width+padding,size.height+padding)];
        
    }
    
    //cell.bgImageView.image = bgImage;
    //cell.senderAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", sender, time];
    
    return cell;
    
}


@end
