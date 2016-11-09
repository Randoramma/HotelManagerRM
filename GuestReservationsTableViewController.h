//
//  GuestReservationsTableViewController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guest+CoreDataProperties.h"

@interface GuestReservationsTableViewController : UITableViewController
@property (strong, nonatomic)Guest *fromGuest;
@end
