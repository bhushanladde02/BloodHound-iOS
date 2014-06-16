//
//  FoundViewController.m
//  BloodHound
//
//  Created by William Grey on 6/9/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "FoundViewController.h"
#import  "AGMedallionView.h"
#import "TPKeyboardAvoidingScrollView.h""

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
    NSString *vicinityText = @"You are currently in the vicinity of";
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
    AGMedallionView *medallionView = [[AGMedallionView alloc] init];
    medallionView.image = [UIImage imageNamed:@"anonIcon100.png"];
    [self.view addSubview:medallionView];
    
    //distinguish Label
    CGRect distinguishLabelFrame = CGRectMake(20,290,280,30);
    UILabel *distinguishLabel = [[UILabel alloc] initWithFrame:distinguishLabelFrame];
    NSString *distinguishText = @"Distinguishing Features";
    [distinguishLabel setText: distinguishText];
    distinguishLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    distinguishLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:distinguishLabel];
    
    //distinguish Desc
    //populated from registration page
    CGRect distinguishDescLabelFrame = CGRectMake(20,320,280,20);
    UILabel *distinguishDescLabel = [[UILabel alloc] initWithFrame:distinguishDescLabelFrame];
    NSString *distinguishDescText = @"John has green hair and a purple tongue.";
    [distinguishDescLabel setText: distinguishDescText];
    distinguishDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    distinguishDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:distinguishDescLabel];
    
    //special notes Label
    CGRect specialLabelFrame = CGRectMake(20,350,280,30);
    UILabel *specialLabel = [[UILabel alloc] initWithFrame:specialLabelFrame];
    NSString *specialText = @"Special Notes";
    [specialLabel setText: specialText];
    specialLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    specialLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:specialLabel];
    
    //special notes Desc
    //populated from registration page
    CGRect specialDesclabelFrame = CGRectMake(20,380,280,20);
    UILabel *specialDescLabel = [[UILabel alloc] initWithFrame:specialDesclabelFrame];
    NSString *specialDescText = @"John Doe is allergic to the medications Suprax and Sulpha. He does not respond well to physical confinement.";
    [specialDescLabel setText: specialDescText];
    specialDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    specialDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:specialDescLabel];
    
    //directions Label
    CGRect directionsLabelFrame = CGRectMake(20,410,280,30);
    UILabel *directionsLabel = [[UILabel alloc] initWithFrame:directionsLabelFrame];
    //directionsLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *directionsText = @"Directions if Found";
    [directionsLabel setText: directionsText];
    directionsLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    directionsLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:directionsLabel];
    
    //directions Desc
    //populated from registration page
    CGRect directionsDesclabelFrame = CGRectMake(20,440,280,20);
    UILabel *directionsDescLabel = [[UILabel alloc] initWithFrame:directionsDesclabelFrame];
    //[directionsDescLabel sizeToFit];
    //directionsDescLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *directionsDescText = @"Please call John's wife, Jane Doe, at (999) 888-7777 to inform her of her husband's current location.";
    [directionsDescLabel setText: directionsDescText];
    directionsDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    directionsDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:directionsDescLabel];
    
    // [self.view insertSubview:backgroundImageView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *foundButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320-602/2)/2, 470, 602/2, 159/2)];
    foundButton.image  = [UIImage imageNamed:@"found.png"];
    [self.view addSubview:foundButton];
    
    
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
