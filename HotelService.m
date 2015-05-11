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
@property (strong, nonatomic)CoreDataStack *coreDataStack; 

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

-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.rooms = room;
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  
  // to be completed when VC's are in place.  
  NSNumber *theMemberNumber = [NSNumber numberWithInteger:16];
  guest.firstName = @"Randy";
  guest.lastName = @"Kitt";
  guest.memberNumber = theMemberNumber;
  reservation.guest = guest;
  
  NSError *saveError;
  
  [self.coreDataStack.managedObjectContext save:&saveError];
  
  if (saveError) {
    return nil;
  }
  
  return reservation;
}


- (void)saveContext {
  
  [self.coreDataStack saveContext];
  
  
} // saveContext


@end
