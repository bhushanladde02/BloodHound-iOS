//
//  FoundViewController.m
//  BloodHound
//
//  Created by William Grey on 6/9/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "FoundViewController.h"
#import  "AGMedallionView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "GlobalVars.h"
#import "UIImageView+WebCache.h"

@interface FoundViewController ()

@end

@implementation FoundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GlobalVars *globals = [GlobalVars sharedInstance];
    NSDictionary *foundData = globals.foundData;
    NSMutableDictionary *alertDS = globals.notificationDS;
    
    
    TPKeyboardAvoidingScrollView* scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    //scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    //scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    //[self.view addSubview:scrollView];
    self.view = scrollView;

    //custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"backButton.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    //vicinity Label
    CGRect vicinitylabelFrame = CGRectMake(20,10,280,22);
    UILabel *vicinityLabel = [[UILabel alloc] initWithFrame:vicinitylabelFrame];
    //vicinityLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *vicinityText = @"You are in the vicinity of";
    vicinityLabel.textAlignment = NSTextAlignmentCenter;
    [vicinityLabel setText: vicinityText];
    vicinityLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    vicinityLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:vicinityLabel];
    
    //full name Label
    //populated from registration page
    CGRect fullNameLabelFrame = CGRectMake(20,30,280,34);
    UILabel *fullNameLabel = [[UILabel alloc] initWithFrame:fullNameLabelFrame];
    //vicinityLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *fullNameText = @"John Doe";
    fullNameLabel.textAlignment = NSTextAlignmentCenter;
    [fullNameLabel setText: fullNameText];
    fullNameLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:30];
    fullNameLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:fullNameLabel];
    
    //Should get data from server
    
    NSString *imgURL = [foundData objectForKey:@"col9"];
    NSString *url = [NSString stringWithFormat:@"http://smallemperor.com:8080/images/%@",imgURL];
    
    NSLog([NSString stringWithFormat:@"Img url is %@",url]);
    
    AGMedallionView *medallionView = [[AGMedallionView alloc] init];
    medallionView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    [self.view addSubview:medallionView];
    
    //directions Label
    CGRect directionsLabelFrame = CGRectMake(20,290,280,20);
    UILabel *directionsLabel = [[UILabel alloc] initWithFrame:directionsLabelFrame];
    //directionsLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *directionsText = @"Directions if found:";
    [directionsLabel setText: directionsText];
    directionsLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    directionsLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:directionsLabel];
    
    //directions Desc
    //populated from registration page
    CGRect directionsDesclabelFrame = CGRectMake(20,310,280,32);
    UILabel *directionsDescLabel = [[UILabel alloc] initWithFrame:directionsDesclabelFrame];
    directionsDescLabel.lineBreakMode = UILineBreakModeWordWrap;
    directionsDescLabel.numberOfLines = 0;
    //[directionsDescLabel sizeToFit];
    //directionsDescLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *directionsDescText = @"Please call John's wife, Jane Doe, at (999) 888-7777 to inform her of her husband's current location.";
    [directionsDescLabel setText: directionsDescText];
    directionsDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    directionsDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:directionsDescLabel];
    
    // [self.view insertSubview:backgroundImageView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *foundButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320-602/2)/2, 415, 602/2, 159/2)];
    foundButton.image  = [UIImage imageNamed:@"found.png"];
    [self.view addSubview:foundButton];
    
    
    //clear the notification from alertDS
    
    NSString *beaconId = [foundData objectForKey:@"beaconId"];

    //remove the beacon Id
    [alertDS removeObjectForKey:beaconId];
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
