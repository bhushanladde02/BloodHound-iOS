//
//  RegisterViewController.h
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUITextField.h"

@interface RegisterViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLConnectionDelegate>
@end

UIImage *chosenImage;
UIImageView *checkButton;
UIImage *checkImage;
UIImage *uncheckImage;


NSMutableData *_responseData;
UIImageView *newImageView;
NSURL *imgURL;  //image url in media

UITextView *streetAddressInputField,*cityInputField,*stateInputField,*zipInputField,*callInputField;


SUITextField *deviceTextField, *textField, *ltextField, *thumbField,*ageTextField,*heightTextField,*weightTextField,*hairTextField,*eyeTextField,*featuresTextField,*notesTextField;

//(BEACONID ,FNAME ,LNAME ,IMGURL ,STREET ,CITY ,STATE ,ZIP ,AGE ,HEIGHT ,WEIGHT ,HCOLOR , ECOLOR , FEATURE ,SPECIAL ,ACTION )
NSString *beaconID, *fname, *lname, *imgurl, *street, *city, *zip, *age, *height, *weight, *weight, *hcolor, *ecolor, *feature, *special, *action;