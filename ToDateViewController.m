//
//  ToDateViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "ToDateViewController.h"
#import "AvailabilityTableViewController.h"

@interface ToDateViewController ()

@end

@implementation ToDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.myPickerLabel.text = @"Please select the end date for your stay.";
  // pass in button eventController.
  [self.myDateSelectionButton addTarget:self action:@selector(endPressed) forControlEvents:UIControlEventTouchUpInside];
//  [self.myDateSelectionButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void) endPressed {
  
  NSDate *myEndDate = self.myDatePicker.date;
  
  AvailabilityTableViewController *availablityVC = [[AvailabilityTableViewController alloc] init];
  availablityVC.fromDate = self.myFromDate;
  availablityVC.toDate = myEndDate;
  // push on new VC.
  [self.navigationController pushViewController:availablityVC animated:true];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
