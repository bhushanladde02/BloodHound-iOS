//
//  RegisterViewController.h
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUITextField.h"
#import <sqlite3.h>
#import "UIPlaceHolderTextView.h"

@interface RegisterViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLConnectionDelegate>
@end

UIImage *chosenImage;
UIImageView *checkButton;
UIImage *checkImage;
UIImage *uncheckImage;


NSMutableData *_responseData;
UIImageView *newImageView;
NSURL *imgURL;  //image url in media

UIPlaceHolderTextView *featuresTextField,*notesTextField,*callInputField;
UIImageView *thumbField;

SUITextField *deviceTextField, *textField, *ltextField,*ageTextField,*heightTextField,*weightTextField,*hairTextField,*eyeTextField,*streetAddressInputField,*cityInputField,*stateInputField,*zipInputField;

//(BEACONID ,FNAME ,LNAME ,IMGURL ,STREET ,CITY ,STATE ,ZIP ,AGE ,HEIGHT ,WEIGHT ,HCOLOR , ECOLOR , FEATURE ,SPECIAL ,ACTION )
NSString *beaconID, *fname, *lname, *imgurl, *street, *city,*state, *zip, *age, *height, *weight, *weight, *hcolor, *ecolor, *feature, *special, *action;