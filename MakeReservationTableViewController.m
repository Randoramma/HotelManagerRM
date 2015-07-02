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
  if (indexPath.section == 0) {
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
    switch (indexPath.row) {
      case 0: {
        RoomImageTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"RoomImageCell" forIndexPath:indexPath];
        theCell.theImage = [self setImageForAppropriateHotelRoom:self.theRoom];
        //must set the below again after the cell has init.
        theCell.cellImageView.image = theCell.theImage;
        theCell.backgroundColor = [UIColor blackColor];
        theCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return theCell;
        break;
      }
      case 1: {
        RoomInfoTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"RoomInfoCell" forIndexPath:indexPath];
        theCell.roomNumberLabel.text = [NSString stringWithFormat:@"Room #%@",self.theRoom.number];
        theCell.roomRateLabel.text = [NSString stringWithFormat:@"Rate $%@",self.theRoom.rate];
        theCell.roomRatingLabel.text = [NSString stringWithFormat:@"Rating %@",self.theRoom.rating];
        theCell.numberOfBedsLabel.text = [NSString stringWithFormat:@"Beds %@",self.theRoom.beds];
        theCell.backgroundColor = [UIColor blackColor];
        theCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return theCell;
        break;
      }
      case 2: {
        CheckIn_OutTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"RoomDatesCell" forIndexPath:indexPath];
        theCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"EEEE, MMMM dd";
        theCell.fromDateLabel.text = @"From :";
        theCell.toDateLabel.text = @"To :";
        theCell.fromDate.text = [dateFormatter stringFromDate:self.fromDate];
        theCell.toDate.text = [dateFormatter stringFromDate:self.toDate];
        theCell.backgroundColor = [UIColor blackColor];
        return theCell;
        break;
      }
      case 3: {
        CredentialsTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"RoomCredentialsCell" forIndexPath:indexPath];
        theCell.backgroundColor = [UIColor blackColor];
        theCell.selectionStyle = UITableViewCellSelectionStyleNone;
        theCell.firstNameLabel.text = @"First Name:";
        theCell.lastNameLabel.text = @"Last Name:";
        return theCell;
        break;
      }
      case 4: {
        CheckoutButtonTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"RoomCheckoutCell" forIndexPath:indexPath];
        theCell.selectionStyle = UITableViewCellSelectionStyleNone;
        theCell.backgroundColor = [UIColor blackColor];
        return theCell;
        break;
        
      }
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
    self.myImage = [UIImage imageNamed:@"FancyEstateRoomImage"];
  } else if ([self.theRoom.hotel.name isEqualToString:@"Solid Stay"]) {
    self.myImage = [UIImage imageNamed:@"SolidStayRoomImage"];
  } else if ([self.theRoom.hotel.name isEqualToString:@"Decent Inn"]) {
    self.myImage = [UIImage imageNamed:@"DecentInnRoomImage"];
  } else if ([self.theRoom.hotel.name isEqualToString:@"Okay Motel"]) {
    self.myImage = [UIImage imageNamed:@"OKRoomImage"];
  } else {
    self.myImage = [UIImage imageNamed:@"PlaceHolderImage"];
  }
  return self.myImage;
}




@end
