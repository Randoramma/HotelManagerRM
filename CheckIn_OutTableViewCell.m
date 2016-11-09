//
//  CheckIn_OutTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "CheckIn_OutTableViewCell.h"

@implementation CheckIn_OutTableViewCell

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
    
    self.toDate = [[UILabel alloc] init];
    self.toDate.textColor = [UIColor whiteColor];
    self.toDate.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.toDate];
    
    NSDictionary *cellViews = @{@"fromDateLabel": self.fromDateLabel,
                                @"toDateLabel": self.toDateLabel,
                                @"fromDate": self.fromDate,
                                @"toDate": self.toDate};
    [self setConstranitsForCellViewWithViews:cellViews];
  }
  return self;
}

-(void) setConstranitsForCellViewWithViews: (NSDictionary *)views {
  NSArray *hFromLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[fromDateLabel]-8-[fromDate]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hFromLayoutConstraint];
  NSArray *vDateConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[fromDate]-8-[toDate]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vDateConstraint];
  
  NSArray *hToLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[toDateLabel]-8-[toDate]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hToLayoutConstraint];
  NSArray *vLabelLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[fromDateLabel]-8-[toDateLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vLabelLayoutConstraint];
}

@end
