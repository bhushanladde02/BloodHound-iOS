//
//  AppDelegate.m
//  BloodHound
//
//  Created by William Grey on 6/2/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "AppDelegate.h"
#import "FoundViewController.h"


@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static sqlite3 *database = nil;
NSString *databasePath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];*/
    
    /*
     *  Need to Navigation Controller in AppDelegate
     */
  
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BloodHoundStoryBoard" bundle:nil];
    
    UINavigationController *myStoryBoardInitialViewController = [storyboard instantiateInitialViewController];

    _window.rootViewController = myStoryBoardInitialViewController;
    
    [self createDB];
    
    [FYX setAppId:@"a1b02ba0ceff8e732577743c829be1b589eb52741b0daa6492b35b24ccdd3377" appSecret:@"2a2b939eee6010f331cd09f3f97e36e949d68bca4fa38778bd5e554adc5fcd92" callbackUrl:@"comsmallemperor://authcode"];
    [FYX startService:self];
    self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    [self.visitManager start];
    
    
    //testing remove line
    //[self fetchDetails:@""];
    
    globals = [GlobalVars sharedInstance];
    
    
    return YES;
}

-(void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    
    //load your controller
    NSLog(@"Received local notification ");
    NSDictionary *map = notif.userInfo;
    //Just to switch screen to new development
    FoundViewController *foundViewController = [[FoundViewController alloc] init];
    globals.foundData = map;
    [(UINavigationController*)self.window.rootViewController pushViewController:foundViewController animated:nil];
    
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"lostDatabase.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS LOST (BEACONID TEXT PRIMARY KEY,FNAME TEXT,LNAME TEXT,IMGURL TEXT,STREET TEXT,CITY TEXT,STATE TEXT,ZIP TEXT,AGE TEXT,HEIGHT TEXT,WEIGHT TEXT,HCOLOR TEXT, ECOLOR TEXT, FEATURE TEXT,SPECIAL TEXT,ACTION TEXT,REPORT TEXT)";
            
            //report field for isReported corresponds to col7 on server
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table LOST");
            }else{
                isSuccess = YES;
                NSLog(@"Success creating table LOST");
            }
            
            sqlite3_close(database);
            return  isSuccess;
        }
        
        else
        {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (void) fetchDetails:(NSString*) beaconId{
    
    
    NSString *post = [NSString stringWithFormat:@"deviceID=\"%@\"",beaconId];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://smallemperor.com:8080/BloodHoundBackend/FindPeople"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse* response;
    NSError* error = nil;
    
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    NSString *content = [NSString stringWithUTF8String:[result bytes]];
    NSLog(@"responseData: %@", content);
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:result options:0 error:&localError];
    
    if (localError != nil) {
      //  *error = localError;
      //  return nil;
    }
    
    
    globals.foundData = parsedObject;
    
    
}


- (void)didArrive:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter is sighted for the first time
    NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
    
}
- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
    NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
     NSLog(@"I received a identifier!!! %@", visit.transmitter.identifier);
    
    
    
    NSString *beaconId = visit.transmitter.identifier;

    
    
    NSLog(@"Gimbal Beacon Value!!! %@", visit.transmitter.ownerId);
    if([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        NSLog(@"Application status is in background %@",visit.transmitter.battery);
        
        foundData = globals.foundData;
        alertDS = globals.notificationDS;
        
        
        
        if([alertDS objectForKey:beaconId]){
            //forget it  -alert is already there
            //object is already set
            return;
        }else{
                [self fetchDetails:beaconId];
                alertDS = globals.notificationDS;
                foundData = globals.foundData; //get updated ds
            }
        
            //check if device is reported
            NSString *isReported = [foundData objectForKey:@"col7"];
            isReported  = isReported!=nil?isReported:@"false";
            
            if([isReported isEqualToString:@"false"]){
                return; // forget it -- this will fetch every time because we are not setting alertDS
            }//else go ahead
            
            [alertDS setObject:@"On" forKey:beaconId]; //alert is On for same ID
        
        
        NSString *firstname = [foundData objectForKey:@"firstname"];
        NSString *lastname = [foundData objectForKey:@"lastname"];
        NSString *callToAction = [foundData objectForKey:@"col6"];
        NSString *specialNotes = [foundData objectForKey:@"col5"];
        NSString *features =[foundData objectForKey:@"col3"];
        //NSString *uniqueID = [foundData objectForKey:@"col8"];
        
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            if (localNotif) {
                localNotif.alertBody = [NSString stringWithFormat:@"%@ %@-%@,%@,%@",firstname,lastname,callToAction,specialNotes,features];
                localNotif.alertAction = NSLocalizedString(@"Read Message", nil);
                NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:foundData, beaconId, nil];
                localNotif.userInfo = userDict;
                localNotif.soundName = @"alarmsound.caf";
               [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
               [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            }
    }
}


/*//update database
-(void) refreshData{
    
    for (NSString *key in [globals.foundResults allKeys]) {
        [self fetchDetails:key];
        if(globals.foundData!=nil)
            [foundResultsLocal setObject:globals.foundData forKey:beaconId];
    }

}*/


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    NSUInteger orientations = UIInterfaceOrientationMaskAllButUpsideDown;
    
    if(self.window.rootViewController){
        UIViewController *presentedViewController = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
        orientations = [presentedViewController supportedInterfaceOrientations];
    }
    
    return orientations;
}



- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

- (void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    NSLog(@"FYX Service Successfully Started");
}
- (void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    NSLog(@"%@", error);
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"Application enters foreground - handle push notification click ");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BloodHound" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BloodHound.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
      NSLog(@"Received data:%@",data);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}



@end
