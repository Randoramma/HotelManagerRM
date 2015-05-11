//
//  GuestCheckInViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "GuestCheckInViewController.h"
#import "GuestReservationsTableViewController.h"
#import "Guest.h"

@interface GuestCheckInViewController ()

@end

@implementation GuestCheckInViewController




- (void)viewDidLoad {
    [super viewDidLoad];

  [self.myButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
}


-(void) loginPressed {
  // record the date
  Guest *myGuest = [[Guest alloc] init];
  myGuest.firstName = self.myFirstNameField.text;
  myGuest.lastName = self.myLastNameField.text;
  
  // push on the new VC.
  GuestReservationsTableViewController *grTVC = [[GuestReservationsTableViewController alloc]init];
  [self.navigationController pushViewController:grTVC animated:true];
  
} // loginPressed

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
