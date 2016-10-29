//
//  Reservation+CoreDataClass.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
