//
//  CDPersistenceController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 10/21/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "CDPersistenceController.h"
#import "JSONParser.h"
#import "Room+CoreDataProperties.h"
#import "Guest+CoreDataProperties.h"
#import "Reservation+CoreDataProperties.h"
#include "Constants.h"


typedef NS_ENUM(NSUInteger, CDPError) {
  CDPErrorModelURLNotCreated,
  CDPErrorManagedObjectModelNotCreated,
  CDPErrorPersistentStoreCoordinatorNotCreated
};


@interface CDPersistenceController ()
@property (strong, readwrite) NSManagedObjectContext * theMainMOC;
@property (strong) NSManagedObjectContext * saveToPSCContext;
@property (strong, nonatomic) NSString *modelName;

@end


@implementation CDPersistenceController


/**
 Initialization of the Core Data Stack.
 @param The name of the model the stack is working with.
 
 @return CDPersistenceController
 */
- (instancetype)initWithCompletion:(CDPersistenceControllerCallbackBlock)returnBlock
{
    
  if (!(self = [super init])) return nil;
  self = [super init];
  
  [self initializeCoreDataWithCompletion:^(BOOL succeeded, NSError *error) {
      if (succeeded) {
          returnBlock(YES, nil);
      } else {
          returnBlock(NO, error); 
      }
          
}];
  
  return self;
}

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    return self = [super init];;
}

-(void) seedWithJSONWithCompletion: (void (^) (void))completionHandler {
  
  NSFetchRequest *jsonDataFetch = [[NSFetchRequest alloc] initWithEntityName:HOTEL_ENTITY];
  __block NSError *jsonDataFetchError;
  NSManagedObjectContext *theWriteContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [theWriteContext setParentContext:_theMainMOC];
  [theWriteContext performBlockAndWait:^{
    NSInteger theResult = [theWriteContext countForFetchRequest:jsonDataFetch error:&jsonDataFetchError];
    NSLog(@" %ld", (long)theResult);
    if (theResult == 0) {
      [JSONParser hotelsFromJSONData: (theWriteContext)];
      completionHandler();
    }
  }];
}

/**
 Method allowing the controller to add a room object into the entity "Reservation" thus changing a Room's status to "Boooked"
 
 @param room      The Room object.
 @param startDate The Start Date.  Format =
 @param endDate   The End Date. Format =
 @param guest     The Guest Entity associated.
 
 
 @return The Reservation Object.
 */
-(void) bookReservationForRoom:(Room *)theRoom
                     startDate:(NSDate *)theStartDate
                       endDate:(NSDate *)theEndDate
            withGuestFirstName:(NSString *)theFirstName
              andGuestLastName:(NSString *)theLastName
                andReturnBlock: (CDPersistenceControllerCallbackBlock)returnblock {
  
//  NSManagedObjectContext *theWriteContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//  [theWriteContext setParentContext:_theMainMOC];
//  
 // NSError *saveError;
  
  [_theMainMOC performBlock:^{
    NSError *fetchError = nil;
    Room *reservedRoom = [_theMainMOC existingObjectWithID:theRoom.objectID error: &fetchError];
    Guest * guest = [[Guest alloc] initWithEntity:[NSEntityDescription entityForName:GUEST_ENTITY inManagedObjectContext:_theMainMOC] insertIntoManagedObjectContext:_theMainMOC];
    guest.firstName = theFirstName;
    guest.lastName = theLastName;
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:CURRENT_MEMBER_COUNT] == 0) {
      NSNumber *theGuestsID = [[NSNumber alloc] initWithInt:01];
      [[NSUserDefaults standardUserDefaults] setObject:theGuestsID forKey:CURRENT_MEMBER_COUNT];
      [[NSUserDefaults standardUserDefaults] synchronize];
      guest.memberNumber = theGuestsID;
    } else {
      // increment the CURRENT_MEMBER_COUNT and apply that number to the guest id.
      NSNumber *theCurrentMemberCount = [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_MEMBER_COUNT];
      guest.memberNumber = [NSNumber numberWithInt:[theCurrentMemberCount intValue] + 1];
      [[NSUserDefaults standardUserDefaults] setObject:guest.memberNumber forKey:CURRENT_MEMBER_COUNT];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
//
    
    NSLog(@"The Hotel is %@", theRoom.hotel);
    
    Reservation *reservation = [[Reservation alloc] initWithEntity:[NSEntityDescription entityForName:RESERVATION_ENTITY inManagedObjectContext:_theMainMOC] insertIntoManagedObjectContext:_theMainMOC];
    
    reservation.startDate = theStartDate;
    reservation.endDate = theEndDate;
    reservation.cost = [[NSDecimalNumber alloc] initWithString:@"2.0"];
    reservation.guest = guest;
    reservation.rooms = theRoom;
    
    guest.reservations = [[NSSet alloc] initWithObjects:reservation, nil];

//    if (![_theMainMOC save:&saveError]) {
//      NSLog(@"Unable to save added item: %@", [saveError localizedDescription]);
//      dispatch_async(dispatch_get_main_queue(), ^{
//              returnblock(NO, saveError);
//      });
//
//    } else {
      [self saveDataWithReturnBlock:^(BOOL succeeded, NSError *saveError) {
        if (succeeded) {
          dispatch_async(dispatch_get_main_queue(), ^{
              returnblock(YES, nil);
          });
        } else {
          dispatch_async(dispatch_get_main_queue(), ^{
            returnblock(NO, saveError);
          });
        }
      }];
//    }
  }];
}

/**
 Initialize the core data stack.  If it already exists return the main MOC.  theMainMOC is the point of contact for the rest of the app and will be interacted with via the main thread.  It (theMainMOC) has a private context which will be the only source of interaction with the PSC to prevent race conditions and concurrency violations.
 */
-(void) initializeCoreDataWithCompletion: (CDPersistenceControllerCallbackBlock)returnblock {
  
  if ([self theMainMOC]) return;
  
  NSURL *theModelURL = [[NSBundle mainBundle] URLForResource:URL_PATH_FOR_MOMD withExtension:@"momd"];
  
  // sanity check on the model URL
  if (!theModelURL) {
    NSError *customError = [self createErrorWithCode:CDPErrorModelURLNotCreated
                                                desc:NSLocalizedString(@"The Model URL could not be found during setup.", nil)
                                          suggestion:NSLocalizedString(@"Do you want to try setting up the stack again?", nil)
                                             options:@[@"Try Again", @"Cancel"]];
    
    returnblock(NO, customError);
    
    return;
  }
  
  NSManagedObjectModel *theMomster = [[NSManagedObjectModel alloc]initWithContentsOfURL:theModelURL];
  // sanity check on the momster
  if (!theMomster) {
    NSError *customError = [self createErrorWithCode:CDPErrorManagedObjectModelNotCreated
                                                desc:NSLocalizedString(@"The Managed Object Model could not be found during setup.", nil)
                                          suggestion:NSLocalizedString(@"Do you want to try setting up the stack again?", nil)
                                             options:@[@"Try Again", @"Cancel"]];
    returnblock(NO, customError);
    return;
  }
  
  // initialize the PSC.
  NSPersistentStoreCoordinator *theCoordinator = [[NSPersistentStoreCoordinator alloc]
                                                  initWithManagedObjectModel:theMomster];
  
  
  // Sanity check on the existence of the PSC
  if (!theCoordinator) {
    NSError *customError = [self createErrorWithCode:CDPErrorModelURLNotCreated
                                                desc:NSLocalizedString(@"The Persistent Store Coordinator could not be found during setup.", nil)
                                          suggestion:NSLocalizedString(@"Do you want to try setting up the stack again?", nil)
                                             options:@[@"Try Again", @"Cancel"]];
    returnblock(NO, customError);
    return;
  }
  
  [self setTheMainMOC:[[NSManagedObjectContext alloc]
                       initWithConcurrencyType:NSMainQueueConcurrencyType]];
  
  [self setSaveToPSCContext:[[NSManagedObjectContext alloc]
                             initWithConcurrencyType:NSPrivateQueueConcurrencyType]];
  
  [[self saveToPSCContext] setPersistentStoreCoordinator:theCoordinator];
  [[self theMainMOC] setParentContext:[self saveToPSCContext]];
  
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    
    NSArray *theDirectoryArray = [[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory
                                                                        inDomains:NSUserDomainMask];
    NSURL *theStoreURL = [theDirectoryArray lastObject];
    NSError *theError = nil;
    
    // setup the file manager and retrieve the directory for the database within documents..
    NSFileManager *theFileManager = [NSFileManager defaultManager];
    if (![theFileManager createDirectoryAtURL:theStoreURL
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&theError]) {
      NSError *theCustomError = nil;
      
      if (theError) {
        theCustomError = [NSError errorWithDomain:kCDDataBaseManagerErrorDomain
                                             code:theError.code
                                         userInfo:theError.userInfo];
      }
      
      dispatch_async(dispatch_get_main_queue(), ^{
        returnblock(NO, theCustomError);
      });
    }
    
    // setup the url for the store and the options for accessing the DB..
    theStoreURL = [theStoreURL URLByAppendingPathComponent:URL_PATH_FOR_SQLITE_DB];
    NSMutableDictionary *theOptions = [NSMutableDictionary dictionary];
    theOptions[NSMigratePersistentStoresAutomaticallyOption] = @YES;
    theOptions[NSInferMappingModelAutomaticallyOption] = @YES;
    theOptions[NSSQLitePragmasOption] = @{ @"journal_mode": @"DELETE" };
    
    NSPersistentStore *thePersistentStore = [theCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                         configuration:nil
                                                                                   URL:theStoreURL
                                                                               options:theOptions
                                                                                 error:&theError];
    if (!thePersistentStore) {
      NSError *customError = nil;
      
      if (theError) {
        customError = [NSError errorWithDomain:kCDDataBaseManagerErrorDomain
                                          code:theError.code
                                      userInfo:theError.userInfo];
      }
      
      dispatch_async(dispatch_get_main_queue(), ^{
        returnblock(NO, customError);
      });
    } else {
      [self seedWithJSONWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
          returnblock(YES, nil);
        });
      }];
    }
  });
}


/**
 The method providing function to save data to the PSC.  Checks for changes in either the main MOC or the save MOC and will push changes from the main MOC to the save MOC if changed.  If save MOC has changes will write to the PSC on its own queue.
 
 @param returnBlock was save successful?
 */
- (void)saveDataWithReturnBlock:(CDPersistenceControllerCallbackBlock)returnBlock
{
  if (![NSThread isMainThread]) { //Always start from the main thread
    dispatch_sync(dispatch_get_main_queue(), ^{
      [self saveDataWithReturnBlock:returnBlock];
    });
    return;
  }
  
  //Don't work if you don't need to (you can talk to these without performBlock)
  if (![[self theMainMOC] hasChanges] && ![[self saveToPSCContext] hasChanges]) {
    if (returnBlock) returnBlock(YES, nil);
    return;
  }
  
  if ([[self theMainMOC] hasChanges]) {
    NSError *theMainThreadSaveError = nil;
    if (![[self theMainMOC] save:&theMainThreadSaveError]) {
      if (returnBlock) returnBlock (NO, theMainThreadSaveError);
      return; //fail early and often
    }
  }
  
  [[self saveToPSCContext] performBlock:^{ //private context must be on its on queue
    NSError *theSaveError = nil;
    if (![[self saveToPSCContext] save:&theSaveError]) {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (returnBlock) returnBlock(NO, theSaveError);
      });
      return;
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (returnBlock) returnBlock(YES, nil);
      });
    }
  }];
}


/**
 Custom error handling method.
 
 @param code        The code for the error.
 @param description A brief description of the error.
 @param suggestion  Allows the user to have some recourse for the error. Possible solutions.
 @param options     The options provided to the user.
 
 @return The Custom error.
 */
- (NSError *)createErrorWithCode:(NSUInteger)code desc:(NSString *)description suggestion:(NSString *)suggestion options:(NSArray *)options
{
  NSParameterAssert(description);
  NSParameterAssert(suggestion);
  NSParameterAssert(options);
  
  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : description,
                              NSLocalizedRecoverySuggestionErrorKey : suggestion,
                              NSLocalizedRecoveryOptionsErrorKey : options };
  
  NSError *error = [NSError errorWithDomain:kCDDataBaseManagerErrorDomain code:code userInfo:userInfo];
  
  return error;
}



@end
