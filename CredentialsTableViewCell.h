//
//  CredentialsTableViewCell.h
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CredentialsTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel* firstNameLabel;
@property (strong, nonatomic) UITextField* firstNameField;
@property (strong, nonatomic) UILabel* lastNameLabel;
@property (strong, nonatomic) UITextField* lastNameField;
@end
