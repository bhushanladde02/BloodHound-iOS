//
//  MainViewController.m
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "MainViewController.h"
#import "RegisterViewController.h"
#import "ActiveViewController.h"
#import "ReportViewController.h"
#import "FoundViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;

@end

@implementation MainViewController

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
    //self.imageBackground.set
    UIImage *backgroundImage = [UIImage imageNamed:@"background2.png"];
    
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
   // backgroundImage.image
    
    [self.view insertSubview:backgroundImageView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     * turn On Off following line
     */
    //[self.navigationController setNavigationBarHidden:YES];

    
    //NSInteger yPos = 2*self.view.window.frame.size.height/3;

    NSLog(@"Width of the screen is  %f",self.view.window.frame.size.width);
    
    NSInteger offset = (320- 583/2)/2;
    
    
     UIImageView *registerButton = [[UIImageView alloc] initWithFrame:CGRectMake(  offset, 265, 583/2, 159/2)];
    registerButton.image  = [UIImage imageNamed:@"register.png"];
    [self.view addSubview:registerButton];
    
    UIImageView *reportButton = [[UIImageView alloc] initWithFrame:CGRectMake(  offset , 355, 583/2, 159/2)];
    reportButton.image  = [UIImage imageNamed:@"report.png"];
    [self.view addSubview:reportButton];
    
    UIImageView *skipButton = [[UIImageView alloc] initWithFrame:CGRectMake(  offset , 445, 583/2, 159/2)];
    skipButton.image  = [UIImage imageNamed:@"activeSearch.png"];
    [self.view addSubview:skipButton];
    
    
    /*UIImageView *skipButton1 = [[UIImageView alloc] initWithFrame:CGRectMake(  offset , 480, 583/2, 159/2)];
    skipButton1.image  = [UIImage imageNamed:@"activeSearch.png"];
    [self.view addSubview:skipButton1];*/
    
    
    UITapGestureRecognizer *singleTapRegister = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedRegister)];
    singleTapRegister.numberOfTapsRequired = 1;
    registerButton.userInteractionEnabled = YES;
    [registerButton addGestureRecognizer:singleTapRegister];
    
    
    UITapGestureRecognizer *singleTapActive = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedActive)];
    singleTapActive.numberOfTapsRequired = 1;
    skipButton.userInteractionEnabled = YES;
    [skipButton addGestureRecognizer:singleTapActive];
    
    
    UITapGestureRecognizer *singleTapReport = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedReport)];
    singleTapReport.numberOfTapsRequired = 1;
    reportButton.userInteractionEnabled = YES;
    [reportButton addGestureRecognizer:singleTapReport];
    
    UITapGestureRecognizer *singleTapFound = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedFound)];
    singleTapFound.numberOfTapsRequired = 1;
  //  skipButton1.userInteractionEnabled = YES;
   // [skipButton1 addGestureRecognizer:singleTapFound];
    
    
    
/*    CGRect oldRect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(0, 200, oldRect.size.width, oldRect.size.height); */

    UIImage *headerImage = [UIImage imageNamed:@"navBar.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:headerImage forBarMetrics:UIBarMetricsDefault];
    
    NSLog(@"width of nav bar is  %f",
          self.navigationController.navigationBar.frame.size.width);
    
    NSLog(@"height of nav bar is  %f",
          self.navigationController.navigationBar.frame.size.height);
    
    
    
}


- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}




-(void)tapDetectedRegister{
    NSLog(@"single Tap on imageview register button");
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
    //[ registerViewController rel];
}

-(void)tapDetectedFound{
    NSLog(@"single Tap on imageview found button");
    FoundViewController *foundViewController = [[FoundViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:foundViewController animated:YES];
    //[ registerViewController rel];
}



-(void)tapDetectedActive{
    NSLog(@"single Tap on imageview active button");
    ActiveViewController *activeViewController = [[ActiveViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:activeViewController animated:YES];
}


-(void)tapDetectedReport{
    NSLog(@"single Tap on imageview report button");
    ReportViewController *activeViewController = [[ReportViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:activeViewController animated:YES];
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
