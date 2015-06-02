//
//  MakeReservationViewController.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuestServicesViewController.h"
#import "Room.h"

@interface MakeReservationViewController : GuestServicesViewController
@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) NSDate *toDate;
@property (strong, nonatomic) Room *theRoom; 

@end
