//
//  AvailabilityTableViewController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ToDateViewController.h"
#import "Hotel.h"
#import "Room.h"


@interface AvailabilityTableViewController : UITableViewController
@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) NSDate *toDate;
@property (strong, nonatomic) NSString *theHotelName; 
@end
