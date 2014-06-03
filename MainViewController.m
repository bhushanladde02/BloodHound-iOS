//
//  MainViewController.m
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "MainViewController.h"
#import "RegisterViewController.h"

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
    UIImage *backgroundImage = [UIImage imageNamed:@"Background1.png"];
    
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
   // backgroundImage.image
    
    [self.view insertSubview:backgroundImageView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     * turn On Off following line
     */
    [self.navigationController setNavigationBarHidden:YES];

    
    NSInteger yPos = 2*self.view.window.frame.size.height/3;

    NSLog(@"Width of the screen is  %f",self.view.window.frame.size.width);
    
    NSInteger offset = (320- 583/2)/2;
    
    
     UIImageView *registerButton = [[UIImageView alloc] initWithFrame:CGRectMake(  offset, 220, 583/2, 159/2)];
    registerButton.image  = [UIImage imageNamed:@"register.png"];
    [self.view addSubview:registerButton];
    
    UIImageView *reportButton = [[UIImageView alloc] initWithFrame:CGRectMake(  offset , 300, 583/2, 159/2)];
    reportButton.image  = [UIImage imageNamed:@"report.png"];
    [self.view addSubview:reportButton];
    
    UIImageView *skipButton = [[UIImageView alloc] initWithFrame:CGRectMake(  offset , 380, 583/2, 159/2)];
    skipButton.image  = [UIImage imageNamed:@"activeSearch.png"];
    [self.view addSubview:skipButton];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    registerButton.userInteractionEnabled = YES;
    [registerButton addGestureRecognizer:singleTap];
    
    
}


-(void)tapDetected{
    NSLog(@"single Tap on imageview register button");
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
    //[ registerViewController rel];
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
