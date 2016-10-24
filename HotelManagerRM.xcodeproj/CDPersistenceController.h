//
//  CDPersistenceController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/21/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^CDPersistenceControllerCallbackBlock)(BOOL suceeded, NSError *error);
@interface CDPersistenceController : NSObject

/**
 Main MOC only source that interacts with the PSC.
 */
@property (strong, readonly) NSManagedObjectContext *theMainMOC;


- (instancetype)initWithModelName:(NSString *)modelName;
- (void) initializeCoreDataWithCompletion: (CDPersistenceControllerCallbackBlock)returnblock;
- (void)saveDataWithReturnBlock:(CDPersistenceControllerCallbackBlock)returnBlock;

@end
