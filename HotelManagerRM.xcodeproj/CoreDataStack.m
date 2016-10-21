//
//  CoreDataStack.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "CoreDataStack.h"
#import "JSONParser.h"
#import "Constants.h"



//used exclisively for testing
@interface CoreDataStack()
// reserved for testing.
@property (nonatomic) BOOL isForTesting;

@end

@implementation CoreDataStack

@synthesize managedObjectContext = managedObjectContext;
@synthesize managedObjectModel = managedObjectModel;
@synthesize persistentStoreCoordinator = persistentStoreCoordinator;


- (instancetype)initForTesting {
  self = [super init];
  if (self) {
    self.isForTesting = true;
  }
  return self;
} // initForTesting
#pragma mark - Core Data stack

-(instancetype)init {
  self = [super init];
  
  
  
  
  
  
  return self;
}


/**
 Method applies json file data to populate MOC if no data exists currently.
 */
-(void) seedWithJSON {
  
  NSFetchRequest *jsonDataFetch = [[NSFetchRequest alloc] initWithEntityName:HOTEL_ENTITY];
  NSError *jsonDataFetchError;
  
  NSInteger theResult = [managedObjectContext countForFetchRequest:jsonDataFetch error:&jsonDataFetchError];
  NSLog(@" %ld", (long)theResult);
  if (theResult == 0) {
    [JSONParser hotelsFromJSONData: (managedObjectContext)];
    
  } 
}

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "com.RandyMcLain.HotelManagerRM" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


/**
 Method returns MOM for the app.

 @return the MOM.
 */
- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (managedObjectModel != nil) {
    return managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:URL_PATH_FOR_MOMD withExtension:@"momd"];
  managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return managedObjectModel;
}


/**
 Returns the PSC for the app.

 @return the PSC.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
  if (persistentStoreCoordinator != nil) {
    return persistentStoreCoordinator;
  }
  
  // Create the coordinator and store
  
  persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:URL_PATH_FOR_SQLITE_DB];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  NSString *storeType;
  // to protect memory during testing.  
  if (_isForTesting) {
    storeType = NSInMemoryStoreType;
  } else {
    storeType = NSSQLiteStoreType;
  }
  
  if (![persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];

    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return persistentStoreCoordinator;
}


/**
 Returns the Main MOC for the app.

 @return the Main MOC.
 */
- (NSManagedObjectContext *)managedObjectContext {
  // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
  if (managedObjectContext != nil) {
    return managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  // main MOC for the project.
  managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  [managedObjectContext setPersistentStoreCoordinator:coordinator];
  return managedObjectContext;
}

#pragma mark - Core Data Saving support


/**
 Method checks for a valid MOC and if changes have been made.  Then saves the MOC to the PSC.  
 */
- (void)saveContext {
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {

      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

@end
