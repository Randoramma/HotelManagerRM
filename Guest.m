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
#import "Constants.h"


@implementation Guest

@synthesize firstName;
@synthesize lastName;
@synthesize memberNumber;
@synthesize reservations;


/**
 Method setting up Entity and insert into MOC with relevent information. Subititution for Init.

 @param theFirstName NSString: The guest's first name.
 @param theLastName  NSString: The guest's last name.
 @param theContext   MOC: The context the Guest is inserted into.

 @return The Guest Entity.
 */
+(Guest *)setupGuestWithFirstName:(NSString *)theFirstName LastName:(NSString *)theLastName Context: (NSManagedObjectContext*)theContext {
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:GUEST_ENTITY inManagedObjectContext:theContext];
  
  NSNumber *theMemberNumber = [NSNumber numberWithInteger:16];
  guest.firstName = theFirstName;
  guest.lastName = theLastName;
  guest.memberNumber = theMemberNumber;
  
  NSError *saveError;
  
  [theContext save:&saveError];
  
  if (saveError) {
    NSLog(@"%@", saveError);
    return nil;
  }
      return guest;
}
@end
