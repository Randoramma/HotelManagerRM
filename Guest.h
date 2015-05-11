//
//  Guest.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/9/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class HotelService;
@class Reservation;
@class AppDelegate; 

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * memberNumber;
@property (nonatomic, retain) NSSet *reservations;

+(Guest*)setupGuestWithFirstName: (NSString *)theFirstName LastName:(NSString*)theLastName Context: (NSManagedObjectContext*)theContext;
@end


@interface Guest (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;
@end
