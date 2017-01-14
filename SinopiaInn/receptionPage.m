//
//  receptionPage.m
//  SinopiaInn
//
//  Created by Machel Slack on 16/08/2016.
//  Copyright © 2016 Machel Slack. All rights reserved.
//

#import "receptionPage.h"

@interface receptionPage ()

@end

@implementation receptionPage


@synthesize mainTableView;
@synthesize mainButton;
@synthesize mainScrollview;
@synthesize mainPagecontroller;
@synthesize myColor;

@synthesize sinopia;
@synthesize titles;
@synthesize descriptions;
@synthesize width;
@synthesize height;

- (id)initWithHeight:(int)theheight initWithWidth:(int)thewidth {
    
    
    self = [super init];
    
    width = thewidth;
    
    height = theheight;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    titles = [NSArray arrayWithObjects: @"BOOK NOW", @"BOOK NOW", @"GET RECIPES", @"PLAN A TRIP", nil];
    
    
    NSArray *images = [NSArray arrayWithObjects: @"room1.JPG", @"rewards.jpg", @"food.png", @"leisure_travel.png", nil];
    
   
    
    
    descriptions = [NSArray arrayWithObjects: @"The rooms are fitted with double beds and ensuite bathrooms. In an environment that will give you relaxation and tranquility needed for a great nights sleep", @"What makes us truly exclusive are our offers, discounted rates and the amazing range of experiences – authentic adventures that explore behind the scenes and beneath the surface to discover Jamaica’s hidden gems. These unique experiences are specially tailored to immerse you in Portland’s surroundings and make your time with us unforgettable. Book with us today and start to receive promo codes for member-only rates and special offers", @"The taste of our traditional breakfast is real foodie territory.Its where you'll find rare and flavoursome West Indian dishes with a fusion of international spices from countries across the globe.", @"Head to Portland Jamaica and plan your own trip with Dragon Bay Inn to venues across the island where you’ll find rare flavoursome dishes, estates of coffee premium liquors and a natural blend of fruits to produce a exotic taste made for paradise. Experience relaxing oceanic view, lush green mountain tops and skies streaking with colour as our island excursion include experimental trips; local culture; multi generation travel ; authentic activities and a personalised service provided by the local people of Jamaica.", nil];
  
    
    myColor = [UIColor colorWithRed:170.0f/255.0f green:157.0f/255.0f blue:46.0f/255.0f alpha:1.0f];
    
    sinopia = [UIColor colorWithRed:126.0f/255.0f green:126.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
    
    mainScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,width,height)];
    
    mainScrollview.backgroundColor=[UIColor blackColor];
    
    [mainScrollview setShowsHorizontalScrollIndicator:NO];
    
    [mainScrollview setShowsVerticalScrollIndicator:NO];
    
    mainScrollview.delegate=self;
    
    mainScrollview.pagingEnabled=YES;
    
    [mainScrollview setContentSize:CGSizeMake(mainScrollview.frame.size.width*4, mainScrollview.frame.size.height)];
    
    mainPagecontroller = [[UIPageControl alloc]initWithFrame: CGRectMake(0,0,mainScrollview.frame.size.width,200)];
    
    
    [mainPagecontroller setCurrentPageIndicatorTintColor:myColor];
    
    mainPagecontroller.numberOfPages = 4;
    
    mainPagecontroller.currentPage = 0;
    
    [mainPagecontroller addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:mainPagecontroller];
    
    
    
    for(int i=0;i < [titles count] ; i++)
        
    {
        
        CGRect frame;
        
        frame.origin.x = mainScrollview.frame.size.width * i;
        
        frame.origin.y = 0;
        
        frame.size =  mainScrollview.frame.size;
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake((mainScrollview.frame.size.width * i),0,mainScrollview.frame.size.width,mainScrollview.frame.size.height) style:UITableViewStylePlain];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
       
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, headerView.frame.size.height)];
        
    
        imageView.image = [UIImage imageNamed:[images objectAtIndex:i]];
        
        [headerView addSubview:imageView];
 
        mainTableView.tableHeaderView = headerView;
        
        mainTableView.delegate = self;
        
        mainTableView.dataSource = self;
        
        mainTableView.bounces = NO;
        
        mainTableView.tag = i;
        
        mainTableView.scrollEnabled = YES;
        
        mainTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
        
        mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        mainTableView.rowHeight = UITableViewAutomaticDimension;
        
        mainTableView.estimatedRowHeight = 44.0;
        
        [mainScrollview addSubview:mainTableView];
        
        
        
    }
    
    [self.view addSubview:mainScrollview];
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
    CGFloat viewWidth = mainScrollview.frame.size.width;
    // content offset - tells by how much the scroll view has scrolled.
    
    int pageNumber = floor((mainScrollview.contentOffset.x - viewWidth/50) / viewWidth) +1;
    
    mainPagecontroller.currentPage=pageNumber;
    
}

- (void)pageChanged {
    
    long pageNumber = mainPagecontroller.currentPage;
    
    CGRect frame = mainScrollview.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [mainScrollview scrollRectToVisible:frame animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        if(indexPath.row == 0 )
            
        {
            
            
            mainButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            mainButton.tag = tableView.tag;
            
            mainButton.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
            
            [mainButton setTitle:[titles objectAtIndex:mainButton.tag] forState:UIControlStateNormal];
            
            [mainButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
            
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            mainButton.titleLabel.font = cellFont;
            
            [mainButton addTarget:self action:@selector(gotoOptionpage:) forControlEvents:UIControlEventTouchUpInside];
            
            [[mainButton layer] setBorderWidth:0.5f];
            
            [[mainButton layer] setBorderColor:myColor.CGColor];
            
            [mainButton setTitleColor:myColor forState:UIControlStateNormal];
            
            [cell.contentView addSubview:mainButton];
            
            return  cell;
            
            
        }
        
        else if(indexPath.row == 1 )
            
        {
            
            
            
            
            [cell.textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            cell.textLabel.text = [descriptions objectAtIndex:mainButton.tag] ;

            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
            
            [cell.textLabel setTextColor:sinopia];
            
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            
            cell.backgroundColor = [UIColor clearColor];
            
            return  cell;
            
            
        }
        
        
    
    
    return cell;
    
    
}


- (IBAction)gotoOptionpage:(id)sender {
    
    id <guestContainer> parentViewController = (id)self.parentViewController;
    
    
    
     [[NSUserDefaults standardUserDefaults] setInteger:[sender tag] forKey:@"optionPage"];
    
    switch ([sender tag]) {
        case 0:
            
            
            
            [parentViewController gotoReservationpage];
            
            break;
        case 1:
            
            [parentViewController gotoReservationpage];
            
            break;
        case 2:
            
             [parentViewController gotoRecipespage];
            
            break;
        case 3:
            
            [parentViewController gotoTripplannerpage];

            
            break;
            
        default:
            break;
    }
    
    
    
    
}



@end
