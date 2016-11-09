//
//  MakeReservationTableViewController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataProperties.h"
#import "Hotel+CoreDataProperties.h"

@interface MakeReservationTableViewController : UITableViewController
@property (strong, nonatomic) NSDate *myFromDate;
@property (strong, nonatomic) NSDate *myToDate;
@property (strong, nonatomic) NSManagedObjectID *myRoomID;
@property (strong, nonatomic) NSManagedObjectID *myHotelID;
//@property (strong, nonatomic) Room *myRoom;
//@property (strong, nonatomic) Hotel *myHotel; 
@end
