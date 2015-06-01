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
@class CoreDataStack;

@interface HotelService : NSObject
@property (strong,nonatomic) CoreDataStack *coreDataStack;

-(instancetype) initCoreDataStack: (CoreDataStack *)coreDataStack;

-(void) saveContext;

-(NSArray*) fetchAllHotels;

-(NSArray *) fetchAllRoomsForHotel: (NSString *)theHotelName;

-(NSFetchedResultsController *)fetchAvailableRoomsForFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withGuest:(Guest*)guest;
@end
