//
//  HotelService.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "Constants.h"
#import "HotelService.h"
#import "Hotel.h"
#import "Guest.h"
#import "Reservation.h"
#import "Room.h"

@interface HotelService()
@end

@implementation HotelService

/**
 Method retrieving all hotel objects from persistent store.

 @param theContext = the NSManagedContext instance.
 @return NSArray with all hotel objects.
 */
-(NSArray *)fetchAllHotelswithMOC: (NSManagedObjectContext *)theContext {

  NSFetchRequest *hotelListFetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
  
  NSArray *hotelList = [theContext executeFetchRequest:hotelListFetch
                                                 error:&fetchError];
  if (fetchError) {
    NSLog(@"%@", fetchError.localizedDescription);
    return nil;
  }
  return hotelList;
} // fetchAllHotels


/**
 Method returning all rooms for a particular hotel entity.

 @param theHotelName The name of the hotel entity.
 @param theContext = the NSManagedContext instance.

 @return NSArray of all the Room objects for the hotel.
 */
-(NSArray *) fetchAllRoomsForHotel: (NSString *)theHotelName withMOC:(NSManagedObjectContext *)theContext {
  NSFetchRequest *roomFetchList = [NSFetchRequest fetchRequestWithEntityName:ROOM_ENTITY];
  /* Keep in mind, that the predicate is being called on the 'Room' entity and its relationships.  So we must 
   predicate on teh format of the room and thus hotel.name is lowercase as it is stated in the room relationship."
   */
  NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"hotel.name == %@", theHotelName];
  roomFetchList.predicate = thePredicate;
  NSError  *theError;
  NSArray *theRoomList = [theContext executeFetchRequest:roomFetchList
                                                   error:&theError];
  
  if (theError) {
    NSLog(@"%@",theError.localizedDescription);
    return nil;
  } else {
    return theRoomList;
  }
}


/**
 Method allowing the controller to add a room object into the entity "Reservation" thus changing a Room's status to "Boooked"

 @param room      The Room object.
 @param startDate The Start Date.  Format =
 @param endDate   The End Date. Format =
 @param guest     The Guest Entity associated.
 @param theContext = the NSManagedContext instance.

 @return The Reservation Object.
 */
-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withGuest:(Guest *)guest usingMOC:(NSManagedObjectContext*) theContext{
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:RESERVATION_ENTITY
                                                           inManagedObjectContext:theContext];
  reservation.rooms = room;
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  reservation.guest = guest;
  
  NSError *saveError;
  
  [theContext save:&saveError];
  
  if (saveError) {
    NSLog(@"%@", saveError); 
    return nil;
  }
  
  return reservation;
} // bookReservationForRoom


/**
 Method returning the NSFRC efficently alowing the fetched data for the available rooms within a hotel to be inserted into the TVC.

 @param fromDate Start date for the timerange. (predicate)
 @param toDate   End date for the timerange. (predicate)

 @return NSFetchedResultsController: the available rooms between the dates.
 */
-(NSFetchedResultsController *) fetchAvailableRoomsForFromDate:(NSDate *)fromDate
                                                        toDate:(NSDate *)toDate
                                                   withContext: (NSManagedObjectContext *)theContext {
  // delete previous cache
  [NSFetchedResultsController deleteCacheWithName:@"AvailableRoomCache"];
  
  
  //Make the fetch (request "Reservation" and predicate with variables).
  NSFetchRequest *theRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", toDate, fromDate];
  theRequest.predicate = thePredicate;
  NSError *theFetchError;
  NSArray *fetchResults = [theContext executeFetchRequest:theRequest error:&theFetchError];
  
  // add any rooms with reservations to the badRooms array.
  NSMutableArray *bookedRooms = [[NSMutableArray alloc] init];
  for(Reservation *reservation in fetchResults) {
    [bookedRooms addObject:reservation.rooms];
  }
  
  // make a second fetch for rooms not in the above array.
  NSFetchRequest *finalRoomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *roomPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", bookedRooms];
  NSSortDescriptor *theHotelName = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:true];
  NSSortDescriptor *theRoomOrder = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:true];
  finalRoomRequest.sortDescriptors = @[theHotelName, theRoomOrder];
  finalRoomRequest.predicate = roomPredicate;
  
  NSFetchedResultsController *fetchResultsController = [[NSFetchedResultsController alloc]
                                                        initWithFetchRequest:finalRoomRequest
                                                        managedObjectContext:theContext
                                                          sectionNameKeyPath:@"hotel.name"
                                                                   cacheName:@"AvailableRoomCache"];
  return fetchResultsController;

} // fetchAvailableRoomsForFromDate

@end
