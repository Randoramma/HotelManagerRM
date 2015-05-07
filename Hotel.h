//
//  Hotel.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/6/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Hotel : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, retain) NSSet *rooms;
@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(NSManagedObject *)value;
- (void)removeRoomsObject:(NSManagedObject *)value;
- (void)addRooms:(NSSet *)values;
- (void)removeRooms:(NSSet *)values;

@end
