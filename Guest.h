//
//  Guest.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/6/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reservation;

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * persons;
@property (nonatomic, retain) NSNumber * room;
@property (nonatomic, retain) NSSet *reservations;
@end

@interface Guest (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
