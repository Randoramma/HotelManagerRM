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
#import "AvailableRoomTableViewCell.h"



@interface MakeReservationTableViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchResultsController;
//instantiate the tableview cells
@property (strong, nonatomic) RoomImageTableViewCell *myRoomImageCell;
@property (strong, nonatomic) RoomInfoTableViewCell *myRoomInfoCell;
@property (strong, nonatomic) CredentialsTableViewCell *myRoomCredentialsCell;
@property (strong, nonatomic) CheckIn_OutTableViewCell *myRoomDatesCell;
@property (strong, nonatomic) CheckoutButtonTableViewCell *myRoomButtonCell;
@property (strong, nonatomic) UIImage *myImage;


@end


NSInteger ROWS = 5;

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
//  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  self.tableView.backgroundColor = [UIColor blackColor];
  self.tableView.tableFooterView = [[UIView alloc] init];
  
}

-(void)viewDidLoad {
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerClass:[RoomImageTableViewCell class]forCellReuseIdentifier:@"RoomImageCell"];
  [self.tableView registerClass:[RoomInfoTableViewCell class]forCellReuseIdentifier:@"RoomInfoCell"];
  [self.tableView registerClass:[CredentialsTableViewCell class]forCellReuseIdentifier:@"RoomCredentialsCell"];
  [self.tableView registerClass:[CheckIn_OutTableViewCell class]forCellReuseIdentifier:@"RoomDatesCell"];
  [self.tableView registerClass:[CheckoutButtonTableViewCell class]forCellReuseIdentifier:@"RoomCheckoutCell"];
  
  [self.tableView registerClass:[AvailableRoomTableViewCell class]forCellReuseIdentifier:@"NoRooms"];
  // initialize the cells
  self.myRoomImageCell = [[RoomImageTableViewCell alloc] init];
  self.myRoomInfoCell = [[RoomInfoTableViewCell alloc] init];
  self.myRoomDatesCell = [[CheckIn_OutTableViewCell alloc] init];
  self.myRoomCredentialsCell = [[CredentialsTableViewCell alloc] init];
  self.myRoomButtonCell = [[CheckoutButtonTableViewCell alloc] init];
  
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return ROWS;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section) {
    switch (indexPath.row) {
      case 0:
        return 160.0;
        break;
        
      default:
        return 76;
        break;
    }
  } else {
    return 0;
  }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // setup nibs for each of the different types of cells required for this table view controller.
  
  if (indexPath.section == 0) {
    // we are seeing the section 0 appear.
//    AvailableRoomTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"NoRooms" forIndexPath:indexPath];
//    theCell.roomNumberLabel.text = @"No room available";
//    theCell.backgroundColor = [UIColor blackColor];
//    return theCell;
    switch (indexPath.row) {
      case 0: {
        if (self.myRoomInfoCell == nil) {
          self.myRoomInfoCell = [self.myRoomInfoCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomInfoCell"];
        }
        self.myRoomInfoCell.backgroundColor = [UIColor blueColor];
        return self.myRoomInfoCell;
        break;

        
//        if (self.myRoomImageCell == nil) {
//          self.myRoomImageCell = [self.myRoomImageCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomImageCell"];
//        }
//        
//       // RoomImageTableViewCell *cell;
////        RoomImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomImageCell" forIndexPath:indexPath];
////        cell.theImage = [self setImageForAppropriateHotelRoom:self.theRoom];
//        self.myRoomImageCell.backgroundColor = [UIColor redColor];
//        return self.myRoomImageCell;
//        break;
      }
      case 1:
        if (self.myRoomInfoCell == nil) {
          self.myRoomInfoCell = [self.myRoomInfoCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomInfoCell"];
        }
        self.myRoomInfoCell.backgroundColor = [UIColor blueColor];
        return self.myRoomInfoCell;
        break;
      case 2:
        if (self.myRoomDatesCell == nil) {
          self.myRoomDatesCell = [self.myRoomDatesCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDatesCell"];
        }
        self.myRoomDatesCell.backgroundColor = [UIColor whiteColor];
        return self.myRoomDatesCell;
        break;
      case 3:
        if (self.myRoomCredentialsCell == nil) {
          self.myRoomCredentialsCell = [self.myRoomCredentialsCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomCredentialsCell"];
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
  } else {
    AvailableRoomTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"NoRooms" forIndexPath:indexPath];
    theCell.roomNumberLabel.text = @"No Other room available";
    theCell.backgroundColor = [UIColor blackColor];
    return theCell;
  }
}

-(UIImage *) setImageForAppropriateHotelRoom: (Room *)theRoom {
  
  if([self.theRoom.hotel.name isEqualToString:@"Fancy Estates"]) {
    self.myImage = [[UIImage alloc] initWithContentsOfFile:@"FancyEstateRoomImage"];
  } else if ([self.theRoom.hotel.name isEqualToString:@"Solid Stay"]) {
    self.myImage = [[UIImage alloc] initWithContentsOfFile:@"SolidStayRoomImage"];
  } else if ([self.theRoom.hotel.name isEqualToString:@"Decent Inn"]) {
    self.myImage = [[UIImage alloc] initWithContentsOfFile:@"DecentInnRoomImage"];
  } else if ([self.theRoom.hotel.name isEqualToString:@"Okay Motel"]) {
    self.myImage = [[UIImage alloc] initWithContentsOfFile:@"OKRoomImage"];
  } else {
    self.myImage = [[UIImage alloc] initWithContentsOfFile:@"PlaceHolderImage"];
  }
  return self.myImage;
}


@end
