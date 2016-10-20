//
//  AvailabilityTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AvailabilityTableViewController.h"
#import "AvailableRoomTableViewCell.h"
#import "HotelService.h"
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "MakeReservationTableViewController.h"
#import "Room.h"
#import "Reservation.h"


@interface AvailabilityTableViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSArray *myRooms;
@property (strong, nonatomic) NSFetchedResultsController *fetchResultsController;
@property (strong, nonatomic) AppDelegate *myAppDelegate;


@end

@implementation AvailabilityTableViewController

-(void) loadView {
  [super loadView];
  self.tableView.backgroundColor = [UIColor blackColor];
  self.tableView.tableFooterView = [[UIView alloc] init];
  
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // setup up view here.
  self.title = @"Our available rooms";
  
  [self.tableView registerClass:[AvailableRoomTableViewCell class]forCellReuseIdentifier:@"AvailableRoomCell"];
  [self.tableView registerClass:[AvailableRoomTableViewCell class]forCellReuseIdentifier:@"NoRooms"];
  
  
}

-(void)viewDidAppear:(BOOL)animated {
  // declare this VC as the delegate of the AppDelegate class.
  self.fetchResultsController = [_myAppDelegate.hotelService fetchAvailableRoomsForFromDate:self.fromDate toDate:self.toDate];
  self.fetchResultsController.delegate = self;
  NSError *theFetchError;
  [NSFetchedResultsController deleteCacheWithName:self.fetchResultsController.cacheName];
  [self.fetchResultsController performFetch:&theFetchError];
  [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.fetchResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if ([[self.fetchResultsController sections] count] > 0) {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
  } else
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if ([self.fetchResultsController.sections count] !=0) {
    // Configure the cell...
    AvailableRoomTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"AvailableRoomCell" forIndexPath:indexPath];
    [self cellLayout:theCell atIndexPath:indexPath];
    theCell.backgroundColor = [UIColor blackColor];
    return theCell;
  } else {
    AvailableRoomTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"NoRooms" forIndexPath:indexPath];
    theCell.roomNumberLabel.text = @"No room available";
    theCell.backgroundColor = [UIColor blackColor];
    return theCell;
  }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  id<NSFetchedResultsSectionInfo> theSectionInfo = [[self.fetchResultsController sections] objectAtIndex: section];
  Room *theRoom = (Room *)theSectionInfo.objects[0];
  Hotel *theHotel = theRoom.hotel;
  NSString *description = [[NSString alloc] initWithFormat:@"%@ located in %@", theHotel.name, theHotel.location];
  
  return description;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // make a reservationVC.
  MakeReservationTableViewController *theReservation = [[MakeReservationTableViewController alloc] init];
  // pass the start date
  theReservation.fromDate = self.fromDate;
  // pass the end date
  theReservation.toDate = self.toDate;
  // pass the room
  theReservation.theRoom = [self.fetchResultsController objectAtIndexPath:indexPath];
  // pass the hotel
  theReservation.theHotel = theReservation.theRoom.hotel;
  
  [self.navigationController pushViewController:theReservation animated:true]; 
}

#pragma mark - Cell Layout
-(void)cellLayout:(AvailableRoomTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  Room *room = [self.fetchResultsController objectAtIndexPath:indexPath];
  cell.roomNumberLabel.text = [NSString stringWithFormat:@"Room #%@",room.number];
  cell.roomRateLabel.text = [NSString stringWithFormat:@"$%@ / night",room.rate];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
