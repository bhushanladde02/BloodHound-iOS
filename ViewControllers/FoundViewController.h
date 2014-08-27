//
//  FoundViewController.h
//  BloodHound
//
//  Created by William Grey on 6/9/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface FoundViewController : UIViewController<UIAlertViewDelegate>
//-(void) setMap:(NSDictionary*)map;
@property (nonatomic, retain) NSDictionary *dataMap;
@end

NSString *beaconId;
//NSDictionary *map;