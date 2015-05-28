//
//  HotelManagerGraphicsKit.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/27/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "HotelManagerGraphicsKit.h"

@implementation HotelManagerGraphicsKit




+(void) drawHotelRatingStarwithFrame: (CGRect *)frame {
  //// Color Declarations
  CGFloat iconColorRGBA[4];
  //[MyStyleKit.iconColor getRed: &iconColorRGBA[0] green: &iconColorRGBA[1] blue: &iconColorRGBA[2] alpha: &iconColorRGBA[3]];
  
  UIColor* iconStrokeColor = [UIColor colorWithRed: (iconColorRGBA[0] * 0.2 + 0.8) green: (iconColorRGBA[1] * 0.2 + 0.8) blue: (iconColorRGBA[2] * 0.2 + 0.8) alpha: (iconColorRGBA[3] * 0.2 + 0.8)];
  
  //// Background Oval Drawing
  UIBezierPath* backgroundOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(18, 18, 264, 264)];
  [iconStrokeColor setFill];
  [backgroundOvalPath fill];
  //[MyStyleKit.iconColor setStroke];
  backgroundOvalPath.lineWidth = 6;
  [backgroundOvalPath stroke];
  
  
  //// Star Drawing
  UIBezierPath* starPath = UIBezierPath.bezierPath;
  [starPath moveToPoint: CGPointMake(150, 78.5)];
  [starPath addLineToPoint: CGPointMake(175.22, 115.29)];
  [starPath addLineToPoint: CGPointMake(218, 127.91)];
  [starPath addLineToPoint: CGPointMake(190.8, 163.26)];
  [starPath addLineToPoint: CGPointMake(192.03, 207.84)];
  [starPath addLineToPoint: CGPointMake(150, 192.9)];
  [starPath addLineToPoint: CGPointMake(107.97, 207.84)];
  [starPath addLineToPoint: CGPointMake(109.2, 163.26)];
  [starPath addLineToPoint: CGPointMake(82, 127.91)];
  [starPath addLineToPoint: CGPointMake(124.78, 115.29)];
  [starPath closePath];
  //[MyStyleKit.iconColor setFill];
  [starPath fill];
  [iconStrokeColor setStroke];
  starPath.lineWidth = 1;
  [starPath stroke];
}

@end
