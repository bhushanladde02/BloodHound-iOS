//
//  AppDelegate.h
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import  <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>
#import "GlobalVars.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,FYXVisitDelegate,FYXServiceDelegate,NSURLConnectionDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) FYXVisitManager *visitManager;
@property (nonatomic) NSInteger count;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

NSMutableData *_responseData;
GlobalVars *globals;
NSMutableDictionary *alertDS;
NSDictionary *foundData;
NSMutableDictionary *foundResultsLocal;