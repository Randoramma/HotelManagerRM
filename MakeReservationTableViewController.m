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
#import "AppDelegate.h"



@interface MakeReservationTableViewController () <NSFetchedResultsControllerDelegate, UITextFieldDelegate>
//@property (strong, nonatomic) NSFetchedResultsController *fetchResultsController;
//instantiate the tableview cells
@property (strong, nonatomic) RoomImageTableViewCell *myRoomImageCell;
@property (strong, nonatomic) RoomInfoTableViewCell *myRoomInfoCell;
@property (strong, nonatomic) CredentialsTableViewCell *myRoomCredentialsCell;
@property (strong, nonatomic) CheckIn_OutTableViewCell *myRoomDatesCell;
@property (strong, nonatomic) CheckoutButtonTableViewCell *myRoomButtonCell;
@property (strong, nonatomic) AppDelegate *myAppDelegate;
@property (strong, nonatomic) NSString *myFirstName;
@property (strong, nonatomic) NSString *myLastName;
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
        RoomImageTableViewCell *theCell0 = [tableView dequeueReusableCellWithIdentifier:@"RoomImageCell" forIndexPath:indexPath];
        theCell0.theImage = [self setImageForAppropriateHotelRoom:self.theRoom];
        //must set the below again after the cell has init.
        theCell0.cellImageView.image = theCell0.theImage;
        theCell0.backgroundColor = [UIColor blackColor];
        theCell0.selectionStyle = UITableViewCellSelectionStyleNone;
        return theCell0;
        break;
      }
      case 1: {
        RoomInfoTableViewCell *theCell1 = [tableView dequeueReusableCellWithIdentifier:@"RoomInfoCell" forIndexPath:indexPath];
        theCell1.roomNumberLabel.text = [NSString stringWithFormat:@"Room #%@",self.theRoom.number];
        theCell1.roomRateLabel.text = [NSString stringWithFormat:@"Rate $%@",self.theRoom.rate];
        theCell1.roomRatingLabel.text = [NSString stringWithFormat:@"Rating %@",self.theRoom.rating];
        theCell1.numberOfBedsLabel.text = [NSString stringWithFormat:@"Beds %@",self.theRoom.beds];
        theCell1.backgroundColor = [UIColor blackColor];
        theCell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return theCell1;
        break;
      }
      case 2: {
        CheckIn_OutTableViewCell *theCell2 = [tableView dequeueReusableCellWithIdentifier:@"RoomDatesCell" forIndexPath:indexPath];
        theCell2.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"EEEE, MMMM dd";
        theCell2.fromDateLabel.text = @"From :";
        theCell2.toDateLabel.text = @"To :";
        theCell2.fromDate.text = [dateFormatter stringFromDate:self.fromDate];
        theCell2.toDate.text = [dateFormatter stringFromDate:self.toDate];
        theCell2.backgroundColor = [UIColor blackColor];
        return theCell2;
        break;
      }
      case 3: {
        CredentialsTableViewCell *theCell3 = [tableView dequeueReusableCellWithIdentifier:@"RoomCredentialsCell" forIndexPath:indexPath];
        theCell3.backgroundColor = [UIColor blackColor];
        theCell3.selectionStyle = UITableViewCellSelectionStyleNone;
        // set the fields to the label names
        theCell3.firstNameLabel.text = @"First Name:";
        self.myFirstName = theCell3.firstNameField.text;
        self.myLastName = theCell3.lastNameField.text;
        theCell3.lastNameLabel.text = @"Last Name:";
        
        Guest *newGuest = [[Guest alloc] init];
        newGuest.firstName = self.myFirstName;
        newGuest.lastName = self.myLastName;
        return theCell3;
        break;
      }
      case 4: {
        CheckoutButtonTableViewCell *theCell4 = [tableView dequeueReusableCellWithIdentifier:@"RoomCheckoutCell" forIndexPath:indexPath];
        theCell4.selectionStyle = UITableViewCellSelectionStyleNone;
        theCell4.backgroundColor = [UIColor blackColor];
        [theCell4.myReserveButton addTarget:self
                                     action:@selector(makeReservation)
                           forControlEvents:UIControlEventTouchUpInside];
        [theCell4.myReserveButton setTitle:@"Make Reservation" forState:UIControlStateNormal];
        
//        [_myAppDelegate bookReservationForRoom:self.theRoom startDate:self.fromDate endDate:self.toDate withGuest:self.theCell4.newGuest];
        return theCell4;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // not sure why I want this...
  [self.tableView deselectRowAtIndexPath:indexPath animated:true];
  
  if (indexPath.row == 3) {
//    
//    [self.theCell3.text]
//    
//    
//    
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



-(void) makeReservation {
  // add popover here to simply display that the names have been entered incorrectly.
  
  if([self.myFirstName length] < 1) {
    self.myFirstName = @"You must enter a first name";
  }
  
  if([self.myLastName length] < 1) {
    self.myLastName = @"You must enter a last name";
  }
  else {
//    [_myAppDelegate bookReservationForRoom:<#(Room *)#> startDate:<#(NSDate *)#> endDate:<#(NSDate *)#> withGuest:<#(Guest *)#>]
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
  }
}




@end
