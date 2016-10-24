//
//  HotelTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 10/20/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "HotelTableViewCell.h"

@implementation HotelTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@synthesize cellImageView;
@synthesize myHotelName;
@synthesize myImage;


/**
 Init for HotelTableView Cell which will contain an image of the hotel room and the name for the hotel.

 @param style           The style of TVC.
 @param reuseIdentifier The reuse ID.
 @param theImage        The image placed on the L in the cell.
 @param theHotelName    The name of the hotel to be placed to the R of the image.

 @return The TVC.
 */
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Image:(UIImage *)theImage AndName: (NSString *)theHotelName {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // setup attributes
    cellImageView = [[UIImageView alloc] init];
    cellImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:cellImageView];
    
    myHotelName = [[UILabel alloc] init];
    myHotelName.text = theHotelName;
    myHotelName.textAlignment = NSTextAlignmentRight;
    myHotelName.textColor = [UIColor whiteColor];
    myHotelName.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:myHotelName];
    
    NSDictionary *cellViews = @{@"cellImageView" : cellImageView, @"myHotelName": myHotelName};
    [self setConstranitsForCellViewWithViews:cellViews];
  }
  return self;
}


/**
 <#Description#>

 @param theImage     <#theImage description#>
 @param theHotelName <#theHotelName description#>
 */
-(void) setImage:(UIImage *)theImage AndLabelName: (NSString *)theHotelName {
  
  cellImageView = [[UIImageView alloc] initWithImage:theImage];
  cellImageView.translatesAutoresizingMaskIntoConstraints = false;
  [self.contentView addSubview:cellImageView];
  
  myHotelName = [[UILabel alloc]init];
  myHotelName.text = theHotelName;
  myHotelName.textColor = [UIColor whiteColor];
  myHotelName.translatesAutoresizingMaskIntoConstraints = false;
  
  [self.contentView addSubview:myHotelName];
  NSDictionary *cellViews = @{@"cellImageView" : cellImageView, @"myHotelName": myHotelName};
  
  self.backgroundColor = [UIColor blackColor];
  
  [self setConstranitsForCellViewWithViews:cellViews];
 
}


/**
 The VML description of the layout for the Hotel TVC.  Should be Image - Text Vertically centered in the cell.

 @param views The descriptions H and V for the items in the cell.
 */
-(void) setConstranitsForCellViewWithViews: (NSDictionary *)views {

  NSArray *hImageLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[cellImageView(150)]-8-[myHotelName]-8-|" options:0 metrics:nil views:views];
  [self.contentView addConstraints:hImageLayoutConstraint];
  NSArray *vImageLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[cellImageView]-8-|" options:0 metrics:nil views:views];
  [self.contentView addConstraints:vImageLayoutConstraint];
  NSArray *vNameLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[myHotelName]-8-|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:vNameLayoutConstraint];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
