//
//  CDPersistenceController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 10/21/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "CDPersistenceController.h"
#include "Constants.h"

@interface CDPersistenceController ()
@property (strong, readwrite) NSManagedObjectContext * theMainMOC;
@property (strong) NSManagedObjectContext * privateContext;
@property (copy) InitCallbackBlock initCallback;

-(void)initializeCoreData;

@end


@implementation CDPersistenceController


/**
 Initialization of the Core Data Stack.
 
 @param callback <#callback description#>
 
 @return CDPersistenceController
 */
-(id) initWithCallback:(InitCallbackBlock)callback;  {
  if (!(self = [super init])) return nil;
  
  [self setInitCallback: callback];
  [self initializeCoreData];
  
  return self;
}


/**
 Initialize the core data stack.  If it already exists return the main MOC.  theMainMOC is the point of contact for the rest of the app and will be interacted with via the main thread.  It (theMainMOC) has a private context which will be the only source of interaction with the PSC to prevent race conditions and concurrency violations.   
 */
-(void) initializeCoreData {
  
  if ([self theMainMOC]) return;
  
  NSURL *theModelURL = [[NSBundle mainBundle] URLForResource:URL_PATH_FOR_MOMD withExtension:@"momd"];
  NSManagedObjectModel *theMomster = [[NSManagedObjectModel alloc]initWithContentsOfURL:theModelURL];
  NSAssert(theMomster, @"%@:%@ No Model to generate a store from", [self class], NSStringFromSelector(_cmd));
  
  // initialize the PSC.
  NSPersistentStoreCoordinator *theCoordinator = [[NSPersistentStoreCoordinator alloc]
                                                  initWithManagedObjectModel:theMomster];
  NSAssert(theCoordinator, @"Failed to Initialize Coordinator");
  
  [self setTheMainMOC:[[NSManagedObjectContext alloc]
                       initWithConcurrencyType:NSMainQueueConcurrencyType]];
  
  [self setPrivateContext:[[NSManagedObjectContext alloc]
                           initWithConcurrencyType:NSPrivateQueueConcurrencyType]];
  
  [[self privateContext] setPersistentStoreCoordinator:theCoordinator];
  [[self theMainMOC] setParentContext:[self privateContext]];
  
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    NSPersistentStoreCoordinator *thePSC = [[self privateContext] persistentStoreCoordinator];
    NSMutableDictionary *theOptions = [NSMutableDictionary dictionary];
    theOptions[NSMigratePersistentStoresAutomaticallyOption] = @YES;
    theOptions[NSInferMappingModelAutomaticallyOption] = @YES;
    theOptions[NSSQLitePragmasOption] = @{ @"journal_mode": @"DELETE" };
    
    NSFileManager *theFileManager = [NSFileManager defaultManager];
    NSURL *theDocumentsURL = [[theFileManager URLsForDirectory:NSDocumentDirectory
                                                     inDomains:NSUserDomainMask] lastObject];
    
    NSURL *theStoreURL = [theDocumentsURL URLByAppendingPathComponent:URL_PATH_FOR_SQLITE_DB];
    NSError *theError = nil;
    NSAssert([thePSC addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:theStoreURL
                                        options:theOptions
                                          error:&theError], @"Error initializing PSC: %@\n%@", [theError localizedDescription], [theError userInfo]);
    if (![self initCallback]) return;
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      [self initCallback]();
    });
  });
}



/**
 Save to the main Context on a perform block and wait which will then push to the private context.  Save the private on an asynch thread.
 */
-(void) save; {
  if (![[self privateContext] hasChanges] && ![[self theMainMOC] hasChanges]) return;
  
  [[self theMainMOC] performBlockAndWait:^{
    NSError *theError = nil;
    
    NSAssert([[self theMainMOC] save:&theError], @"Failed to save main context: %@\n%@", [theError localizedDescription], [theError userInfo]);
    
    [[self privateContext] performBlock:^{
      NSError *privateError = nil;
      NSAssert([[self privateContext] save:&privateError], @"Error saving private context: %@\n%@", [privateError localizedDescription], [privateError userInfo]);
    }];
  }];
}


@end
