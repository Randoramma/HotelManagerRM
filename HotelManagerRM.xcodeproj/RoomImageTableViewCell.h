//
//  RoomImageTableViewCell.h
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface RoomImageTableViewCell : UITableViewCell
@property (strong, nonatomic) UITextField* firstNameField;
@property (strong, nonatomic) UITextField* lastNameField;
@property (strong, nonatomic) UIImageView* cellImageView;
@property (strong, nonatomic) UIButton* checkoutButton;
@end
