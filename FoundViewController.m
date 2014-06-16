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
    imgURL = [imgURL stringByReplacingOccurrencesOfString:@"\"" withString:@""];
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
    
    UITapGestureRecognizer *singleTapFound = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedFound)];
    singleTapFound.numberOfTapsRequired = 1;
    foundButton.userInteractionEnabled = YES;
    [foundButton addGestureRecognizer:singleTapFound];
    
    //clear the notification from alertDS
    
    beaconId = [foundData objectForKey:@"beaconId"];
    beaconId = [NSString stringWithFormat:@"%@",beaconId];
    
    beaconId = [beaconId stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    //remove the beacon Id
    [alertDS removeObjectForKey:beaconId];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
 
}

UIAlertView *av;

-(void)tapDetectedFound{ //flag will always be true
    //show alert processing
    
    NSLog(@"single Tap on tap detected report button");
    
   
    
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    [jsonDictionary setValue:@"false" forKey:beaconId];
    
    NSError *error;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    av = [[UIAlertView alloc] initWithTitle:@"Processing..." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [av show];
    
    
    
    [self updateReportingStatus:jsonString];
    

    [self updateLocalDatabase:beaconId :@"false"];
    
    [av dismissWithClickedButtonIndex:0 animated:NO];
    
}


-(void)updateLocalDatabase:(NSString*) beaconID :(NSString*) flagN{
    static sqlite3 *database = nil;
    NSString *databasePath;
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"lostDatabase.db"]];
    const char *dbpath = [databasePath UTF8String];
    
    static sqlite3_stmt *compiledStatement;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *sqlStatement = [[NSString stringWithFormat:@"UPDATE LOST SET REPORT = \"%@\" where BEACONID = \"%@\"",flagN,beaconID] UTF8String];
        
        int result = sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        if(result == SQLITE_OK) {
            if(SQLITE_DONE != sqlite3_step(compiledStatement))
                NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
            sqlite3_reset(compiledStatement);
        }else{
            if(result != SQLITE_OK) {
                NSLog(@"Prepare-error #%i: %s", result, sqlite3_errmsg(database));
            }
        }
        
    }
    
    // Release the compiled statement from memory
    sqlite3_finalize(compiledStatement);
    sqlite3_close(database); //close the database
    
}


-(void)updateReportingStatus :(NSString*) jsonString{
    
    
    //pass two array to post request, reporting flags and corresponding beacon Id
    NSString *post = [NSString stringWithFormat:@"jsonData=%@",jsonString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://localhost:8080/BloodHoundBackend/ReportPeople"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse* response;
    NSError* error = nil;
    
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    NSString *content = [NSString stringWithUTF8String:[result bytes]];
    NSLog(@"responseData: %@", content);
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:result options:0 error:&localError];
    
    
    if (localError != nil) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                              message:@"Reporting Successful"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }else{
        //success
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Reporting Failed, Please try later"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
    
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
