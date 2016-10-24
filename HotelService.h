//
//  HotelService.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reservation.h"
@class Room;
@class Hotel;

@interface HotelService : NSObject

-(NSArray *)fetchAllHotelswithMOC: (NSManagedObjectContext *)theContext;
-(NSArray *) fetchAllRoomsForHotel: (NSString *)theHotelName withMOC:(NSManagedObjectContext *)theContext;
-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withGuest:(Guest *)guest usingMOC:(NSManagedObjectContext*) theContext;
-(NSFetchedResultsController *) fetchAvailableRoomsForFromDate:(NSDate *)fromDate
                                                        toDate:(NSDate *)toDate
                                                   withContext: (NSManagedObjectContext *)theContext;
@end
