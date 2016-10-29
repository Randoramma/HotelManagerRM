//
//  Guest+CoreDataProperties.m
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Guest+CoreDataProperties.h"

@implementation Guest (CoreDataProperties)

+ (NSFetchRequest<Guest *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Guest"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic memberNumber;
@dynamic reservations;

@end
