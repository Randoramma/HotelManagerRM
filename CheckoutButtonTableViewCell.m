//
//  CheckoutButtonTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "CheckoutButtonTableViewCell.h"
@interface CheckoutButtonTableViewCell()
@property (strong, nonatomic) UIView* theFrame;
-(void)centerHorizontallyInSuperview: (UIButton *)theButton;
-(void)centerVerticallyInSuperview: (UIButton *)theButton;



@end

@implementation CheckoutButtonTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  
  if (self) {
    
    self.myReserveButton = [[UIButton alloc] init];
    self.myReserveButton.translatesAutoresizingMaskIntoConstraints = false;
    self.myReserveButton.backgroundColor = [UIColor colorWithRed:144/255.0f green:19/255.0f blue:254/255.0f alpha:1.0f];
    //[self.myReserveButton setBackgroundImage:[UIImage imageNamed:@"buttonClicked"] forState:UIControlStateNormal];
    
    [self addSubview:self.myReserveButton];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.myReserveButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.myReserveButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.8 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.myReserveButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.myReserveButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
  }
  return self;
}

@end
