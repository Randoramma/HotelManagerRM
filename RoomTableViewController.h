//
//  RoomTableViewController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelViewController.h"
#import "Hotel+CoreDataProperties.h"

@interface RoomTableViewController : UITableViewController
// create an array of rooms to list.
@property (strong, nonatomic)Hotel *theHotel;
@end
