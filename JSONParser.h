//
//  JSONParser.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"


@interface JSONParser : NSObject
@property (strong, nonatomic) NSArray *Hotels;


+(void) hotelsFromJSONData: (NSManagedObjectContext*)context;

@end

