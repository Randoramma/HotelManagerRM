//
//  GuestReservationsTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AppDelegate.h"
#import "Basic3LabelCell.h"
#import "Constants.h"
#import "CDPersistenceController.h"
#import "GuestReservationsTableViewController.h"
#import "Reservation+CoreDataProperties.h"

@interface GuestReservationsTableViewController ()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *myFetchedResultsController;
@property (strong, nonatomic) CDPersistenceController *myPersistenceController;
@property (strong, nonatomic) NSDateFormatter *myDateFormatter;

@end

@implementation GuestReservationsTableViewController

NSString *GUEST_RESERVATION_TABLE_VIEW_CELL_REUSE_ID = @"GuestReservationReuseID";
NSString *GRTVC_CACHE_NAME = @"TheGuestReservationCacheName";

-(void) loadView {
  [super loadView];
  self.tableView.backgroundColor = [UIColor blackColor];
  self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[self tableView] registerClass:[Basic3LabelCell class] forCellReuseIdentifier:GUEST_RESERVATION_TABLE_VIEW_CELL_REUSE_ID];
  [self setPersistenceControllerFromDelegate:nil];
  
  [self setMyDateFormatter:[[NSDateFormatter alloc] init]];
  
  [_myDateFormatter setDateStyle:NSDateFormatterMediumStyle];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  NSInteger theSections = [[[self myFetchedResultsController] sections] count];
#if DEBUG
  NSLog(@"GuestReservationsTVC: The number of sections is %lu",theSections);
#endif
  return theSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  if ([[_myFetchedResultsController sections] count] > 0) {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_myFetchedResultsController sections] objectAtIndex:section];
#if DEBUG
    NSLog(@"GuestReservationTVC: The number of rows is %lu",[sectionInfo numberOfObjects]);
#endif
    return [sectionInfo numberOfObjects];
  } else
    return 0;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60.0;
}


// register the class for reuse identifier in VDL
// setup the cnostant in @implementation

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  Reservation *theReservation = nil;
  Basic3LabelCell * theCell = [[self tableView] dequeueReusableCellWithIdentifier: GUEST_RESERVATION_TABLE_VIEW_CELL_REUSE_ID
                                                                     forIndexPath:indexPath];
  
  if (theCell == nil) {
    theCell = [[Basic3LabelCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:GUEST_RESERVATION_TABLE_VIEW_CELL_REUSE_ID];
  }
  
  theReservation = [_myFetchedResultsController objectAtIndexPath:indexPath];
  
  NSString *theStartDate = [_myDateFormatter stringFromDate:theReservation.startDate];
  NSString *theEndDate = [_myDateFormatter stringFromDate:theReservation.endDate];
  
  theCell.bottomRightLabel.text = theEndDate;
  theCell.topRightLabel.text = theStartDate;
  theCell.leftLabel.text = [NSString stringWithFormat:@"%@", theReservation.rooms.number];
  theCell.backgroundColor = [UIColor blackColor];
  return theCell;
  
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Reservation * theReservation = nil;
        theReservation = [[self myFetchedResultsController] objectAtIndexPath:indexPath];
        [[self myPersistenceController] removeReservationWithStartDate:theReservation.startDate endDate:theReservation.endDate andRoom:theReservation.rooms.objectID];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView  editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing)
    {
        return UITableViewCellEditingStyleDelete; //enable when editing mode is on
    }
    
    return UITableViewCellEditingStyleNone;
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchResultsController.
- (NSFetchedResultsController *)myFetchedResultsController
{
  [NSFetchedResultsController deleteCacheWithName: GRTVC_CACHE_NAME];
  if (_myFetchedResultsController) return _myFetchedResultsController;
  
  
  // fetch all reservations occuring during the requested period.
  NSFetchRequest *bookedReservationFetchRequest = [NSFetchRequest fetchRequestWithEntityName:RESERVATION_ENTITY];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guest == %@", self.fromGuest];
  bookedReservationFetchRequest.predicate = predicate;
  
  [bookedReservationFetchRequest setSortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc]
                                                             initWithKey:FRC_RESERVATION_SORT_DESCRIPTOR_KEY
                                                             ascending:YES]]];
  
  NSError *fetchError;
  if ([self myPersistenceController].theMainMOC == nil) {
    [self setPersistenceControllerFromDelegate:nil];
  }
  NSManagedObjectContext *moc = [self myPersistenceController].theMainMOC;
  
#if DEBUG
  NSLog(@"GuestReservationTVC:  NS-FRC moc = %@", moc.description);
  NSLog(@"GuestReservationTVC:  NS-FRC fetchRequest = %@", bookedReservationFetchRequest.description);
#endif
  
  _myFetchedResultsController =[[NSFetchedResultsController alloc] initWithFetchRequest:bookedReservationFetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:GRTVC_CACHE_NAME];
  [_myFetchedResultsController setDelegate:self];
  
  NSAssert([_myFetchedResultsController performFetch:&fetchError], @"Unresolved error %@\n%@", [fetchError localizedDescription], [fetchError userInfo]);
  
  
#if DEBUG
  
  NSLog(@"GuestReservationTVC: The number of rooms fetched is %lu", [moc countForFetchRequest:bookedReservationFetchRequest  error:&fetchError]);
#endif
  
  return _myFetchedResultsController;
}

- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
    [[self tableView] endUpdates];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
    [[self tableView] beginUpdates];
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
