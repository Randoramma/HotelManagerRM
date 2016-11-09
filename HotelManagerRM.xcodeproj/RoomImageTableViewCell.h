//
//  RoomImageTableViewCell.h
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataProperties.h"

@interface RoomImageTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView* cellImageView;
@property (strong, nonatomic) UIImage* theImage; 

@end
