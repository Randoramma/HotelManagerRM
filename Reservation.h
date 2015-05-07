//
//  Reservation.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/6/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * room;
@property (nonatomic, retain) NSSet *guest;
@property (nonatomic, retain) NSManagedObject *rooms;
@end

@interface Reservation (CoreDataGeneratedAccessors)

- (void)addGuestObject:(NSManagedObject *)value;
- (void)removeGuestObject:(NSManagedObject *)value;
- (void)addGuest:(NSSet *)values;
- (void)removeGuest:(NSSet *)values;

@end
