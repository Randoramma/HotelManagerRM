//
//  JSONParser.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "JSONParser.h"
#import "AppDelegate.h"
#import "Hotel.h"

@implementation JSONParser



//-initWithContents
+(void) hotelsFromJSONData: (NSManagedObjectContext*)context {

  NSString *filePath = [[NSBundle mainBundle]pathForResource:@"seed" ofType:@"json"];
  
  if (!filePath) {
    NSLog(@"File couldn't be read!");
  }
  
  // convert path to NSData (did not need)
  
  NSData *theData = [[NSData alloc] initWithContentsOfFile:filePath];
  NSError *jsonError;
  
  // convert the Data to JSON object
  NSDictionary *rootData = [NSJSONSerialization JSONObjectWithData:theData options:0 error:&jsonError];
  
  if (!jsonError) {
    // in this case JSON is an array of hotels : dictionaries
    NSMutableArray *jsonData = rootData[@"Hotels"];
    // for each value of dictionary in the array.
    for (NSDictionary *hotelDictionary in jsonData) {
      // we are taking in the hotels as these entity objects to be stored into core data.  Here.
      Hotel *myHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:context];
      // assing the properties.
      myHotel.name = hotelDictionary[@"name"];
      myHotel.location = hotelDictionary[@"location"];
      myHotel.stars = hotelDictionary[@"stars"];
      // each room is an array of dictionaries.  This process is the same as the hotel above.
      for (NSDictionary *roomDictionary in hotelDictionary[@"rooms"]) {
      Room *myRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:context];
        
        myRoom.number = roomDictionary[@"number"];
        myRoom.beds = roomDictionary[@"beds"];
        myRoom.rate = roomDictionary[@"rate"];
        myRoom.hotel = myHotel;
        
        
      } // roomDictionary
      
    } // hotelDictionary
    // must make space in memory if an error occurs.
    NSError *saveError;
    // save the "context to memory and log an error if it occured.  MUST DO!!!!  
    [context save:&saveError];
    // if there is an error log it into the console.
    if (saveError) {
      NSLog(@"%@", saveError.localizedDescription);
    }
  }
} // hotelsFromJSONData


@end
