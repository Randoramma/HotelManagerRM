//
//  MakeReservationTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "MakeReservationTableViewController.h"
#import "Constants.h"
#import "Guest.h"




@implementation MakeReservationTableViewController
-(void)loadView {
  [super loadView];
  // setup title.
  UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.font = [UIFont fontWithName:TITLE_FONT size:TITLE_FONT_SIZE];
  titleLabel.text = self.theHotel.name;
  self.navigationItem.titleView = titleLabel;
  // setup view.
  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  
  
  
}

-(void)viewDidLoad {
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  
  
  
}
@end
