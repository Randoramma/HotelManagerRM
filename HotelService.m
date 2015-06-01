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

-(NSArray *) fetchAllRoomsForHotel: (NSString *)theHotelName {
  NSFetchRequest *roomFetchList = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  /* Keep in mind, that the predicate is being called on the 'Room' entity and its relationships.  So we must 
   predicate on teh format of the room and thus hotel.name is lowercase as it is stated in the room relationship."
   */
  NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"hotel.name == %@", theHotelName];
  roomFetchList.predicate = thePredicate;
  NSError  *theError;
  NSArray *theRoomList = [self.coreDataStack.managedObjectContext executeFetchRequest:roomFetchList error:&theError];
  
  if (theError) {
    NSLog(@"%@",theError.localizedDescription);
    return nil;
  } else {
    return theRoomList;
  }
}

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

-(NSFetchedResultsController *) fetchAvailableRoomsForFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  // delete previous cache
  [NSFetchedResultsController deleteCacheWithName:@"AvailableRoomCache"];
  
  
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
  NSSortDescriptor *theHotelName = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:true];
  NSSortDescriptor *theRoomOrder = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:true];
  finalRoomRequest.sortDescriptors = @[theHotelName, theRoomOrder];
  finalRoomRequest.predicate = roomPredicate;
  
  NSFetchedResultsController *fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:finalRoomRequest managedObjectContext:self.coreDataStack.managedObjectContext sectionNameKeyPath:@"hotel.name" cacheName:@"AvailableRoomCache"];
  return fetchResultsController;

} // fetchAvailableRoomsForFromDate


- (void)saveContext {
  [self.coreDataStack saveContext];
} // saveContext

@end
