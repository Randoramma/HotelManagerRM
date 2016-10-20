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
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"

@interface HotelService()
@end

@implementation HotelService
// instantiate a new CoreStack (type NSObject) if none exist.

/**
 Init for the HotelService object.  This class handles all requests from the app that would need to retrieve or manipulate information from persistent store.

 @param coreDataStack the Core Data Stack associated with the service.

 @return The object providing persistence function to the controller.
 */
-(instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
  self = [super init];
  
  if (self) {
    self.coreDataStack = coreDataStack;
  }
  return self;
} // initCoreDataStack

/**
 Method retrieving all hotel objects from persistent store.

 @return NSArray with all hotel objects.
 */
-(NSArray *)fetchAllHotels {

  NSFetchRequest *hotelListFetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
  
  NSArray *hotelList = [self.coreDataStack.managedObjectContext executeFetchRequest:hotelListFetch
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

 @return NSArray of all the Room objects for the hotel.
 */
-(NSArray *) fetchAllRoomsForHotel: (NSString *)theHotelName {
  NSFetchRequest *roomFetchList = [NSFetchRequest fetchRequestWithEntityName:ROOM_ENTITY];
  /* Keep in mind, that the predicate is being called on the 'Room' entity and its relationships.  So we must 
   predicate on teh format of the room and thus hotel.name is lowercase as it is stated in the room relationship."
   */
  NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"hotel.name == %@", theHotelName];
  roomFetchList.predicate = thePredicate;
  NSError  *theError;
  NSArray *theRoomList = [self.coreDataStack.managedObjectContext executeFetchRequest:roomFetchList
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

 @return The Reservation Object.
 */
-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withGuest:(Guest *)guest {
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:RESERVATION_ENTITY
                                                           inManagedObjectContext:self.coreDataStack.managedObjectContext];
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


/**
 Method returning the NSFRC efficently alowing the fetched data for the available rooms within a hotel to be inserted into the TVC.

 @param fromDate Start date for the timerange. (predicate)
 @param toDate   End date for the timerange. (predicate)

 @return NSFetchedResultsController: the available rooms between the dates.
 */
-(NSFetchedResultsController *) fetchAvailableRoomsForFromDate:(NSDate *)fromDate
                                                        toDate:(NSDate *)toDate {
  // delete previous cache
  [NSFetchedResultsController deleteCacheWithName:@"AvailableRoomCache"];
  
  
  //Make the fetch (request "Reservation" and predicate with variables).
  NSFetchRequest *theRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", toDate, fromDate];
  theRequest.predicate = thePredicate;
  NSError *theFetchError;
  NSArray *fetchResults = [self.coreDataStack.managedObjectContext executeFetchRequest:theRequest
                                                                                 error:&theFetchError];
  
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
                                                        managedObjectContext:self.coreDataStack.managedObjectContext
                                                          sectionNameKeyPath:@"hotel.name"
                                                                   cacheName:@"AvailableRoomCache"];
  return fetchResultsController;

} // fetchAvailableRoomsForFromDate


/**
 Method requesting save to persistent Store.  
 */
- (void)saveContext {
  [self.coreDataStack saveContext];
} // saveContext

@end
