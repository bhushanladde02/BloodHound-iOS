//
//  RegisterViewController.m
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "RegisterViewController.h"
#import "APPViewController.h"


@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    //[self.view addSubview:scrollView];
     self.view = scrollView;
    

    self.view.backgroundColor = [UIColor whiteColor];

    
    //custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width/5, buttonImage.size.height/5);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    
    //list all fonts for app  //debug point
    /*NSArray *fontFamilies = [UIFont familyNames];
     for (int i = 0; i < [fontFamilies count]; i++)
     {
     NSString *fontFamily = [fontFamilies objectAtIndex:i];
     NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
     NSLog (@"%@: %@", fontFamily, fontNames);
     }*/
    
    
    //register Label
    CGRect registerlabelFrame = CGRectMake(20,10,280,60);
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:registerlabelFrame];
    //registerLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *registerText = @"Register";
    [registerLabel setText: registerText];
    registerLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:30];
    registerLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:registerLabel];

    //register Desc
    CGRect registerDesclabelFrame = CGRectMake(20,70,280,60);
    UILabel *registerDescLabel = [[UILabel alloc] initWithFrame:registerDesclabelFrame];
    registerDescLabel.numberOfLines = 0;
    //[registerDescLabel sizeToFit];
    //registerDescLabel.backgroundColor = [UIColor greenColor];  //debug point
    NSString *registerDescText = @"Provides info on what’s protected. Provides info on what’s protected. Provides info on what’s protected.";
    [registerDescLabel setText: registerDescText];
    registerDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    registerDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:registerDescLabel];

    CGRect namelabelFrame = CGRectMake(20,130,280,30);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:namelabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    nameLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *nameText = @"Name";
    [nameLabel setText: nameText];
    nameLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:nameLabel];
    
    CGRect nameInputLabelFrame = CGRectMake(20,160,280,30);
    UITextField *textField = [[UITextField alloc] initWithFrame:nameInputLabelFrame];
    textField.text = @"Name and Last Name";
    //textField.layer.borderWidth = 1;
    //textField.layer.borderColor = [[self colorWithHexString:@"242424"] CGColor ];
    textField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:textField];
    
    CGRect addresslabelFrame = CGRectMake(20,190,280,30);
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:addresslabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    addressLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *addressText = @"Address";
    [addressLabel setText: addressText];
    addressLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:addressLabel];
    
    CGRect addressInputLabelFrame = CGRectMake(20,220,280,60);
    UITextView *addressInputField = [[UITextView alloc] initWithFrame:addressInputLabelFrame];
    addressInputField.text = [NSString stringWithFormat:@"Street Address%City,State,Zip Code", (unichar)0x2028];
    addressInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:addressInputField];
    
    CGRect photolabelFrame = CGRectMake(20,280,280,30);
    UILabel *photoLabel = [[UILabel alloc] initWithFrame:photolabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    photoLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *photoText = @"Photo";
    [photoLabel setText: photoText];
    photoLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:photoLabel];
    
    UIImageView *uploadButton = [[UIImageView alloc] initWithFrame:CGRectMake(  21/3, 310, 301/2, 62/2)];
    uploadButton.image  = [UIImage imageNamed:@"upload.png"];
    [self.view addSubview:uploadButton];
    
    UIImageView *cameraButton = [[UIImageView alloc] initWithFrame:CGRectMake(  42/3+301/2, 310, 301/2, 62/2)];
    cameraButton.image  = [UIImage imageNamed:@"camera.png"];
    [self.view addSubview:cameraButton];
    
    CGRect calllabelFrame = CGRectMake(20,341,280,30);
    UILabel *callLabel = [[UILabel alloc] initWithFrame:calllabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    callLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *callText = @"Call to Action";
    [callLabel setText: callText];
    callLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:callLabel];
    
    CGRect callInputLabelFrame = CGRectMake(20,371,280,60);
    UITextView *callInputField = [[UITextView alloc] initWithFrame:callInputLabelFrame];
    callInputField.text = @"What should a person do if they find your loved one?";
    callInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:callInputField];
    
    CGRect permlabelFrame = CGRectMake(20,431,280,20);
    UILabel *permLabel = [[UILabel alloc] initWithFrame:permlabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    permLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *permText = @"Permissions";
    [permLabel setText: permText];
    permLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:permLabel];
    
    //permDesc Desc
    CGRect permDescDesclabelFrame = CGRectMake(20,451,280,60);
    UILabel *permDescDescLabel = [[UILabel alloc] initWithFrame:permDescDesclabelFrame];
    permDescDescLabel.numberOfLines = 0;
    //[permDescDescLabel sizeToFit];
    //permDescDescLabel.backgroundColor = [UIColor greenColor];  //debug point
    NSString *permDescDescText = @"Bloodhound requires push notifications and active bluetooth to function";
    [permDescDescLabel setText: permDescDescText];
    permDescDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    permDescDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:permDescDescLabel];
    
    
    CGRect acceptlabelFrame = CGRectMake(40,511,280,20);
    UILabel *acceptLabel = [[UILabel alloc] initWithFrame:acceptlabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    acceptLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *acceptText = @"Accept";
    [acceptLabel setText: acceptText];
    acceptLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:acceptLabel];
    
    
    UIImageView *submitButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320 - 602/2)/2, 531 + 3, 602/2, 159/2)];
    submitButton.image  = [UIImage imageNamed:@"submit.png"];
    [self.view addSubview:submitButton];

    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    cameraButton.userInteractionEnabled = YES;
    [cameraButton addGestureRecognizer:singleTap];
    
}

-(void) tapDetected{
    NSLog(@"single Tap on imageview register button");
    APPViewController *appViewController = [[APPViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:appViewController animated:YES];

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
