//
//  Room+CoreDataProperties.m
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Room+CoreDataProperties.h"

@implementation Room (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Room"];
}

@dynamic beds;
@dynamic number;
@dynamic rate;
@dynamic rating;
@dynamic hotel;
@dynamic reservation;

@end
