//
//  Guest.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/9/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "HotelService.h"
#import "CoreDataStack.h"


@implementation Guest

@dynamic firstName;
@dynamic lastName;
@dynamic memberNumber;
@dynamic reservations;

-(Guest *)setupGuestWithFirstName:(NSString *)theFirstName LastName:(NSString *)theLastName Context: (NSManagedObjectContext*)theContext {
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:theContext];
  
  NSNumber *theMemberNumber = [NSNumber numberWithInteger:16];
  guest.firstName = theFirstName;
  guest.lastName = theLastName;
  guest.memberNumber = theMemberNumber;
  
  NSError *saveError;
  
  [self.managedObjectContext save:&saveError];
  
  if (saveError) {
    NSLog(@"%@", saveError);
    return nil;
  }
      return guest;
}
@end
