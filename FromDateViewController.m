//
//  FromDateViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "FromDateViewController.h"
#import "ToDateViewController.h"

@interface FromDateViewController ()

@end

@implementation FromDateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // bring over the button and label id from the dateVC.
  // add text to label.
  self.myPickerLabel.text = @"Please select the start date for your stay.";
  // pass in button eventController.
  [self.myDateSelectionButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
  
} // viewDidLoad

-(void) nextPressed {
  // record the date
  NSDate *selectedDate = self.myDatePicker.date;
  
  // push on the new VC.
  ToDateViewController *toDateVC = [[ToDateViewController alloc] init];
  [self.navigationController pushViewController:toDateVC animated:true];
  
  
} // nextPressed

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
