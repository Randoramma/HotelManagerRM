//
//  Basic3LabelCell.m
//  HotelManagerRM
//
//  Created by Randy McLain on 11/8/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "Basic3LabelCell.h"
@interface Basic3LabelCell ()

@end


@implementation Basic3LabelCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.bottomRightLabel = [[UILabel alloc] init];
        self.bottomRightLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.bottomRightLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bottomRightLabel];
        self.leftLabel = [[UILabel alloc] init];
        self.leftLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.leftLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.leftLabel];
        self.topRightLabel = [[UILabel alloc] init];
        self.topRightLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.topRightLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topRightLabel];
        NSDictionary *cellViews = @{@"leftLabel" : self.leftLabel, @"bottomRightLabel": self.bottomRightLabel, @"topRightLabel" : self.topRightLabel};
        [self setConstranitsForCellViewWithViews:cellViews];
    }
    return self;
    
}

-(void) setConstranitsForCellViewWithViews: (NSDictionary *)views {
    NSDictionary *theMetrics = @{@"TS":@4, @"LeftS": @8, @"MidS":@2};
    
    // map out what you want the cell to look like.
    NSArray *hNumberLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[leftLabel]" options:0 metrics:theMetrics views:views];
    [self.contentView addConstraints:hNumberLayoutConstraint];
    NSArray *vNumberLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-TS-[leftLabel]" options:0 metrics:theMetrics views:views];
    [self.contentView addConstraints:vNumberLayoutConstraint];
    NSArray *hRateLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[topRightLabel]-LeftS-|" options:0 metrics:theMetrics views:views];
    [self.contentView addConstraints:hRateLayoutConstraint];
    NSArray *vRateLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-TS-[topRightLabel]" options:0 metrics:theMetrics views:views];
    [self.contentView addConstraints:vRateLayoutConstraint];
    NSArray *hLocationLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[bottomRightLabel]-LeftS-|" options:0 metrics:theMetrics views:views];
    [self.contentView addConstraints:hLocationLayoutConstraint];
    NSArray *vLocationLayoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topRightLabel]-MidS-[bottomRightLabel]-|" options:0 metrics:theMetrics views:views];
    [self.contentView addConstraints:vLocationLayoutConstraint];
}

@end
