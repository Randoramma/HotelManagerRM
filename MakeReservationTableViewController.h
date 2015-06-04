//
//  MakeReservationTableViewController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Hotel.h"

@interface MakeReservationTableViewController : UITableViewController
@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) NSDate *toDate;
@property (strong, nonatomic) Room *theRoom;
@property (strong, nonatomic) Hotel *theHotel;
@end
