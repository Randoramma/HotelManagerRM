//
//  CheckIn_OutTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "CheckIn_OutTableViewCell.h"

@implementation CheckIn_OutTableViewCell

/* This seems like a duplicate cell of AvailableRoomTableViewCell */

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  
  if (self) {
    self.fromDateLabel = [[UILabel alloc] init];
    self.fromDateLabel.textColor = [UIColor whiteColor];
    self.fromDateLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.fromDateLabel];
    
    self.fromDate = [[UILabel alloc] init];
    self.fromDate.textColor = [UIColor whiteColor];
    self.fromDate.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.fromDate];
    
    self.toDateLabel = [[UILabel alloc] init];
    self.toDateLabel.textColor = [UIColor whiteColor];
    self.toDateLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.toDateLabel];
    
    NSDictionary *cellViews = @{@"fromDateLabel": self.fromDateLabel, @"toDateLabel": self.toDateLabel};
    [self setConstranitsForCellViewWithViews:cellViews];
  }
  return self;
}

-(void) setConstranitsForCellViewWithViews: (NSDictionary *)views {
  NSArray *hFromLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[fromDateLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hFromLayoutConstraint];
  NSArray *vFromLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[fromDateLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vFromLayoutConstraint];
  
  NSArray *hToLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[toDateLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hToLayoutConstraint];
  NSArray *vToLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[fromDateLabel]-8-[toDateLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vToLayoutConstraint];
}

@end
