//
//  ViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  UIView *blueView = [[UIView alloc] initWithFrame: CGRectMake(100, 300, 50, 50)];
                      blueView.backgroundColor = [UIColor blueColor];
  [rootView addSubview:blueView];
  [blueView setTranslatesAutoresizingMaskIntoConstraints:false];
  NSDictionary *views = @{@"blueView" : blueView};
  
  [self addConstraintsToRootView:rootView withViews:views];
  
  
  // must add to storyboard.
  self.view = rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


-(void) addConstraintsToRootView: (UIView *) rootView withViews: (NSDictionary *)views {
  
  NSArray *blueViewHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[blueView(40)]" options:0 metrics: nil views:views];
  UIView *blueView = views[@"blueView"];
  [blueView addConstraints:blueViewHeight];
  
  NSArray *blueViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[blueView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:blueViewHorizontal];
  NSArray *blueViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[blueView]" options:0 metrics:nil views:views];
  [rootView addConstraints: blueViewVertical];
  
  
  
  
  
}

@end
