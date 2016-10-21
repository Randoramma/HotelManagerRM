//
//  CDPersistenceController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/21/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^InitCallbackBlock)(void);
@interface CDPersistenceController : NSObject

/**
 Main MOC only source that interacts with the PSC.
 */
@property (strong, readonly) NSManagedObjectContext *theMainMOC;

/**
 Nitification to the AppDelegate that the Persistence layer is ready.

 @param callback Callback state of Persistence Manager.

 @return self;
 */
-(id) initWithCallback: (InitCallbackBlock)callback;


/**
 Method to save context to PSC.  
 */
-(void) save;

@end
