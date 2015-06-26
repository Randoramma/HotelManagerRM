//
//  RoomReservationImageTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "RoomImageTableViewCell.h"



@interface RoomImageTableViewCell ()
@property (strong, nonatomic) UIImage* hotelrooms;

@end

@implementation RoomImageTableViewCell

// counting on the particular ReservationVC delivering a valid Image with the message request here...
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  
  if (self) {
    self.cellImageView = [[UIImageView alloc] initWithImage:self.theImage];
    self.cellImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.cellImageView];
    NSDictionary *cellViews = @{@"cellImageView" : self.cellImageView};
    [self setConstraintsForCellViewWithViews:cellViews];
  }
  return self;
}

-(void) setConstraintsForCellViewWithViews: (NSDictionary *)views {
  // map out what you want the cell to look like.
  NSArray *hNumberLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[cellImageView]-8-|" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hNumberLayoutConstraint];
  NSArray *vNumberLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[cellImageView]-8-|" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vNumberLayoutConstraint];
  }



@end
