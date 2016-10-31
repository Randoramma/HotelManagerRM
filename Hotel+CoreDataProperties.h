//
//  Hotel+CoreDataProperties.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Hotel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Hotel (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *imageName;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *rating;
@property (nullable, nonatomic, retain) NSSet<Room *> *rooms;

@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(Room *)value;
- (void)removeRoomsObject:(Room *)value;
- (void)addRooms:(NSSet<Room *> *)values;
- (void)removeRooms:(NSSet<Room *> *)values;

@end

NS_ASSUME_NONNULL_END
