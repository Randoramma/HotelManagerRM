//
//  HotelService.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "HotelService.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"
#import "Reservation.h"
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

- (void)saveContext {
  
  [self.coreDataStack saveContext];
  
  
} // saveContext


@end
