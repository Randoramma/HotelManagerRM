//
//  AvailableRoomTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/27/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AvailableRoomTableViewCell.h"

@implementation AvailableRoomTableViewCell

/* This seems like a duplicate cell of AvailableRoomTableViewCell */

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  
  if (self) {
    self.numberOfBedsLabel = [[UILabel alloc] init];
    self.numberOfBedsLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.numberOfBedsLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.numberOfBedsLabel];
    self.roomNumberLabel = [[UILabel alloc] init];
    self.roomNumberLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.roomNumberLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.roomNumberLabel];
    self.roomRateLabel = [[UILabel alloc] init];
    self.roomRateLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.roomRateLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.roomRateLabel];
    NSDictionary *cellViews = @{@"numberOfBedsLabel" : self.numberOfBedsLabel, @"roomNumberLabel": self.roomNumberLabel, @"roomRateLabel" : self.roomRateLabel};
    [self setConstranitsForCellViewWithViews:cellViews];
  }
  return self;
  
}

-(void) setConstranitsForCellViewWithViews: (NSDictionary *)views {
  // map out what you want the cell to look like.
  NSArray *hNumberLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[roomNumberLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hNumberLayoutConstraint];
  NSArray *vNumberLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[roomNumberLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vNumberLayoutConstraint];
  NSArray *hRateLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[roomRateLabel]-8-|" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hRateLayoutConstraint];
  NSArray *vRateLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[roomRateLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vRateLayoutConstraint];
  NSArray *hLocationLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[numberOfBedsLabel]-8-|" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hLocationLayoutConstraint];
  NSArray *vLocationLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[roomRateLabel]-2-[numberOfBedsLabel]" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vLocationLayoutConstraint];
}
@end
