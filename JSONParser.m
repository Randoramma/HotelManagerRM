//
//  JSONParser.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser



//-initWithContents
- (NSArray *)hotelsFromJSONData:(NSData *)jsonData {
  

  // get path to resource
//  NSString *filePath = [[NSString alloc] initWithContentsOfFile:@"file:/Users/randymclain/Documents/CSS/IOS/HotelManagerRM/HotelManagerRM" encoding:NSUTF8StringEncoding error:nil];
  
  NSString *filePath = [[NSBundle mainBundle]pathForResource:@"seed" ofType:@"json"];

  if (!filePath) {
    NSLog(@"File couldn't be read!");
    return nil;
  }
  
  // convert path to NSData (did not need)
  
  NSData *theData = [[NSData alloc] initWithContentsOfFile:filePath];
  
  // convert the Data to JSON object
  NSMutableDictionary *rootData = [NSJSONSerialization JSONObjectWithData:theData options:nil error:nil] {
    for (NSDictionary : hotelDictionary in rootData) {
      
      hotel = [object[i]];
      if object == "Hotels" {
        for (keys :
      }
      
      
      
    }
  }
  
  
  
  
  return nil;
} // hotelsFromJSONData


@end
