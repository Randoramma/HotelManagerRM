//
//  Room+CoreDataClass.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Room : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Room+CoreDataProperties.h"
