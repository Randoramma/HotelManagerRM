//
//  Hotel.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (nonatomic, assign) NSInteger *stars;
@property (strong, nonatomic) NSArray *rooms;

@end
