//
//  HotelService.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "HotelService.h"
#import "Hotel.h"
#import "Guest.h"
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"

@interface HotelService()
@end

@implementation HotelService
// instantiate a new CoreStack (type NSObject) if none exist.
-(instancetype)initCoreDataStack:(CoreDataStack *)coreDataStack {
  self = [super init];
  
  if (self) {
    self.coreDataStack = coreDataStack;
  }
  return self;
} // initCoreDataStack

-(NSArray *)fetchAllHotels {

  NSFetchRequest *hotelListFetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
  
  NSArray *hotelList = [self.coreDataStack.managedObjectContext executeFetchRequest:hotelListFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@", fetchError.localizedDescription);
    return nil;
  }
  return hotelList;
} // fetchAllHotels

-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withGuest:(Guest *)guest {
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.rooms = room;
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  reservation.guest = guest;
  
  NSError *saveError;
  
  [self.coreDataStack.managedObjectContext save:&saveError];
  
  if (saveError) {
    NSLog(@"%@", saveError); 
    return nil;
  }
  
  return reservation;
} // bookReservationForRoom

-(NSArray *)fetchAvailableRoomsForFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  //Make the fetch (request "Reservation" and predicate with variables).
  NSFetchRequest *theRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", toDate, fromDate];
  
  theRequest.predicate = thePredicate;
  NSError *theFetchError;
  NSArray *fetchResults = [self.coreDataStack.managedObjectContext executeFetchRequest:theRequest error:&theFetchError];
  
  // add any rooms with reservations to the badRooms array.
  NSMutableArray *bookedRooms = [[NSMutableArray alloc] init];
  for(Reservation *reservation in fetchResults) {
    [bookedRooms addObject:reservation.rooms];
  }
  
  // make a second fetch for rooms not in the above array.
  NSFetchRequest *finalRoomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *roomPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", bookedRooms];
  finalRoomRequest.predicate = roomPredicate;
  
  // list the array of rooms.
  NSError *theFetchRoomError;
  NSArray *fetchRoomResults = [self.coreDataStack.managedObjectContext executeFetchRequest:finalRoomRequest error:&theFetchRoomError];
  
  if (theFetchRoomError) {
    return nil;
  }
  return fetchRoomResults;

} // fetchAvailableRoomsForFromDate


- (void)saveContext {
  [self.coreDataStack saveContext];
} // saveContext

@end
