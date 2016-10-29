//
//  CredentialsTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "CredentialsTableViewCell.h"

@implementation CredentialsTableViewCell


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  
  if (self) {
    self.firstNameLabel = [[UILabel alloc] init];
    self.firstNameLabel.textColor = [UIColor whiteColor];
    self.firstNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.firstNameLabel];
    
    self.lastNameLabel = [[UILabel alloc] init];
    self.lastNameLabel.textColor = [UIColor whiteColor];
    self.lastNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.lastNameLabel];
    
    self.firstNameField = [[UITextField alloc] init];
    self.firstNameField.translatesAutoresizingMaskIntoConstraints = false;
    self.firstNameField.placeholder = @"first name here";
    self.firstNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.firstNameField.backgroundColor = [UIColor colorWithRed:83/255.0f green:78/255.0f blue:78/255.0f alpha:1.0f];
    [self.firstNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.contentView addSubview:self.firstNameField];
    
    self.lastNameField = [[UITextField alloc] init];
    self.lastNameField.translatesAutoresizingMaskIntoConstraints = false;
    self.lastNameField.placeholder = @"last name here";
    self.lastNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.lastNameField.backgroundColor = [UIColor colorWithRed:83/255.0f green:78/255.0f blue:78/255.0f alpha:1.0f];
    [self.lastNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.contentView addSubview:self.lastNameField];
    
    
    NSDictionary *cellViews = @{@"firstNameLabel": self.firstNameLabel,
                                @"lastNameLabel": self.lastNameLabel,
                                @"firstNameField": self.firstNameField,
                                @"lastNameField": self.lastNameField};
    
    [self setConstranitsForCellViewWithViews:cellViews];
  }
  return self;
}

-(void) setConstranitsForCellViewWithViews: (NSDictionary *)views {
  
  NSArray *hFirstConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[firstNameLabel]-2.0-[firstNameField]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hFirstConstraint];
  NSArray *hLastConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[lastNameLabel]-2.0-[lastNameField]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hLastConstraint];
  NSArray *vLabelConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10.0-[firstNameLabel]-12.0-[lastNameLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vLabelConstraint];
  NSArray *vFieldConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[firstNameField]-2.0-[lastNameField]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vFieldConstraint];
  
  
}

@end
