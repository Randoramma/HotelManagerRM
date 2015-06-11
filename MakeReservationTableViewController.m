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
#import "RoomImageTableViewCell.h"
#import "RoomInfoTableViewCell.h"
#import "CredentialsTableViewCell.h"
#import "CheckIn_OutTableViewCell.h"
#import "CheckoutButtonTableViewCell.h"



@interface MakeReservationTableViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchResultsController;
//instantiate the tableview cells
@property (strong, nonatomic) RoomImageTableViewCell *myRoomImageCell;
@property (strong, nonatomic) RoomInfoTableViewCell *myRoomInfoCell;
@property (strong, nonatomic) CredentialsTableViewCell *myRoomCredentialsCell;
@property (strong, nonatomic) CheckIn_OutTableViewCell *myRoomDatesCell;
@property (strong, nonatomic) CheckoutButtonTableViewCell *myRoomButtonCell;


@end

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
  [self.tableView registerClass:[RoomImageTableViewCell class]forCellReuseIdentifier:@"RoomImageCell"];
  [self.tableView registerClass:[RoomInfoTableViewCell class]forCellReuseIdentifier:@"RoomInfoCell"];
  [self.tableView registerClass:[CredentialsTableViewCell class]forCellReuseIdentifier:@"RoomCretentialsCell"];
  [self.tableView registerClass:[CheckIn_OutTableViewCell class]forCellReuseIdentifier:@"RoomDatesCell"];
  [self.tableView registerClass:[CheckoutButtonTableViewCell class]forCellReuseIdentifier:@"RoomCheckoutCell"];
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

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // setup nibs for each of the different types of cells required for this table view controller.
//  
//  RoomImageTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"RoomImageCell" forIndexPath:0];
//  [self cellLayout:theCell atIndexPath:indexPath];
//  theCell.backgroundColor = [UIColor blackColor];
//  return theCell;
    switch (indexPath.row) {
      case 0:
        if (self.myRoomImageCell == nil) {
          self.myRoomImageCell = [self.myRoomImageCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomImageCell"];
        }
        self.myRoomButtonCell.backgroundColor = [UIColor blackColor];
        return self.myRoomImageCell;
        break;
      case 1:
        if (self.myRoomInfoCell == nil) {
          self.myRoomInfoCell = [self.myRoomInfoCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomInfoCell"];
        }
        self.myRoomInfoCell.backgroundColor = [UIColor blackColor];
        return self.myRoomInfoCell;
        break;
      case 2:
        if (self.myRoomDatesCell == nil) {
          self.myRoomDatesCell = [self.myRoomDatesCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDatesCell"];
        }
        self.myRoomDatesCell.backgroundColor = [UIColor blackColor];
        return self.myRoomDatesCell;
        break;
      case 3:
        if (self.myRoomCredentialsCell == nil) {
          self.myRoomCredentialsCell = [self.myRoomCredentialsCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomCretentialsCell"];
        }
        self.myRoomCredentialsCell.backgroundColor = [UIColor blackColor];
        return self.myRoomCredentialsCell;
        break;
      case 4:
        if (self.myRoomButtonCell == nil) {
          self.myRoomButtonCell = [self.myRoomButtonCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomButtonCell"];
        }
        self.myRoomButtonCell.backgroundColor = [UIColor blackColor];
        return self.myRoomButtonCell;
        break;
        
      default:
        return [[UITableViewCell alloc]init];
        break;
  }
}

@end
