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
    
    offset = 0;
}


NSMutableArray *checkFlags;
NSMutableArray *beaconIds;
NSInteger counter = 0;

-(void) addRow:(NSString*) name : (NSString*) imgURL : (NSString*)beaconId
{
    
    
    UIButton *checkImageView = [[UIButton alloc] initWithFrame:CGRectMake(  278, 75+offset, 40/2, 40/2)];
    checkImageView.tag = counter; //acts as index for NSMutableArray
    ++counter;
    
    [checkImageView setImage:uncheckImage forState:UIControlStateNormal];
    
    [checkImageView addTarget:self action:@selector(checkHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkImageView];
    
    NSNumber* checkFlag= [NSNumber numberWithBool:NO];
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
    viewCellLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];

    [self.view addSubview:viewCellLabel];
    
    offset=offset+60;
    height=height+60;
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
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
            
            
            [self addRow:[NSString stringWithFormat:@"%@ %@", name, lname]:[NSString stringWithFormat:@"%@%@%@", @"image", beaconId,@".png"]:beaconId];
            
            NSLog(@"%s",sqlite3_column_text(sqlstmt,3));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,4));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,5));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,6));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,7));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,8));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,9));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,10));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,11));
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
