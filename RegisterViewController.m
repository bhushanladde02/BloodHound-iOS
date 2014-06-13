//
//  RegisterViewController.m
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "RegisterViewController.h"
#import "AnimatedGif.h"
#import "UIImageView+AnimatedGif.h"
#import <QuartzCore/QuartzCore.h>
#import "TPKeyboardAvoidingScrollView.h"

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
    
    
    TPKeyboardAvoidingScrollView* scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.scrollEnabled = YES;
   //scrollView.pagingEnabled = YES;
   scrollView.showsVerticalScrollIndicator = YES;
   scrollView.showsHorizontalScrollIndicator = YES;
   scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.7);
   //[self.view addSubview:scrollView];
   self.view = scrollView;
    

    self.view.backgroundColor = [UIColor whiteColor];

    
    //custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"backButton.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
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
    CGRect registerlabelFrame = CGRectMake(20,10,280,40);
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:registerlabelFrame];
    //registerLabel.backgroundColor = [UIColor grayColor];  //debug point
    NSString *registerText = @"Register";
    [registerLabel setText: registerText];
    registerLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:30];
    registerLabel.textColor = [self colorWithHexString:@"3fa69a"];
    [self.view addSubview:registerLabel];

    //register Desc
    CGRect registerDesclabelFrame = CGRectMake(20,50,280,20);
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
    CGRect deviceLabelFrame = CGRectMake(20,80,280,30);
    UILabel *deviceLabel = [[UILabel alloc] initWithFrame:deviceLabelFrame];
    //deviceLabel.backgroundColor = [UIColor greenColor];  //debug point
    deviceLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *deviceText = @"Bluetooth LE Device";
    [deviceLabel setText: deviceText];
    deviceLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:deviceLabel];
    
    //input id number
    CGRect deviceInputLabelFrame = CGRectMake(20,110,280,30);
    deviceTextField = [[SUITextField alloc] initWithFrame:deviceInputLabelFrame];
    deviceTextField.placeholder = @"ID Number";
    deviceTextField.layer.borderWidth = 1;
    deviceTextField.tag = 2;
    deviceTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    deviceTextField.layer.cornerRadius = 3;
    deviceTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    deviceTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:deviceTextField];
    
    //name Label
    CGRect namelabelFrame = CGRectMake(20,150,130,30);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:namelabelFrame];
    //nameLabel.backgroundColor = [UIColor greenColor];  //debug point
    nameLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *nameText = @"Name";
    [nameLabel setText: nameText];
    nameLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:nameLabel];
    
    //input first name
    CGRect fnameInputLabelFrame = CGRectMake(20,180,165,30);
    textField = [[SUITextField alloc] initWithFrame:fnameInputLabelFrame];
    textField.placeholder = @"First Name";
    textField.tag = 4;
    textField.tintColor = [self colorWithHexString:@"3fa69a"];
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 3;
    textField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    textField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:textField];
    
    //input last name
    CGRect lnameInputLabelFrame = CGRectMake(20,215,165,30);
    ltextField = [[SUITextField alloc] initWithFrame:lnameInputLabelFrame];
    ltextField.placeholder = @"Last Name";
    ltextField.tag = 6;
    ltextField.tintColor = [self colorWithHexString:@"3fa69a"];
    ltextField.layer.borderWidth = 1;
    ltextField.layer.cornerRadius = 3;
    ltextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    ltextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:ltextField];
    
    //photo thumbnail
    //placeholder
    CGRect thumbInputLabelFrame = CGRectMake(200,160,100,100);
    thumbField = [[SUITextField alloc] initWithFrame:thumbInputLabelFrame];
    thumbField.placeholder = @"Photo Thumbnail";
    thumbField.backgroundColor = [UIColor grayColor];
    thumbField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    thumbField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:thumbField];
    
    //photo label
    CGRect photolabelFrame = CGRectMake(20,255,130,30);
    UILabel *photoLabel = [[UILabel alloc] initWithFrame:photolabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    photoLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *photoText = @"Photo";
    [photoLabel setText: photoText];
    photoLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:photoLabel];
    
    //select photo button
    UIImageView *uploadButton = [[UIImageView alloc] initWithFrame:CGRectMake(  12, 285, 301/2, 62/2)];
    uploadButton.image  = [UIImage imageNamed:@"selectPhoto.png"];
    [self.view addSubview:uploadButton];
    
    //camera button
    UIImageView *cameraButton = [[UIImageView alloc] initWithFrame:CGRectMake(  157, 285, 301/2, 62/2)];
    cameraButton.image  = [UIImage imageNamed:@"camera.png"];
    [self.view addSubview:cameraButton];
    
    //address label
    CGRect addresslabelFrame = CGRectMake(20,321,280,30);
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:addresslabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    addressLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *addressText = @"Address";
    [addressLabel setText: addressText];
    addressLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:addressLabel];
    
    //input street address
    CGRect streetAddressInputLabelFrame = CGRectMake(20,351,280,30);
    streetAddressInputField = [[SUITextField alloc] initWithFrame:streetAddressInputLabelFrame];
    streetAddressInputField.placeholder = @"Street Address";
    streetAddressInputField.tag = 4;
    streetAddressInputField.tintColor = [self colorWithHexString:@"3fa69a"];
    streetAddressInputField.layer.borderWidth = 1;
    streetAddressInputField.layer.cornerRadius = 3;
    streetAddressInputField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    streetAddressInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:streetAddressInputField];
    
    //input city
    CGRect cityInputLabelFrame = CGRectMake(20,386,140,30);
    cityInputField = [[SUITextField alloc] initWithFrame:cityInputLabelFrame];
    cityInputField.placeholder = @"City";
    cityInputField.layer.borderWidth = 1;
    cityInputField.tag = 10;
    cityInputField.tintColor = [self colorWithHexString:@"3fa69a"];
    cityInputField.layer.cornerRadius = 3;
    cityInputField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    cityInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:cityInputField];
    
    //placeholder
    //needs drop down menu
    //input state
    CGRect stateInputLabelFrame = CGRectMake(170,386,40,30);
    stateInputField = [[SUITextField alloc] initWithFrame:stateInputLabelFrame];
    stateInputField.placeholder = @"AZ";
    stateInputField.layer.borderWidth = 1;
    stateInputField.tag= 12;
    stateInputField.tintColor = [self colorWithHexString:@"3fa69a"];
    stateInputField.layer.cornerRadius = 3;
    stateInputField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    stateInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:stateInputField];
    
    //input zip code
    CGRect zipInputLabelFrame = CGRectMake(220,386,80,30);
    zipInputField = [[SUITextField alloc] initWithFrame:zipInputLabelFrame];
    zipInputField.placeholder = @"Zip Code";
    zipInputField.layer.borderWidth = 1;
    zipInputField.tag = 14;
    zipInputField.tintColor = [self colorWithHexString:@"3fa69a"];
    zipInputField.layer.cornerRadius = 3;
    zipInputField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    zipInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:zipInputField];
    
    //description label
    CGRect descriptionLabelFrame = CGRectMake(20,426,280,30);
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:descriptionLabelFrame];
    //fnameLabel.backgroundColor = [UIColor greenColor];  //debug point
    descriptionLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *descriptionText = @"Description";
    [descriptionLabel setText: descriptionText];
    descriptionLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:descriptionLabel];
    
    //input age
    CGRect ageInputLabelFrame = CGRectMake(20,456,80,30);
    ageTextField = [[SUITextField alloc] initWithFrame:ageInputLabelFrame];
    ageTextField.placeholder = @"Age";
    ageTextField.tag = 16;
    ageTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    ageTextField.layer.borderWidth = 1;
    ageTextField.layer.cornerRadius = 3;
    ageTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    ageTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:ageTextField];
    
    //input height
    CGRect heightInputLabelFrame = CGRectMake(110,456,90,30);
    heightTextField = [[SUITextField alloc] initWithFrame:heightInputLabelFrame];
    heightTextField.placeholder = @"Height";
    heightTextField.layer.borderWidth = 1;
    heightTextField.tag = 18;
    heightTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    heightTextField.layer.cornerRadius = 3;
    heightTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    heightTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:heightTextField];
    
    //input weight
    CGRect weightInputLabelFrame = CGRectMake(210,456,90,30);
    weightTextField = [[SUITextField alloc] initWithFrame:weightInputLabelFrame];
    weightTextField.placeholder = @"Weight";
    weightTextField.layer.borderWidth = 1;
    weightTextField.layer.cornerRadius = 3;
    weightTextField.tag = 20;
    weightTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    weightTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    weightTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:weightTextField];
    
    //input hair color
    CGRect hairInputLabelFrame = CGRectMake(20,491,135,30);
    hairTextField = [[SUITextField alloc] initWithFrame:hairInputLabelFrame];
    hairTextField.placeholder = @"Hair Color";
    hairTextField.layer.borderWidth = 1;
    hairTextField.layer.cornerRadius = 3;
    hairTextField.tag = 22;
    hairTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    hairTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    hairTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:hairTextField];
    
    //input eye color
    CGRect eyeInputLabelFrame = CGRectMake(165,491,135,30);
    eyeTextField = [[SUITextField alloc] initWithFrame:eyeInputLabelFrame];
    eyeTextField.placeholder = @"Eye Color";
    eyeTextField.layer.borderWidth = 1;
    eyeTextField.layer.cornerRadius = 3;
    eyeTextField.tag = 24;
    eyeTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    eyeTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    eyeTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:eyeTextField];
    
    //input distinguishing features
    CGRect featuresInputLabelFrame = CGRectMake(20,526,280,60);
    featuresTextField = [[SUITextField alloc] initWithFrame:featuresInputLabelFrame];
    featuresTextField.placeholder = @"Distinguishing Features";
    featuresTextField.layer.borderWidth = 1;
    featuresTextField.layer.cornerRadius = 3;
    featuresTextField.tag = 26;
    featuresTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    featuresTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    featuresTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:featuresTextField];
    
    //input special notes
    CGRect notesInputLabelFrame = CGRectMake(20, 591, 280, 60);
    notesTextField = [[SUITextField alloc] initWithFrame:notesInputLabelFrame];
    notesTextField.placeholder = @"Any special notes...";
    notesTextField.layer.borderWidth = 1;
    notesTextField.layer.cornerRadius = 3;
    notesTextField.tag = 28;
    notesTextField.tintColor = [self colorWithHexString:@"3fa69a"];
    notesTextField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor];
    notesTextField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    [self.view addSubview:notesTextField];
    
    
    //Call to Action label
    CGRect calllabelFrame = CGRectMake(20,661,280,30);
    UILabel *callLabel = [[UILabel alloc] initWithFrame:calllabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    callLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *callText = @"Call to Action";
    [callLabel setText: callText];
    callLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:callLabel];
    
    //input directions if found
    CGRect callInputLabelFrame = CGRectMake(20,691,280,60);
    callInputField = [[SUITextField alloc] initWithFrame:callInputLabelFrame];
    callInputField.placeholder = @"What should a person do if they find your loved one?";
    callInputField.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    callInputField.layer.borderWidth = 1;
    callInputField.layer.cornerRadius = 3;
    callInputField.tag = 30;
    callInputField.tintColor = [self colorWithHexString:@"3fa69a"];
    callInputField.layer.borderColor = [[self colorWithHexString:@"3fa69a"] CGColor ];
    [self.view addSubview:callInputField];
    
    CGRect permlabelFrame = CGRectMake(20,761,280,20);
    UILabel *permLabel = [[UILabel alloc] initWithFrame:permlabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    permLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *permText = @"Permissions";
    [permLabel setText: permText];
    permLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:permLabel];
    
    //permDesc Desc
    CGRect permDescDesclabelFrame = CGRectMake(20,781,280,45);
    UILabel *permDescDescLabel = [[UILabel alloc] initWithFrame:permDescDesclabelFrame];
    permDescDescLabel.numberOfLines = 0;
    //[permDescDescLabel sizeToFit];
    //permDescDescLabel.backgroundColor = [UIColor greenColor];  //debug point
    NSString *permDescDescText = @"Bloodhound requires push notifications and active bluetooth to function.";
    [permDescDescLabel setText: permDescDescText];
    permDescDescLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:16];
    permDescDescLabel.textColor = [self colorWithHexString:@"242424"];
    [self.view addSubview:permDescDescLabel];
    
    
    checkButton = [[UIImageView alloc] initWithFrame:CGRectMake(  20, 836, 40/2, 40/2)];
    checkButton.image  = uncheckImage;
    [self.view addSubview:checkButton];
    
    
    CGRect acceptlabelFrame = CGRectMake(40,836,260,20);
    UILabel *acceptLabel = [[UILabel alloc] initWithFrame:acceptlabelFrame];
    //nameLabel.backgroundColor = [UIColor grayColor];  //debug point
    acceptLabel.textColor = [self colorWithHexString:@"3fa69a"];
    NSString *acceptText = @" Accept";
    [acceptLabel setText: acceptText];
    acceptLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:18];
    [self.view addSubview:acceptLabel];
    
    
    UIImageView *submitButton = [[UIImageView alloc] initWithFrame:CGRectMake(  (320 - 602/2)/2, 875, 602/2, 159/2)];
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

/*
//clear default text before editing
- (void)textFieldDidBeginEditing:(SUITextField *)textField{
    
    
    NSLog(@"textFieldDidBeginEditing");
    
    //allow clearing text first time when user enters info
    if(textField.tag % 2 == 0 ){
        textField.text = @"";
    //    [self animateTextField: textField up:YES];
        textField.tag = textField.tag + 1;
    }
    
    //make text color little lighter - currently making red
    textField.textColor = [self colorWithHexString:@"00ff00"];
}

- (void)textFieldDidEndEditing:(SUITextField *)textField
{
   // [self animateTextField: textField up: NO];
    //make text color little lighter - currently making red
    textField.textColor = [self colorWithHexString:@"ff0000"];
}
*/


//clear default text before editing
- (void)textViewDidBeginEditing:(SUITextField *)textView{
    NSLog(@"textViewDidBeginEditing");
    //this clear text before editing
    textView.text = @"";
    //make text color little lighter
    textView.textColor = [self colorWithHexString:@"ff0000"];
    
}


-(BOOL) validateInput{
    //validate input
    return FALSE;
}


-(void) insertLostLocal{
    
    beaconID = deviceTextField.text;
    fname = textField.text;
    lname = ltextField.text;
    age = ageTextField.text;
    height= heightTextField.text;
    weight = weightTextField.text;
    hcolor = hairTextField.text;
    ecolor = eyeTextField.text;
    feature = featuresTextField.text;
    street = streetAddressInputField.text;
    zip = zipInputField.text;
    special= notesTextField.text;
    action = callInputField.text;
    
  
    //(BEACONID ,FNAME ,LNAME ,IMGURL ,STREET ,CITY ,STATE ,ZIP ,AGE ,HEIGHT ,WEIGHT ,HCOLOR , ECOLOR , FEATURE ,SPECIAL ,ACTION )
    NSString *insertLostSQL = [NSString stringWithFormat:@"INSERT INTO LOST (BEACONID ,FNAME ,LNAME ,IMGURL ,STREET ,CITY ,STATE ,ZIP ,AGE ,HEIGHT ,WEIGHT ,HCOLOR , ECOLOR , FEATURE ,SPECIAL ,ACTION ) VALUES (\"%@\",\"%@\" ,\"%@\",\"%@\",\"%@\" ,\"%@\",\"%@\",\"%@\" ,\"%@\",\"%@\",\"%@\" ,\"%@\",\"%@\",\"%@\" ,\"%@\",\"%@\")", beaconID, fname, lname,imgURL,street,city,state,zip,age,height,weight,hcolor,ecolor,feature,special,action];
    
    char *errMsg;
    const char *insert_stmt;
    
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
    
    
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
                insert_stmt = [insertLostSQL UTF8String];
            if (sqlite3_exec(database, insert_stmt, NULL, NULL, &errMsg) == SQLITE_OK) {
                //close the database
                NSLog(@"insert into lost table");
            }
            else
            {
                NSLog(@"failed insertation %s", errMsg);
            }

      }
   sqlite3_close(database); //close the database
}


//sends http request
-(void) registerUser{
    
    
    //insert to local database
    [self insertLostLocal];
    
    
    
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
    
    NSString *imageNameURL = [NSString stringWithFormat:@"image%@.png", beaconID];
    
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant, imageNameURL] dataUsingEncoding:NSUTF8StringEncoding]];
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
    
    
    /*NSData * animationData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ajax-loader-bar.gif" ofType:nil]];
    AnimatedGif * animation = [AnimatedGif getAnimationForGifWithData:animationData];
    newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220, 19)];
    
   // newImageView setani
    [newImageView setAnimatedGif:animation startImmediately:YES];*/
   // [self.view addSubview:newImageView];
    
    //[self.view setUserInteractionEnabled:NO];
    
    //self.view.backgroundColor =  [self colorWithHexString:@"cccccc"];
   
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    av = [[UIAlertView alloc] initWithTitle:@"Processing..." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    //pv = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    //pv.progress = 5.0;
    
    [av addSubview:newImageView];
    [av show];
}

//lock bc rotation
- (BOOL)shouldAutorotate
{
    return NO;
}

//remove keyboard when tapped on screen
/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}*/


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    //imgURL
    imgURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    //display image on UI
    //self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //set thumbnail
    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(170,150,130,130)];
    picture.image  = chosenImage;
    [self.view addSubview:picture];

    
    
    
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


#pragma mark NSURLConnection Delegate Methods

UIAlertView *av;


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    NSLog(@"Received data:%@",data);
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now

    [av dismissWithClickedButtonIndex:0 animated:NO];
    
        self.view.backgroundColor =  [self colorWithHexString:@"ffffff"];
        NSString *content = [NSString stringWithUTF8String:[_responseData bytes]];
        NSLog(@"responseData: %@", content);
        [newImageView removeFromSuperview];
    
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:@"Registration Successful"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
    
                                                otherButtonTitles: nil];
    
    [myAlertView show];
    

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    
    [av dismissWithClickedButtonIndex:0 animated:NO];
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:@"Registration Failed, Please try later"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
    
    
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
