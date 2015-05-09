//
//  HotelService.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reservation.h"
#import "Room.h"

@class CoreDataStack;

@interface HotelService : NSObject

-(instancetype) initCoreDataStack: (CoreDataStack *)coreDataStack;

-(void) saveContext;

-(NSArray*) fetchAllHotels;

-(NSArray *)fetchAvailableRoomsForFromDate:(NSDate*)fromDate toDate:(NSDate *)toDate;

-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end
