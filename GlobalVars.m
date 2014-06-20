//
//  GlobalVars.m
//  BloodHound
//
//  Created by William Grey on 6/16/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "GlobalVars.h"

@implementation GlobalVars

@synthesize notificationDS = _notificationDS;
+ (GlobalVars *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVars *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVars alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _notificationDS = [[NSMutableDictionary alloc] init];
    }
    return self;
}


@end
