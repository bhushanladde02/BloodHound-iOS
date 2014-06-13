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
    
    //Should get data from server
    
    AGMedallionView *medallionView = [[AGMedallionView alloc] init];
    medallionView.image = [UIImage imageNamed:@"anonIcon100.png"];
    [self.view addSubview:medallionView];
    
    
    // [self.view insertSubview:backgroundImageView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
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
