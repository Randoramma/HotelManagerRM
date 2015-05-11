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
  //Tod
  #warning Incomplete method implementation.
  return nil;
} // fetchAvailableRoomsForFromDate


- (void)saveContext {
  [self.coreDataStack saveContext];
} // saveContext

@end
