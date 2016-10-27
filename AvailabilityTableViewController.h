//
//  AvailabilityTableViewController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Hotel.h"


@interface AvailabilityTableViewController : UITableViewController
@property (strong, nonatomic) NSDate *myFromDate;
@property (strong, nonatomic) NSDate *myToDate;
//@property (strong, nonatomic) NSString *theHotelName;
@end
