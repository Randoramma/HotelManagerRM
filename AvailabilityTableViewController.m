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


@interface AvailabilityTableViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *myFetchedResultsController;
@property (strong, nonatomic) NSDateFormatter *myDateFormatter;
@property (strong, nonatomic) CDPersistenceController *myPersistenceController;


@end
NSString * const ROOM_CELL_ID = @"AvailableRoomCell";


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
  
  [self.tableView registerClass:[AvailableRoomTableViewCell class]forCellReuseIdentifier:ROOM_CELL_ID];
  [self.tableView registerClass:[AvailableRoomTableViewCell class]forCellReuseIdentifier:@"NoRooms"];
  self.myPersistenceController = [[CDPersistenceController alloc] init];
  
}

-(void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self setPersistenceControllerFromDelegate:nil];

}

-(void)viewDidAppear:(BOOL)animated {
}

-(void) viewDidDisappear:(BOOL)animated {
  [self.myPersistenceController.theMainMOC reset]; 
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[[self myFetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  id <NSFetchedResultsSectionInfo> sectionInfo = [[[self myFetchedResultsController] sections] objectAtIndex:section];
  
  return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  AvailableRoomTableViewCell * theCell = nil;
  Room *theRoom = nil;
  
  theRoom = [[self myFetchedResultsController] objectAtIndexPath:indexPath];
  if (theCell == nil) {
    theCell = [[AvailableRoomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:ROOM_CELL_ID];
  }
  
  [theCell setImage:theCellImage AndLabelName:theHotel.name];
  theCell.backgroundColor = [UIColor blackColor];
  return theCell;
  
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

  
  NSArray *theAvailableRooms = [theContext executeFetchRequest:availableRoomsRequest
                                                         error:&fetchError];
  
  if (fetchError) {
    NSLog(@"%@", fetchError.localizedDescription);
  }
  return theAvailableRooms;
}

#pragma mark - NSFetchResultsController.
- (NSFetchedResultsController *)fetchedResultsController
{
  if (self.myFetchedResultsController) return self.myFetchedResultsController;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:ROOM_ENTITY];
  [fetchRequest setFetchBatchSize:4];
  
  [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc]
                                                             initWithKey:@"name"
                                                             ascending:YES]]];
  
  NSPredicate *mainPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@",  rooms];
  fetchRequest.predicate = mainPredicate;
  
  NSManagedObjectContext *moc = [[self myPersistenceController] theMainMOC];
  self.myFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:moc
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"HotelViewCache"];
  [self.myFetchedResultsController setDelegate:self];
  
  NSError *error = nil;
  NSAssert([self.myFetchedResultsController performFetch:&error], @"Unresolved error %@\n%@", [error localizedDescription], [error userInfo]);
  
  return self.myFetchedResultsController;
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
