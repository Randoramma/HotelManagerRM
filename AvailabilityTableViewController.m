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
#import "Constants.h"
#import "CDPersistenceController.h"
#import "AppDelegate.h"
#import "MakeReservationTableViewController.h"
#import "Room+CoreDataProperties.h"
#import "Hotel+CoreDataProperties.h"
#import "Reservation+CoreDataProperties.h"


@interface AvailabilityTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSFetchedResultsController *fetchResultsController;
@property (strong, nonatomic) NSArray * myRoomsList;
@property (strong, nonatomic) NSDateFormatter *myDateFormatter;
@property (strong, nonatomic) CDPersistenceController *myPersistenceController;


@end



/**
 Class responsible for displaying the rooms available between the "to" and "from" dates selected in the DateVC.
 */
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
  self.myPersistenceController = [[CDPersistenceController alloc] init];
  
}

-(void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.myPersistenceController initializeCoreDataWithCompletion:^(BOOL succeeded, NSError *error) {
    
    if (succeeded) {
      self.myDateFormatter = [[NSDateFormatter alloc] init];
      [_myDateFormatter setDateFormat:@"MM-dd-yyyy"];
      self.myRoomsList = [self fetchAvailbleRoomsFor:self.myFromDate
                                                  to:self.myToDate];
      [self.myPersistenceController saveDataWithReturnBlock:^(BOOL succeeded, NSError *error) {
        
      }];
      [self.tableView reloadData];
    } else {
      NSLog(@"There was an error loading the Core Data Stack %@", error.description);
    }
    
  }];
}

-(void)viewDidAppear:(BOOL)animated {
}

-(void) viewDidDisappear:(BOOL)animated {
  [self.myPersistenceController.theMainMOC reset]; 
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.myRoomsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.myRoomsList != 0 ) {
    
    AvailableRoomTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"AvailableRoomCell" forIndexPath:indexPath];
    [self cellLayout:theCell atIndexPath:indexPath];
    theCell.backgroundColor = [UIColor blackColor];
    
    return theCell;
  } else {
    return nil;
  }
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // make a reservationVC.
  
  if (self.myFromDate != nil && self.myToDate != nil) {
    MakeReservationTableViewController *theReservationVC = [[MakeReservationTableViewController alloc] init];
    // pass the start date
    theReservationVC.myFromDate = self.myFromDate;
    // pass the end date
    theReservationVC.myToDate = self.myToDate;
    // pass the room ID
//    Room *tempRoom = (Room *)self.myRoomsList[indexPath.row];
//    NSLog(@"the rooms's object ID is %@", tempRoom.objectID);
    //theReservationVC.myRoomID = tempRoom.objectID;
    theReservationVC.myRoom = self.myRoomsList[indexPath.row];

    // pass the hotel ID
//    Hotel *tempHotel = tempRoom.hotel;
//    NSLog(@"the hotel's object ID is %@", tempHotel.objectID);
//    theReservationVC.myHotelID = tempHotel.objectID;
    
    theReservationVC.myHotel = theReservationVC.myRoom.hotel;
    // attempting to release the hotel rooms from memory so they can be picket up by the next MOC.
    [self.navigationController pushViewController:theReservationVC animated:true];
  }
}


#pragma mark - FetchRequests

-(NSArray *) fetchAvailbleRoomsFor: (NSDate *)theStart to: (NSDate *)theEnd {
  
  // fetch all reservations occuring during the requested period.
  NSFetchRequest *bookedReservationFetchRequest = [NSFetchRequest fetchRequestWithEntityName:RESERVATION_ENTITY];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", theStart, theEnd];
  bookedReservationFetchRequest.predicate = predicate;
  
  NSError *fetchError;
  NSManagedObjectContext *theContext = [_myPersistenceController theMainMOC];
  NSMutableArray *reservationList = [theContext executeFetchRequest:bookedReservationFetchRequest
                                                              error:&fetchError];
  
  // pull the rooms associated with those reservations.
  NSMutableArray *rooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in reservationList) {
    [rooms addObject:reservation.rooms];
  }
  
  // fetch all other rooms which will be available.
  NSFetchRequest *availableRoomsRequest = [NSFetchRequest fetchRequestWithEntityName:ROOM_ENTITY];
  NSPredicate *mainPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@",  rooms];
  availableRoomsRequest.predicate = mainPredicate;
  
  NSArray *theAvailableRooms = [theContext executeFetchRequest:availableRoomsRequest
                                                         error:&fetchError];
  
  if (fetchError) {
    NSLog(@"%@", fetchError.localizedDescription);
  }
  return theAvailableRooms;
}


#pragma mark - Cell Layout
-(void)cellLayout:(AvailableRoomTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  Room *room = self.myRoomsList[indexPath.row];
  cell.roomNumberLabel.text = [NSString stringWithFormat:@"Room #%@",room.number];
  cell.roomRateLabel.text = [NSString stringWithFormat:@"$%@ / night",room.rate];
  cell.numberOfBedsLabel.text = [NSString stringWithFormat:@"# of Beds is %@", room.beds];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
