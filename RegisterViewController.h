//
//  RegisterViewController.h
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLConnectionDelegate>
@end

UIImage *chosenImage;
UIImageView *checkButton;
UIImage *checkImage;
UIImage *uncheckImage;


NSMutableData *_responseData;
UIImageView *newImageView;
NSURL *imgURL;  //image url in media

