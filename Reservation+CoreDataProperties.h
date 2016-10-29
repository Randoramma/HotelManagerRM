//
//  Reservation+CoreDataProperties.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Reservation+CoreDataClass.h"
#import "Room+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN

@interface Reservation (CoreDataProperties)

+ (NSFetchRequest<Reservation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *cost;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, retain) Guest *guest;
@property (nullable, nonatomic, retain) Room *rooms;

@end

NS_ASSUME_NONNULL_END
