//
//  CDPersistenceController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/21/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Room+CoreDataProperties.h"

typedef void (^CDPersistenceControllerCallbackBlock)(BOOL succeeded, NSError *error);
@interface CDPersistenceController : NSObject

/**
 Main MOC only source that interacts with the PSC and the main app client.
 */
@property (strong, readonly) NSManagedObjectContext *theMainMOC;
- (instancetype)initWithCompletion:(CDPersistenceControllerCallbackBlock)returnBlock;
- (void) initializeCoreDataWithCompletion: (CDPersistenceControllerCallbackBlock)returnblock;
- (void) saveDataWithReturnBlock:(CDPersistenceControllerCallbackBlock)returnBlock;
- (void) bookReservationForRoom:(NSManagedObjectID *)theRoomID
                     startDate:(NSDate *)theStartDate
                       endDate:(NSDate *)theEndDate
            withGuestFirstName:(NSString *)theFirstName
              andGuestLastName:(NSString *)theLastName
                andReturnBlock: (CDPersistenceControllerCallbackBlock)returnblock;
-(void) removeReservationWithStartDate: (NSDate *)startDate endDate: (NSDate *)endDate andRoom:(NSManagedObjectID *)room;
@end
