//
//  Hotel+CoreDataProperties.m
//  HotelManagerRM
//
//  Created by Randy McLain on 10/28/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Hotel+CoreDataProperties.h"

@implementation Hotel (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
}

@dynamic imageName;
@dynamic location;
@dynamic name;
@dynamic rating;
@dynamic rooms;

@end
