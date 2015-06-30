//
//  CheckoutButtonTableViewCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "CheckoutButtonTableViewCell.h"

@implementation CheckoutButtonTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  
  if (self) {

  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button addTarget:self
             action:@selector(aMethod:)
   forControlEvents:UIControlEventTouchUpInside];
  [button setTitle:@"Make Reservation" forState:UIControlStateNormal];
  button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
  [self addSubview:button];
  
    NSDictionary *cellViews = @{@"reserveButton": self.myReserveButton};
    [self setConstranitsForCellViewWithViews:cellViews];
  }
  return self;
}
  
  
-(void) setConstranitsForCellViewWithViews: (NSDictionary *)views {
  
  
}
@end
