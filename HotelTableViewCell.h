//
//  HotelTableViewCell.h
//  HotelManagerRM
//
//  Created by Randy McLain on 10/20/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelTableViewCell : UITableViewCell
@property (strong, nonatomic, nullable) UIImageView * cellImageView;
@property (strong, nonatomic, nullable) UIImage * myImage;
@property (strong, nonatomic, nullable) UILabel * myHotelName;


-(instancetype _Nonnull) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nonnull)reuseIdentifier Image:(UIImage * _Nullable)theImage AndName: (NSString *_Nonnull)theHotelName;

-(void) setImage:(UIImage * _Nullable)theImage AndLabelName: (NSString * _Nonnull)theHotelName;
@end
