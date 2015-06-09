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
  self.tableView.backgroundColor = [UIColor blackColor];
  self.tableView.tableFooterView = [[UIView alloc] init];
 
}

-(void)viewDidLoad {
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return 5;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
  if (indexPath.row == 0) {
      return 160.0;
  } else {
    return 76;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // setup nibs for each of the different types of cells required for this table view controller.
  
  
}

@end
