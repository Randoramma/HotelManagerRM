//
//  FromDateViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()


@end

@implementation DateViewController


-(void)loadView {
  UIView *myRootView = [[UIView alloc] init];

  myRootView.backgroundColor = [UIColor whiteColor];
  
  // instantiate date Picker. Add the object.  Remove autoconstraints.
  self.myDatePicker = [[UIDatePicker alloc] init];
  [myRootView addSubview:self.myDatePicker];
  [self.myDatePicker setTranslatesAutoresizingMaskIntoConstraints:false];

  // add label for picker.
  self.myPickerLabel = [[UILabel alloc] init];
  [self.myPickerLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [myRootView addSubview:self.myPickerLabel];
  
  // add button for date selection.
  self.myDateSelectionButton = [[UIButton alloc] init];
  [self.myDateSelectionButton setTranslatesAutoresizingMaskIntoConstraints:false];
  // add UI to selection button.
  [self.myDateSelectionButton setTitle:@"Next" forState:UIControlStateNormal];
  [self.myDateSelectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [myRootView addSubview:self.myDateSelectionButton];
  // add all views to dictionary and constrain the container to the view(s).
  NSDictionary *views = @{@"datePicker" : self.myDatePicker, @"pickerLabel" : self.myPickerLabel, @"dateButton" : self.myDateSelectionButton};
  [self addConstraintsToRootView:myRootView forViews:views];
  
  // set the views.
      self.view = myRootView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) addConstraintsToRootView: (UIView *)rootView forViews:(NSDictionary *)views {
  //datePicker constraints.
  NSLayoutConstraint *fromDatePickerCenterX = [NSLayoutConstraint constraintWithItem:self.myDatePicker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  
    NSLayoutConstraint *fromDatePickerCenterY = [NSLayoutConstraint constraintWithItem:self.myDatePicker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
  // add array of constraints.
  [rootView addConstraints:@[fromDatePickerCenterX, fromDatePickerCenterY]];
  
  
  // label constraints.
  NSLayoutConstraint *pickerLabelX = [NSLayoutConstraint constraintWithItem:self.myPickerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  NSArray *pickerLabelY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pickerLabel]-20-[datePicker]" options:0 metrics:nil views:views];
  // add constraints
  [rootView addConstraint:pickerLabelX];
  [rootView addConstraints:pickerLabelY];
  
  
  // date button constraints.
  NSLayoutConstraint *dateButtonX = [NSLayoutConstraint constraintWithItem:self.myDateSelectionButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  NSArray *dateButtonY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[datePicker]-20-[dateButton]" options:0 metrics:nil views:views];
  // add label to date button.
  [rootView addConstraint:dateButtonX];
  [rootView addConstraints:dateButtonY];

}

@end
