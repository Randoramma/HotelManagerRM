//
//  AvailableRoomTableViewCell.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/27/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailableRoomTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel* numberOfBedsLabel;
@property (strong, nonatomic) UILabel* roomRateLabel;
@property (strong, nonatomic) UILabel* roomNumberLabel;
@property (strong, nonatomic) UIImageView* cellImageView;

@end
