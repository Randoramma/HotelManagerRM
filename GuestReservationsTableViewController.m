//
//  GuestReservationsTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "GuestReservationsTableViewController.h"
#import "Reservation+CoreDataProperties.h"

@interface GuestReservationsTableViewController ()

@end

@implementation GuestReservationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  Guest *test1Guest = [[Guest alloc] init];
  test1Guest.firstName = @"Randy";
  test1Guest.lastName = @"Keys";
  
  Reservation *testReservations = [[Reservation alloc] init];
  testReservations.guest = test1Guest;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
