//
//  ReportViewController.m
//  BloodHound
//
//  Created by William Grey on 6/5/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

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
    UIImage *backgroundImage = [UIImage imageNamed:@"background2.png"];
    
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    
    [self.view insertSubview:backgroundImageView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //register Label
    CGRect firstHeader = CGRectMake(65,220,280,60);
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
    [self.view addSubview:secondHeaderLabel];
    
    
    
    UIImageView *minButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320-602/2)/2, 400, 602/2, 159/2)];
    minButton.image  = [UIImage imageNamed:@"reportAlert.png"];
    [self.view addSubview:minButton];
    
    
    
    [self selectLostObject];
    
    
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
        if(SQLITE_ROW == sqlite3_step(sqlstmt)){
            NSLog(@"%s",sqlite3_column_text(sqlstmt,0));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,1));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,2));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,3));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,4));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,5));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,6));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,7));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,8));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,9));
            NSLog(@"%s",sqlite3_column_text(sqlstmt,10));q
            NSLog(@"%s",sqlite3_column_text(sqlstmt,11));
        }
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
