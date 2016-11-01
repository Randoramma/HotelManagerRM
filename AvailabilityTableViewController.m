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

-(void)cellLayout:(AvailableRoomTableViewCell *)cell forRoom:(Room *)theRoom atIndexPath:(NSIndexPath *)indexPath;
@end
NSString * const ROOM_CELL_ID = @"AvailableRoomCell";
NSString * const FRC_SORT_DESCRIPTOR_KEY = @"number";
NSString * const FRC_CACHE_NAME = @"AvailabilityViewCache";


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
    [self setPersistenceControllerFromDelegate:nil];
    
}

#pragma mark - Table View Data Source

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
    
    [self cellLayout:theCell forRoom:theRoom atIndexPath:indexPath];
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

/**
 *  Prefetch the reservations to provide a boundary for rooms returned.
 *
 *  @param theStart The beginning of reservation range.
 *  @param theEnd   The end of reservation range.
 *
 *  @return List of reservations during requested time period.
 */
-(NSArray *) fetchReservationsBetween: (NSDate *)theStart to: (NSDate *)theEnd {
    
    // fetch all reservations occuring during the requested period.
    NSFetchRequest *bookedReservationFetchRequest = [NSFetchRequest fetchRequestWithEntityName:RESERVATION_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", theStart, theEnd];
    bookedReservationFetchRequest.predicate = predicate;
    
    NSError *fetchError;
    // as the FRC calls the setup fetch upon init the controller may not be initiailized yet.
    // Check to see if it is and if not, initialize it prior to any fetching to ensure use of theMainMOC.
    if ([self myPersistenceController].theMainMOC == nil) {
        [self setPersistenceControllerFromDelegate:nil];
    }
    
    NSManagedObjectContext *theContext = [[self myPersistenceController]  theMainMOC];
    NSArray *reservationList = [theContext executeFetchRequest:bookedReservationFetchRequest
                                                         error:&fetchError];
#if DEBUG
    NSLog(@"Fetch for reservations has been executed.");
#endif
    
    if (fetchError) {
        NSLog(@"%@", fetchError.localizedDescription);
    }
    return reservationList;
}

#pragma mark - NSFetchResultsController.
- (NSFetchedResultsController *)myFetchedResultsController
{
    if (_myFetchedResultsController) return _myFetchedResultsController;
    
    NSArray *reservationsForDates = [self fetchReservationsBetween:self.myFromDate to:self.myToDate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:ROOM_ENTITY];
    [fetchRequest setFetchBatchSize:20];
    
    //TODO: How to set sort descriptor based on relationship between the hotels and rooms, not just on room number.
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc]
                                                               initWithKey:FRC_SORT_DESCRIPTOR_KEY
                                                               ascending:YES]]];
    
    //  Any room that has a reservation between the dates will not be returned.
    NSPredicate *mainPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@",  reservationsForDates];
    fetchRequest.predicate = mainPredicate;
    
    NSManagedObjectContext *moc = [[self myPersistenceController] theMainMOC];
    
#if DEBUG
    NSLog(@"Availability View  NS-FRC moc = %@", moc.description);
    NSLog(@"Availability View  NS-FRC fetchRequest = %@", fetchRequest.description);
#endif
    _myFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                      managedObjectContext:moc
                                                                        sectionNameKeyPath:nil
                                                                                 cacheName:FRC_CACHE_NAME];
    [_myFetchedResultsController setDelegate:self];
    
    NSError *error = nil;
    NSAssert([_myFetchedResultsController performFetch:&error], @"Unresolved error %@\n%@", [error localizedDescription], [error userInfo]);
    
    return _myFetchedResultsController;
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
-(void)cellLayout:(AvailableRoomTableViewCell *)cell forRoom:(Room *)theRoom atIndexPath:(NSIndexPath *)indexPath {
    
    cell.roomNumberLabel.text = [NSString stringWithFormat:@"Room #%@",theRoom.number];
    cell.roomRateLabel.text = [NSString stringWithFormat:@"$%@ / night",theRoom.rate];
    cell.numberOfBedsLabel.text = [NSString stringWithFormat:@"# of Beds is %@", theRoom.beds];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
