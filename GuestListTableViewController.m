//
//  GuestListTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 11/8/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//


#import "AppDelegate.h"
#import "Basic3LabelCell.h"
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "CDPersistenceController.h"
#import "Guest+CoreDataProperties.h"
#import "GuestListTableViewController.h"


/**
 *  Provides a list of guest's whose first OR last name matches the input from the GuestCheckInViewController.
 */
@interface GuestListTableViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController * myFetchController;
@property (strong, nonatomic) CDPersistenceController * myPersistenceController;

@end
@implementation GuestListTableViewController


NSString * MY_TABLE_VIEW_CELL = @"GuestListTableCellReuseIdentifier";

#pragma mark - TVC lifecycle methods.
-(void) loadView {
    [super loadView];
    [self tableView].backgroundColor = [UIColor blackColor];
    
}


-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString * vcTitle = [NSString stringWithFormat:@"Guests matching %@ : %@", self.myGuestFirstName, self.myGuestLastName];
    [self setTitle: vcTitle];
    [[self tableView] registerClass:[Basic3LabelCell class] forCellReuseIdentifier:MY_TABLE_VIEW_CELL];
    [self setPersistenceControllerFromDelegate: nil];
}

#pragma mark - Table View Data Source

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger theSections = [[[self myFetchController] sections] count];
    
#if DEBUG
    NSLog(@"GuestListTVC: The number of sections is %lu",theSections);
#endif
    
    return theSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[[self myFetchController] sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[[self myFetchController] sections] objectAtIndex:section];
#if DEBUG
        NSLog(@"AvailabilityTVC: The number of rows is %lu",[sectionInfo numberOfObjects]);
#endif
        return [sectionInfo numberOfObjects];
    } else
        return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Basic3LabelCell * theCell = nil;
    Guest *theGuest = nil;
    
    theGuest = [[self myFetchController] objectAtIndexPath:indexPath];
    if (theCell == nil) {
        theCell = [[Basic3LabelCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:MY_TABLE_VIEW_CELL];
    }
    
    [self cellLayout:theCell forGuest:theGuest atIndexPath:indexPath];
    theCell.backgroundColor = [UIColor blackColor];
    return theCell;
    
}

#pragma mark - Cell Layout
/**
 *  Custom layout method setting up the Availability TVC with properties based on user input.
 *
 *  @param cell      the relevent cell to setup.
 *  @param theRoom   the Room based on the array of objects within the FRC.
 *  @param indexPath The index within the TV.
 */
-(void)cellLayout:(Basic3LabelCell *)cell forGuest:(Guest *)theGuest atIndexPath:(NSIndexPath *)indexPath {
    
    cell.leftLabel.text = [NSString stringWithFormat:@"Name: %@ %@",theGuest.firstName, theGuest.lastName];
    cell.topRightLabel.text = [NSString stringWithFormat:@"Reservations"];
    cell.bottomRightLabel.text = [NSString stringWithFormat:@"%lu", theGuest.reservations.count];
    
}


#pragma mark - NSFetchResultsController.
- (NSFetchedResultsController *)myFetchedResultsController
{
    [NSFetchedResultsController deleteCacheWithName: FRC_GUEST_LIST_CACHE_NAME];
    if (_myFetchController) return _myFetchController;
    [self.myFetchController setDelegate:self];
    
    
    NSFetchRequest *guestListFetch = [NSFetchRequest fetchRequestWithEntityName:GUEST_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(firstName == %@) OR (lastName == %@)", self.myGuestFirstName, self.myGuestLastName];
    [guestListFetch setPredicate:predicate];
    
    NSManagedObjectContext *moc = [self myPersistenceController].theMainMOC;
#if DEBUG
    NSLog(@"GuestListTVC:  NS-FRC moc = %@", moc.description);
    NSLog(@"GuestListTVC:  NS-FRC fetchRequest = %@", guestListFetch.description);
#endif

    
    NSError *error = nil;
    NSAssert([self.myFetchController performFetch:&error], @"Unresolved error %@\n%@", [error localizedDescription], [error userInfo]);

    self.myFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:guestListFetch
                                                                 managedObjectContext:moc
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:FRC_AVAILABILITY_CACHE_NAME];
    
    
#if DEBUG
    
    NSLog(@"AvailabilityTVC: The number of rooms fetched is %lu", [moc countForFetchRequest:guestListFetch  error:&error]);
#endif
    
    return _myFetchController;
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
