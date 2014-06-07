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
    CGRect registerlabelFrame = CGRectMake(20,10,280,30);
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:registerlabelFrame];
    //registerLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *registerText = @"Register";
    [registerLabel setText: registerText];
    registerLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:30];
    registerLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:registerLabel];

    //register Desc
    CGRect registerDesclabelFrame = CGRectMake(20,40,280,30);
    UILabel *registerDescLabel = [[UILabel alloc] initWithFrame:registerDesclabelFrame];
    registerDescLabel.numberOfLines = 0;
    //[registerDescLabel sizeToFit];
    //registerDescLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *registerDescText = @"Provides info on what’s protected.";
    [registerDescLabel setText: registerDescText];
    registerDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    registerDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:registerDescLabel];

    //device Label
    CGRect deviceLabelFrame = CGRectMake(20,130,280,30);
    UILabel *deviceLabel = [[UILabel alloc] initWithFrame:deviceLabelFrame];
    //deviceLabel.backgroundColor = [UIColor greenColor];  //debug point
    deviceLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *deviceText = @"Bluetooth LE Device";
    [deviceLabel setText: deviceText];
    deviceLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:deviceLabel];
    
    //input device id
    CGRect deviceInputLabelFrame = CGRectMake(20,160,280,30);
    UITextField *deviceTextField = [[UITextField alloc] initWithFrame:deviceInputLabelFrame];
    deviceTextField.text = @"Device ID Number";
    deviceTextField.delegate = self;  //to clear the text
    deviceTextField.layer.borderWidth = 2;
    deviceTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    deviceTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:deviceTextField];
    
    //name Label
    CGRect namelabelFrame = CGRectMake(20,190,280,30);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:namelabelFrame];
    //nameLabel.backgroundColor = [UIColor greenColor];  //debug point
    nameLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *nameText = @"Name";
    [nameLabel setText: nameText];
    nameLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:nameLabel];
    
    //input first name
    CGRect fnameInputLabelFrame = CGRectMake(20,220,280,30);
    UITextField *textField = [[UITextField alloc] initWithFrame:fnameInputLabelFrame];
    textField.text = @"First Name";
    textField.delegate = self;  //to clear the text
    textField.layer.borderWidth = 2;
    textField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    textField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:textField];
    
    //input last name
    CGRect lnameInputLabelFrame = CGRectMake(20,250,280,30);
    UITextField *ltextField = [[UITextField alloc] initWithFrame:lnameInputLabelFrame];
    ltextField.text = @"Last Name";
    ltextField.delegate = self;  //to clear the text
    textField.layer.borderWidth = 2;
    textField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    ltextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:ltextField];
    
    //address label
    CGRect addresslabelFrame = CGRectMake(20,280,280,30);
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:addresslabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    addressLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *addressText = @"Address";
    [addressLabel setText: addressText];
    addressLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:addressLabel];
    
    //input street address
    CGRect streetAddressInputLabelFrame = CGRectMake(20,310,280,30);
    UITextView *streetAddressInputField = [[UITextView alloc] initWithFrame:streetAddressInputLabelFrame];
    streetAddressInputField.text = [NSString stringWithFormat:@"Street Address", (unichar)0x2028];
    streetAddressInputField.delegate = self; //to clear text
    streetAddressInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:streetAddressInputField];
    
    //input city
    CGRect cityInputLabelFrame = CGRectMake(20,340,280,30);
    UITextView *cityInputField = [[UITextView alloc] initWithFrame:cityInputLabelFrame];
    cityInputField.text = [NSString stringWithFormat:@"City", (unichar)0x2028];
    cityInputField.delegate = self; //to clear text
    cityInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:cityInputField];
    
    //State Drop Down Field
    
    //input zip code
    CGRect zipInputLabelFrame = CGRectMake(20,370,280,30);
    UITextView *zipInputField = [[UITextView alloc] initWithFrame:zipInputLabelFrame];
    zipInputField.text = [NSString stringWithFormat:@"Zip Code", (unichar)0x2028];
    zipInputField.delegate = self; //to clear text
    zipInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:zipInputField];
    
    //photo label
    CGRect photolabelFrame = CGRectMake(20,400,280,30);
    UILabel *photoLabel = [[UILabel alloc] initWithFrame:photolabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    photoLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *photoText = @"Photo";
    [photoLabel setText: photoText];
    photoLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:photoLabel];
    
    //select photo button
    UIImageView *uploadButton = [[UIImageView alloc] initWithFrame:CGRectMake(  21/3, 430, 301/2, 62/2)];
    uploadButton.image  = [UIImage imageNamed:@"selectPhoto.png"];
    [self.view addSubview:uploadButton];
    
    //camera button
    UIImageView *cameraButton = [[UIImageView alloc] initWithFrame:CGRectMake(  42/3+301/2, 430, 301/2, 62/2)];
    cameraButton.image  = [UIImage imageNamed:@"camera.png"];
    [self.view addSubview:cameraButton];
    
    //description label
    CGRect descriptionLabelFrame = CGRectMake(20,460,280,30);
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:descriptionLabelFrame];
    //fnameLabel.backgroundColor = [UIColor greenColor];  //debug point
    descriptionLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *descriptionText = @"Description";
    [descriptionLabel setText: descriptionText];
    descriptionLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:descriptionLabel];
    
    //input age
    CGRect ageInputLabelFrame = CGRectMake(20,490,280,30);
    UITextField *ageTextField = [[UITextField alloc] initWithFrame:ageInputLabelFrame];
    ageTextField.text = @"Age";
    ageTextField.delegate = self;  //to clear the text
    ageTextField.layer.borderWidth = 2;
    ageTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    ageTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:ageTextField];
    
    //input height
    CGRect heightInputLabelFrame = CGRectMake(20,520,280,30);
    UITextField *heightTextField = [[UITextField alloc] initWithFrame:heightInputLabelFrame];
    heightTextField.text = @"Height";
    heightTextField.delegate = self;  //to clear the text
    heightTextField.layer.borderWidth = 2;
    heightTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    heightTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:heightTextField];
    
    //input weight
    CGRect weightInputLabelFrame = CGRectMake(20,550,280,30);
    UITextField *weightTextField = [[UITextField alloc] initWithFrame:weightInputLabelFrame];
    weightTextField.text = @"Weight";
    weightTextField.delegate = self;  //to clear the text
    weightTextField.layer.borderWidth = 2;
    weightTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    weightTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:weightTextField];
    
    //input hair color
    CGRect hairInputLabelFrame = CGRectMake(20,580,280,30);
    UITextField *hairTextField = [[UITextField alloc] initWithFrame:hairInputLabelFrame];
    hairTextField.text = @"Hair Color";
    hairTextField.delegate = self;  //to clear the text
    hairTextField.layer.borderWidth = 2;
    hairTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    hairTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:hairTextField];
    
    //input eye color
    CGRect eyeInputLabelFrame = CGRectMake(20,610,280,30);
    UITextField *eyeTextField = [[UITextField alloc] initWithFrame:eyeInputLabelFrame];
    eyeTextField.text = @"Eye Color";
    eyeTextField.delegate = self;  //to clear the text
    eyeTextField.layer.borderWidth = 2;
    eyeTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    eyeTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:eyeTextField];
    
    //input distinguishing features
    CGRect featuresInputLabelFrame = CGRectMake(20,640,280,30);
    UITextField *featuresTextField = [[UITextField alloc] initWithFrame:featuresInputLabelFrame];
    featuresTextField.text = @"Distinguishing Features";
    featuresTextField.delegate = self;  //to clear the text
    featuresTextField.layer.borderWidth = 2;
    featuresTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    featuresTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:featuresTextField];
    
    //input special notes
    CGRect notesInputLabelFrame = CGRectMake(20,670,280,30);
    UITextField *notesTextField = [[UITextField alloc] initWithFrame:notesInputLabelFrame];
    notesTextField.text = @"Any specials notes including allergies, notable behavior, ect.";
    notesTextField.delegate = self;  //to clear the text
    notesTextField.layer.borderWidth = 2;
    notesTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    notesTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:notesTextField];
    
    //Call to Action label
    CGRect calllabelFrame = CGRectMake(20,700,280,30);
    UILabel *callLabel = [[UILabel alloc] initWithFrame:calllabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    callLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *callText = @"Call to Action";
    [callLabel setText: callText];
    callLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:callLabel];
    
    //input directions if found
    CGRect callInputLabelFrame = CGRectMake(20,730,280,30);
    UITextView *callInputField = [[UITextView alloc] initWithFrame:callInputLabelFrame];
    callInputField.text = @"What should a person do if they find your loved one?";
    callInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    callInputField.delegate = self; //to clear text
    [self.view addSubview:callInputField];
    
    CGRect permlabelFrame = CGRectMake(20,790,280,20);
    UILabel *permLabel = [[UILabel alloc] initWithFrame:permlabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    permLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *permText = @"Permissions";
    [permLabel setText: permText];
    permLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:permLabel];
    
    //permDesc Desc
    CGRect permDescDesclabelFrame = CGRectMake(20,810,280,60);
    UILabel *permDescDescLabel = [[UILabel alloc] initWithFrame:permDescDesclabelFrame];
    permDescDescLabel.numberOfLines = 0;
    //[permDescDescLabel sizeToFit];
    //permDescDescLabel.backgroundColor = [UIColor greenColor];  //debug point
    NSString *permDescDescText = @"Bloodhound requires push notifications and active bluetooth to function";
    [permDescDescLabel setText: permDescDescText];
    permDescDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    permDescDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:permDescDescLabel];
    
    
    checkButton = [[UIImageView alloc] initWithFrame:CGRectMake(  20, 870, 40/2, 40/2)];
    checkButton.image  = uncheckImage;
    [self.view addSubview:checkButton];
    
    
    
    
    CGRect acceptlabelFrame = CGRectMake(40,890,280,20);
    UILabel *acceptLabel = [[UILabel alloc] initWithFrame:acceptlabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    acceptLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *acceptText = @" Accept";
    [acceptLabel setText: acceptText];
    acceptLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:acceptLabel];
    
    
    UIImageView *submitButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320 - 602/2)/2, 910, 602/2, 159/2)];
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
    
    
    
    
    UITapGestureRecognizer *singleTapRegister = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerUser)];
    singleTapRegister.numberOfTapsRequired = 1;
    submitButton.userInteractionEnabled = YES;
    [submitButton addGestureRecognizer:singleTapRegister];
    
    
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
    [self animateTextField: textField up:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}


//clear default text before editing
- (void)textViewDidBeginEditing:(UITextField *)textView{
    NSLog(@"textViewDidBeginEditing");
    textView.text = @"";
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
    NSURL* requestURL = [NSURL URLWithString:@"http://smallemperor.com:8080/BloodHoundBackend/UploadServlet"];
    
    
    
    
    
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
    
    
    
    //send request
    NSURLResponse *response;
    NSError *err;
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
    NSString *content = [NSString stringWithUTF8String:[returnData bytes]];
    NSLog(@"responseData: %@", content);
    
    
    
    
    
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
