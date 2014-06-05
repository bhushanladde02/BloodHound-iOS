//
//  RegisterViewController.m
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "RegisterViewController.h"

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
    
    checkImage = [UIImage imageNamed:@"check.png"];
    uncheckImage = [UIImage imageNamed:@"uncheck.png"];
    
    //warn user of no camera
    /*
      if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
     
     UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Device has no camera"
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles: nil];
     
     [myAlertView show];
     
     }
     */
    
    
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
    textField.delegate = self;  //to clear the text
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
    addressInputField.delegate = self; //to clear text
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
    callInputField.delegate = self; //to clear text
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
    
    
    checkButton = [[UIImageView alloc] initWithFrame:CGRectMake(  20, 511, 40/2, 40/2)];
    checkButton.image  = uncheckImage;
    [self.view addSubview:checkButton];
    
    
    
    
    CGRect acceptlabelFrame = CGRectMake(40,511,280,20);
    UILabel *acceptLabel = [[UILabel alloc] initWithFrame:acceptlabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    acceptLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *acceptText = @" Accept";
    [acceptLabel setText: acceptText];
    acceptLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:acceptLabel];
    
    
    UIImageView *submitButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320 - 602/2)/2, 531 + 3, 602/2, 159/2)];
    submitButton.image  = [UIImage imageNamed:@"submit.png"];
    [self.view addSubview:submitButton];

    
    //Connect Buttons to Gallery and Take Photo
    
    UITapGestureRecognizer *singleTapUpload = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto)];
    singleTapUpload.numberOfTapsRequired = 1;
    uploadButton.userInteractionEnabled = YES;
    [uploadButton addGestureRecognizer:singleTapUpload];
    
    
    UITapGestureRecognizer *singleTapTakePhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePhoto)];
    singleTapTakePhoto.numberOfTapsRequired = 1;
    cameraButton.userInteractionEnabled = YES;
    [cameraButton addGestureRecognizer:singleTapTakePhoto];
    
    
    
    UITapGestureRecognizer *singleTapCheck = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkHandler)];
    singleTapCheck.numberOfTapsRequired = 1;
    checkButton.userInteractionEnabled = YES;
    [checkButton addGestureRecognizer:singleTapCheck];
    
}

bool *isChecked = false;

- (void) checkHandler{
    if(!isChecked){
        isChecked = true;
        checkButton.image =checkImage;
    }else{
        isChecked= false;
        checkButton.image =uncheckImage;
    }
}


- (void)takePhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

//clear default text before editing
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    textField.text = @"";
}

//clear default text before editing
- (void)textViewDidBeginEditing:(UITextField *)textView{
    NSLog(@"textViewDidBeginEditing");
    textView.text = @"";
}




//sends http request
-(void) registerUser{
    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:@"en" forKey:@"lan"];
    //[_params setObject:[NSString stringWithFormat:@"%d", userId] forKey:[NSString stringWithString:@"userId"]];
    //[_params setObject:[NSString stringWithFormat:@"%@",title] forKey:@"title"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant  = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"file";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString:@""];
    
    
    
    
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
}

//remove keyboard when tapped on screen
/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}*/


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    //display image on UI
    //self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
