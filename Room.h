//
//  Room.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/6/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) NSSet *reservation;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationObject:(Reservation *)value;
- (void)removeReservationObject:(Reservation *)value;
- (void)addReservation:(NSSet *)values;
- (void)removeReservation:(NSSet *)values;

@end
