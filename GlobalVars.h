//
//  GlobalVars.h
//  BloodHound
//
//  Created by William Grey on 6/16/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVars : NSObject
{
    NSMutableDictionary *_notificationDS; //make sure if alert is not clicked by user, give only one alert
}

+ (GlobalVars *)sharedInstance;

@property(strong, nonatomic, readwrite) NSMutableDictionary *notificationDS;

@end