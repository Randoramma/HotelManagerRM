//
//  HotelService.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDPersistenceController.h"
#import "Reservation+CoreDataProperties.h"
@class Room;
@class Hotel;

@interface HotelService : NSObject
@property (strong) CDPersistenceController *myPersistenceController;
-(instancetype) init; 
-(NSArray *)fetchAllHotels;
-(NSArray *) fetchAllRoomsForHotel: (NSString *)theHotelName;
-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withGuest:(Guest *)guest;
-(NSFetchedResultsController *) fetchAvailableRoomsForFromDate:(NSDate *)fromDate
                                                        toDate:(NSDate *)toDate;
@end
