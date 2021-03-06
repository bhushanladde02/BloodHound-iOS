//
//  ReportViewController.m
//  BloodHound
//
//  Created by William Grey on 6/5/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "ReportViewController.h"
#import "UIImageView+WebCache.h"

@interface ReportViewController ()

@end

NSInteger offset = 0;
NSInteger height  = 0;

@implementation ReportViewController

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
    
    TPKeyboardAvoidingScrollView* scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    //scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    //scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    //[self.view addSubview:scrollView];
    self.view = scrollView;
    
    
    
    
    checkImage = [UIImage imageNamed:@"check.png"];
    uncheckImage = [UIImage imageNamed:@"uncheck.png"];
    
    //custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"backButton.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    
    
    // Do any additional setup after loading the view.
    //self.imageBackground.set
    //UIImage *backgroundImage = [UIImage imageNamed:@"background2.png"];
    
    //UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    //backgroundImageView.image=backgroundImage;
    
   // [self.view insertSubview:backgroundImageView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //register Label
   /* CGRect firstHeader = CGRectMake(65,220,280,60);
    UILabel *firstHeaderLabel = [[UILabel alloc] initWithFrame:firstHeader];
    //registerLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *fTextOne = @"Send an alert for";
    [firstHeaderLabel setText: fTextOne];
    firstHeaderLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:30];
    firstHeaderLabel.textColor = [self colorWithHexString:@"ffffff"];
    [self.view addSubview:firstHeaderLabel];
    
    CGRect secondHeader = CGRectMake(90,262,280,60);
    UILabel *secondHeaderLabel = [[UILabel alloc] initWithFrame:secondHeader];
    //registerLabel.backgroundColor = [UIColor grayColor];  //debug point
    fTextOne = @"John Doe";
    [secondHeaderLabel setText: fTextOne];
    secondHeaderLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:50];
    secondHeaderLabel.textColor = [self colorWithHexString:@"ffffff"];
    [self.view addSubview:secondHeaderLabel]; */
    
    
    height = 0;
    
    checkFlags = [[NSMutableArray alloc] init];
    beaconIds = [[NSMutableArray alloc] init];
    
    [self selectLostObject];
    
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, (height+170));
    
    
    UIImageView *minButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320-602/2)/2,(height+80), 602/2, 159/2)];
    minButton.image  = [UIImage imageNamed:@"reportAlert.png"];
    [self.view addSubview:minButton];
    
    
    
    CGRect registerlabelFrame = CGRectMake(20,10,280,40);
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:registerlabelFrame];
    //registerLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *registerText = @"Who is missing?";
    [registerLabel setText: registerText];
    registerLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:30];
    registerLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:registerLabel];
    
    UITapGestureRecognizer *singleTapReport = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedReport)];
    singleTapReport.numberOfTapsRequired = 1;
    minButton.userInteractionEnabled = YES;
    [minButton addGestureRecognizer:singleTapReport];
    
    
    offset = 0;
}

-(void)tapDetectedReport{
    //show alert processing
    
    NSLog(@"single Tap on tap detected report button");
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:checkFlags forKeys:beaconIds];
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
    
    //if udpate is success, update local database
    NSUInteger count = 0;
    for (NSString *element in checkFlags) {
        [self updateLocalDatabase:[beaconIds objectAtIndex:count ] :element ];
        ++count;
    }
    
     [av dismissWithClickedButtonIndex:0 animated:NO];
    
}

-(void)updateReportingStatus :(NSString*) jsonString{
    
 
    //pass two array to post request, reporting flags and corresponding beacon Id
    NSString *post = [NSString stringWithFormat:@"jsonData=%@",jsonString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://smallemperor.com:8080/BloodHoundBackend/ReportPeople"]];
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
                                                             delegate:self
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

//UIAlertView Delegate only for success button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self back];
}


NSMutableArray *checkFlags;
NSMutableArray *beaconIds;
NSInteger counter = 0;

-(void) addRow:(NSString*) name : (NSString*) imgURL : (NSString*)beaconId :(NSString*)isReported
 {
    
    
    UIButton *checkImageView = [[UIButton alloc] initWithFrame:CGRectMake(  278, 75+offset, 40/2, 40/2)];
    checkImageView.tag = counter; //acts as index for NSMutableArray
    ++counter;
     
     BOOL flag = [isReported isEqualToString:@"false"]? NO:YES;
     
     UIImage *image = flag==NO?uncheckImage:checkImage;
     
    [checkImageView setImage:image forState:UIControlStateNormal];
    
    [checkImageView addTarget:self action:@selector(checkHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkImageView];
     
    NSNumber* checkFlag= [NSNumber numberWithBool:flag];
    [checkFlags addObject:checkFlag];
    [beaconIds addObject:beaconId];
    
    
    UIImageView *thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(  20, 60+offset, 50, 50)];
    
    //to get image from rackspace server
   // UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:MyURL]]];
    
    imgURL = [NSString stringWithFormat:@"%@%@",@"http://smallemperor.com:8080/images/",imgURL];
    
    NSLog(@"img url is ");
    NSLog(imgURL);
    
    [thumbnail setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"anonIcon50.png"]];
    
    [self.view addSubview:thumbnail];
    //thumbnail.backgroundColor = [self colorWithHexString:@"3fa69a"]; //testing point
    
     
    UILabel *viewCellLabel = [[UILabel alloc] initWithFrame: CGRectMake(80, 60+offset, 200, 50)];
    //viewCellLabel.backgroundColor = [self colorWithHexString:@"ffff00"];
    viewCellLabel.text = name;
     
     if(flag)  //if person is reported make text color RED
         viewCellLabel.textColor = [UIColor redColor];
     
    viewCellLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];

    [self.view addSubview:viewCellLabel];
    
    offset=offset+60;
    height=height+60;
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)updateLocalDatabase:(NSString*) beaconID :(NSNumber*) flagN{
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
    
     NSString *flagS = ([flagN boolValue]==YES)? @"true" : @"false";
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
    const char *sqlStatement = [[NSString stringWithFormat:@"UPDATE LOST SET REPORT = \"%@\" where BEACONID = \"%@\"",flagS,beaconID] UTF8String];
    
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


-(void) selectLostObject{
    sqlite3* d = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: @"lostDatabase.db"];
    
    if (sqlite3_open([path UTF8String], &d) != SQLITE_OK) {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(d);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(d));
        // Additional error handling, as appropriate...
    }
    
    sqlite3_stmt *sqlstmt;
    char *sql = "select * from LOST;";
    int ret;
    counter= 0;
    ret = sqlite3_prepare_v2(d, sql, -1, &sqlstmt, NULL);
    if (ret == SQLITE_OK) {
        NSLog(@"*** SQLITE_OK");
        while(SQLITE_ROW == sqlite3_step(sqlstmt)){
            //NSLog(@"%s",sqlite3_column_text(sqlstmt,0));
            
            const char *_beaconID = (char*)sqlite3_column_text(sqlstmt,0);
            NSString *beaconId;
            if(_beaconID){
                beaconId = _beaconID == NULL?@"Validation":[[NSString alloc] initWithUTF8String:_beaconID];
            }else
                beaconId = @"error";
            
            NSLog(beaconId);
            
            //NSLog(@"%s",sqlite3_column_text(sqlstmt,1));
             const char *_name = (char *)sqlite3_column_text(sqlstmt,1);
            NSString *name;
            if(_name){
                name = _name == NULL?@"Validation":[[NSString alloc] initWithUTF8String:_name];
            }else
                 name = @"Not a valid string";
            
            
            const char *_lname = (char *)sqlite3_column_text(sqlstmt,2);
            NSString *lname;
            
            if(_lname){
                lname = _lname == NULL?@"Validation":[[NSString alloc] initWithUTF8String:_lname];
            }else
                lname = @"Not a valid string";
            
            const char *_isReported = (char *)sqlite3_column_text(sqlstmt,16);
            NSString *isReported;
            if(_isReported){
                isReported = _isReported == NULL?@"false":[[NSString alloc] initWithUTF8String:_isReported];
            }else{
                isReported = @"Not a Valid string";
            }
            
            [self addRow:[NSString stringWithFormat:@"%@ %@", name, lname]:[NSString stringWithFormat:@"%@%@%@", @"image", beaconId,@".png"]:beaconId:isReported];
            
            NSLog(@"%s",sqlite3_column_text(sqlstmt,3));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,4));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,5));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,6));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,7));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,8));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,9));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,10));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,11));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,16));
        }
    }
    sqlite3_finalize(sqlstmt);
    sqlite3_close(d);  //close database
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
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


- (void) checkHandler: (id) sender{
    UIButton *buttonView = (UIButton*)sender;
    NSInteger index = buttonView.tag;
    NSString *beaconId = [beaconIds objectAtIndex:index];
    NSLog(@"Beacon Id is %@",beaconId);
    NSNumber *checkFlag = [checkFlags objectAtIndex:index];
    
    bool flag = ([checkFlag boolValue]==YES)? YES : NO;
    if(!flag){
        checkFlag = [NSNumber numberWithBool:YES];
        [checkFlags setObject:checkFlag atIndexedSubscript:index];
        [buttonView setImage:checkImage forState:UIControlStateNormal];
    }else{
        checkFlag= [NSNumber numberWithBool:NO];
        [checkFlags setObject:checkFlag atIndexedSubscript:index];
        [buttonView setImage:uncheckImage forState:UIControlStateNormal];
    }
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
