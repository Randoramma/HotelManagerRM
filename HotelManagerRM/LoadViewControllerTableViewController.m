//
//  LoadViewControllerTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "LoadViewControllerTableViewController.h"
#import "HotelViewController.h"
#import "FromDateViewController.h"
#import "GuestServicesViewController.h"
#import "AppDelegate.h"
#import "Constants.h"


@interface LoadViewControllerTableViewController ()
@property (strong, nonatomic) NSArray* myOptions;

@end

@implementation LoadViewControllerTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // instantiate options menu
  self.title = @"Hotel Manager";
  self.myOptions = @[@"Hotel List", @"Available Rooms", @"Customer Reservations"];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"optionCell"];
  self.view.backgroundColor = [UIColor blackColor];
  self.tableView.tableFooterView = [[UIView alloc] init];
  
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return self.myOptions.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return TABLE_ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"optionCell" forIndexPath:indexPath];
  
  theCell.textLabel.text = self.myOptions[indexPath.row];
  theCell.textLabel.textColor = [UIColor whiteColor];
  theCell.backgroundColor = [UIColor blackColor];
  
  return theCell;
} // cellForRowAtIndexPath

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // enable switch statement to call the varying VC's based on row selected..
  
  switch (indexPath.row) {
    case 0: {
      // push on the Hotel's List VC.
      HotelViewController *hotelVC = [[HotelViewController alloc] init];
      [self.navigationController pushViewController:hotelVC animated:true];
      break;
    }
      
    case 1: {
      // push on the fromVC.
      FromDateViewController *fromVC = [[FromDateViewController alloc] init];
      [self.navigationController pushViewController:fromVC animated:true];
      break;
    }
      
    case 2: {
      // push on the list of reservations.
      GuestServicesViewController *guestVC = [[GuestServicesViewController alloc] init];
      [self.navigationController pushViewController:guestVC animated:true];
      break;
    }
      
      
    default:
      NSLog(@"Got to default");
      break;
      
  } // switch
} // didDeselectRowAtIndexPath


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
