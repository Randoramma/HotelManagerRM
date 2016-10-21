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
@property (strong, nonatomic) NSArray * myOptions;
@property (strong, nonatomic) NSString * myTitle;
@property (strong, nonatomic) AppDelegate * myAppDelegate;

@end

/**
 The initial VC that the app starts with.  Provides user with Options: "Hotel List", "Available Rooms", and "Customer Reservations"
 */
@implementation LoadViewControllerTableViewController

-(instancetype)initWithAppDelegate:(AppDelegate *)theAppDelegate {
  _myAppDelegate = theAppDelegate;
  self = [super init]; 
  
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // instantiate options menu
  _myTitle = @"Hotel Manager";
  _myOptions = @[@"Hotel List", @"Available Rooms", @"Customer Reservations"];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OPTION_CELL_ID];
  self.view.backgroundColor = [UIColor blackColor];
  self.tableView.tableFooterView = [[UIView alloc] init];
  
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return _myOptions.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return TABLE_ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *theCell = [self.tableView dequeueReusableCellWithIdentifier:OPTION_CELL_ID forIndexPath:indexPath];
  
  theCell.textLabel.text = _myOptions[indexPath.row];
  theCell.textLabel.textColor = [UIColor whiteColor];
  theCell.backgroundColor = [UIColor blackColor];
  
  return theCell;
} // cellForRowAtIndexPath

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // enable switch statement to call the varying VC's based on row selected..
  
  switch (indexPath.row) {
    case 0: { //"Hotel List"
      // push on the Hotel's List VC.
      HotelViewController *hotelVC = [[HotelViewController alloc] initWithAppDelegate:_myAppDelegate];
      [self.navigationController pushViewController:hotelVC animated:true];
      break;
    }
      
    case 1: { //"Available Rooms"
      // push on the fromVC.
      FromDateViewController *fromVC = [[FromDateViewController alloc] init];
      [self.navigationController pushViewController:fromVC animated:true];
      break;
    }
      
    case 2: { //"Customer Reservations"
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
