//
//  Guest+CoreDataProperties.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Guest+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Guest (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSNumber *memberNumber;
@property (nullable, nonatomic, retain) NSSet<Reservation *> *reservations;

@end

@interface Guest (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet<Reservation *> *)values;
- (void)removeReservations:(NSSet<Reservation *> *)values;

@end

NS_ASSUME_NONNULL_END
