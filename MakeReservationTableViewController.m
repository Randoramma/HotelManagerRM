//
//  MakeReservationTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AppDelegate.h"
#import "MakeReservationTableViewController.h"
#import "Constants.h"
#import "Guest+CoreDataProperties.h"
#import "CDPersistenceController.h"
#import "RoomImageTableViewCell.h"
#import "RoomInfoTableViewCell.h"
#import "CredentialsTableViewCell.h"
#import "CheckIn_OutTableViewCell.h"
#import "CheckoutButtonTableViewCell.h"
#import "AvailableRoomTableViewCell.h"



@interface MakeReservationTableViewController () <NSFetchedResultsControllerDelegate, UITextFieldDelegate>
//instantiate the tableview cells
@property (strong, nonatomic) RoomImageTableViewCell *myRoomImageCell;
@property (strong, nonatomic) RoomInfoTableViewCell *myRoomInfoCell;
@property (strong, nonatomic) CredentialsTableViewCell *myRoomCredentialsCell;
@property (strong, nonatomic) CheckIn_OutTableViewCell *myRoomDatesCell;
@property (strong, nonatomic) CheckoutButtonTableViewCell *myRoomButtonCell;
@property (strong, nonatomic) NSString *myFirstName;
@property (strong, nonatomic) NSString *myLastName;
@property (strong, nonatomic) UIImage *myImage;
@property (strong, nonatomic) Room *myRoom;
@property (strong, nonatomic) CDPersistenceController *myPersistenceController;
@property (strong, nonatomic) AppDelegate *myAppDelegate;

@end

// Static number of rows for this TVC.
NSInteger ROWS = 5;

typedef NS_ENUM(NSInteger, CellType){
    CellType_RoomImage = 0,
    CellType_RoomInfo = 1,
    CellType_RoomDates = 2,
    CellType_RoomCredentials = 3,
    CellType_RoomButton = 4,
};


/**
 Role if this VC is to allow a user with the dates and room chosen in the AvailableRoomTVC to save a reservation.
 */
@implementation MakeReservationTableViewController



-(void)loadView {
    [super loadView];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    // setup title.
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:TITLE_FONT size:TITLE_FONT_SIZE];
    self.navigationItem.titleView = titleLabel;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}


-(void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.title = @"Our Hotels";
    
    
    // registration of custom TVC's
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
    
    // set textfield delegates
    self.myRoomCredentialsCell.firstNameField.delegate = self;
    self.myRoomCredentialsCell.lastNameField.delegate = self;
    
    
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setPersistenceControllerFromDelegate:nil];
    NSError *objectIDError = nil;
    self.myRoom = [_myPersistenceController.theMainMOC existingObjectWithID:self.myRoomID error:&objectIDError];
  
  
#if DEBUG
    NSLog(@"The Room is %@", self.myRoom.debugDescription);
    NSLog(@"The Room is a fault = %d", self.myRoom.isFault);
    NSLog(@"View Will Appear completed");
#endif
}

#pragma mark - Table View Delegate Methods

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
            case CellType_RoomImage: {
                if (self.myRoomImageCell == nil) {
                    self.myRoomImageCell = [self.myRoomImageCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomImageCell"];
                }
                if (self.myRoom != Nil) {
                self.myRoomImageCell.theImage = [self setImageForAppropriateHotelRoom:self.myRoom];
                self.myRoomImageCell.cellImageView.image = self.myRoomImageCell.theImage;
                self.myRoomImageCell.backgroundColor = [UIColor blackColor];
                self.myRoomImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
                } else {
#if DEBUG
                    NSLog(@"The Room is %@", self.myRoom);
#endif
                }
                return self.myRoomImageCell;
                break;
            }
            case CellType_RoomInfo: {
                if (self.myRoomInfoCell == nil) {
                    self.myRoomInfoCell = [_myRoomInfoCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomInfoCell"];
                }
                self.myRoomInfoCell.roomNumberLabel.text = [NSString stringWithFormat:@"Room #%@",self.myRoom.number];
                self.myRoomInfoCell.roomRateLabel.text = [NSString stringWithFormat:@"Rate $%@",self.myRoom.rate];
                self.myRoomInfoCell.roomRatingLabel.text = [NSString stringWithFormat:@"Rating %@",self.myRoom.rating];
                self.myRoomInfoCell.numberOfBedsLabel.text = [NSString stringWithFormat:@"Beds %@",self.myRoom.beds];
                self.myRoomInfoCell.backgroundColor = [UIColor blackColor];
                self.myRoomInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return self.myRoomInfoCell;
                break;
            }
            case CellType_RoomDates: {
                
                if (self.myRoomDatesCell == nil) {
                    self.myRoomDatesCell = [self.myRoomDatesCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDatesCell"];
                }
                self.myRoomDatesCell.selectionStyle = UITableViewCellSelectionStyleNone;
                self.myRoomDatesCell.fromDateLabel.text = @"From :";
                self.myRoomDatesCell.toDateLabel.text = @"To :";
                self.myRoomDatesCell.fromDate.text = [_myAppDelegate.myDateFormatter stringFromDate:self.myFromDate];
                self.myRoomDatesCell.toDate.text = [_myAppDelegate.myDateFormatter stringFromDate:self.myToDate];
                self.myRoomDatesCell.backgroundColor = [UIColor blackColor];
                return self.myRoomDatesCell;
                break;
            }
            case CellType_RoomCredentials: {
                if (self.myRoomCredentialsCell == nil) {
                    self.myRoomCredentialsCell = [self.myRoomCredentialsCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomCredentialsCell"];
                    
                }
                self.myRoomCredentialsCell.backgroundColor = [UIColor blackColor];
                self.myRoomCredentialsCell.selectionStyle = UITableViewCellSelectionStyleNone;
                // set the fields to the label names
                self.myRoomCredentialsCell.firstNameLabel.text = @"First Name:";
                self.myRoomCredentialsCell.lastNameLabel.text = @"Last Name:";
                // set the delegate for the CredentialsTVC text fields to capture the names
                
                return self.myRoomCredentialsCell;
                break;
                
            }
            case CellType_RoomButton: {
                if (self.myRoomButtonCell == nil) {
                    self.myRoomButtonCell = [self.myRoomButtonCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomCheckoutCell"];
                }
                self.myRoomButtonCell.selectionStyle = UITableViewCellSelectionStyleNone;
                self.myRoomButtonCell.backgroundColor = [UIColor blackColor];
                [self.myRoomButtonCell.myReserveButton addTarget:self
                                                          action:@selector(makeReservation)
                                                forControlEvents:UIControlEventTouchUpInside];
                [self.myRoomButtonCell.myReserveButton setTitle:@"Make Reservation" forState:UIControlStateNormal];
                
                //        [_myAppDelegate bookReservationForRoom:self.theRoom startDate:self.fromDate endDate:self.toDate withGuest:self.theCell4.newGuest];
                return self.myRoomButtonCell;
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
        
    }
    
}

#pragma mark - Text Field Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.myRoomCredentialsCell.firstNameField]) {
        if (self.myRoomCredentialsCell.firstNameField.text.length != 0) {
            self.myFirstName = self.myRoomCredentialsCell.firstNameField.text;
        }
    } else if ([textField isEqual:self.myRoomCredentialsCell.lastNameField]) {
        if (self.myRoomCredentialsCell.lastNameField.text.length != 0) {
            self.myLastName = self.myRoomCredentialsCell.lastNameField.text;
        }
    } else {
        
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField == self.myRoomCredentialsCell.firstNameField) {
        [self.myRoomCredentialsCell.lastNameField becomeFirstResponder];
    }
    return true;
}


#pragma mark - Private Helper Methods
-(UIImage *) setImageForAppropriateHotelRoom: (Room *)theRoom {
    
    
    if([self.myRoom.hotel.name isEqualToString:FANCY_HOTEL_NAME]) {
        self.myImage = [UIImage imageNamed:FANCY_HOTEL_IMAGE_TVC];
    } else if ([self.myRoom.hotel.name isEqualToString:SOLID_HOTEL_NAME]) {
        self.myImage = [UIImage imageNamed:FANCY_HOTEL_IMAGE_TVC];
    } else if ([self.myRoom.hotel.name isEqualToString:DECENT_HOTEL_NAME]) {
        self.myImage = [UIImage imageNamed:DECENT_HOTEL_IMAGE_TVC];
    } else if ([self.myRoom.hotel.name isEqualToString:OK_HOTEL_NAME]) {
        self.myImage = [UIImage imageNamed:OK_HOTEL_IMAGE_TVC];
    } else {
        self.myImage = [UIImage imageNamed:@"PlaceHolderImage"];
    }
    return self.myImage;
}

-(void) makeReservation {
    // add popover here to simply display that the names have been entered incorrectly.
    
    if([self.myFirstName length] < 1) {
        self.myFirstName = @"You must enter a first name";
    } else if ([self.myLastName length] < 1) {
        self.myLastName = @"You must enter a last name";
    } else {
        [_myPersistenceController bookReservationForRoom:self.myRoom.objectID startDate:self.myFromDate endDate:self.myToDate withGuestFirstName:self.myFirstName andGuestLastName:self.myLastName andReturnBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSString *successMessage = [NSString stringWithFormat:@"You have reserved room %@ from %@ to %@. See you then!", self.myRoom.number, self.myFromDate.description, self.myToDate.description];
                UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                                      message: successMessage
                                                                               preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"OK action");
                                           }];
                
                [successAlert addAction:okAction];
                [self presentViewController:successAlert animated:YES completion:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }];
            } else {
                NSString *failMessage = [NSString stringWithFormat:@" Please reenter information and try again."];
                UIAlertController *failAlert = [UIAlertController alertControllerWithTitle:@"Reservation was not saved."
                                                                                   message: failMessage
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"OK action");
                                           }];
                
                [failAlert addAction:okAction];
                [self presentViewController:failAlert animated:YES completion:^{
                    self.myLastName = nil;
                    self.myFirstName = nil;
                    self.myRoomCredentialsCell.firstNameField.text = nil;
                    self.myRoomCredentialsCell.lastNameField.text = nil;
                    [self.tableView reloadData];
                }];
            }
        }];
        
    }
}

#pragma mark - Custom Method Injection Setter.
/**
 *  Setter providing access for custom App Delegate.
 *
 *  @param theAppDelegate either UIApplication app delegate or custom mock.
 *
 *  @return the app delegate containing the myPersistenceController property.
 */
-(AppDelegate *) setAppDelegate: (AppDelegate *)theAppDelegate {
    
    if (theAppDelegate == nil) {
        UIApplication *app = [UIApplication sharedApplication];
        return (AppDelegate *)[app delegate];
    } else {
        return theAppDelegate;
    }
}

/**
 *  Setter for the persistent controller property.
 *
 *  @param theAppDelegate either the application app delegate or a stub.
 */
-(void) setPersistenceControllerFromDelegate: (AppDelegate *)theAppDelegate {
    
    if (self.myPersistenceController == nil) {
        self.myPersistenceController = [self setAppDelegate:theAppDelegate].myPersistenceController;
    }
    
}




@end
