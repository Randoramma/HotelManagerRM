//
//  Room+CoreDataProperties.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Room+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Room (CoreDataProperties)

+ (NSFetchRequest<Room *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *beds;
@property (nullable, nonatomic, copy) NSNumber *number;
@property (nullable, nonatomic, copy) NSDecimalNumber *rate;
@property (nullable, nonatomic, copy) NSNumber *rating;
@property (nullable, nonatomic, retain) Hotel *hotel;
@property (nullable, nonatomic, retain) NSSet<Reservation *> *reservation;

@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationObject:(Reservation *)value;
- (void)removeReservationObject:(Reservation *)value;
- (void)addReservation:(NSSet<Reservation *> *)values;
- (void)removeReservation:(NSSet<Reservation *> *)values;

@end

NS_ASSUME_NONNULL_END
