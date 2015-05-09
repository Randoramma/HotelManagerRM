//
//  HotelService.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoreDataStack;

@interface HotelService : NSObject

-(instancetype) initCoreDataStack: (CoreDataStack *)coreDataStack;

-(void) saveContext;

-(NSArray*) fetchAllHotels;

@end
