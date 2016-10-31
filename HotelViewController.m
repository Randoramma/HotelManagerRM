//
//  HotelViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "CDPersistenceController.h"
#import "HotelViewController.h"
#import "HotelService.h"
#import "RoomTableViewController.h"
#import "Hotel+CoreDataProperties.h"
#import "HotelTableViewCell.h"
#import "Constants.h"

@interface HotelViewController () <UITableViewDataSource,UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView * myTableView;
@property (strong, nonatomic) NSArray * myHotels;
@property (strong, nonatomic) CDPersistenceController * myPersistenceController;
@property (strong, nonatomic) NSFetchedResultsController *myFetchedResultsController;

@end


/**
 View Controller allowing user to view the available Hotels.  User can select a Cell from the list of hotels and observe the list of rooms for that hotel.
 */
@implementation HotelViewController
@synthesize myTableView;

#pragma mark - View Controller Life Cycle Methods.
/**
 *  View Controller lifecycle method called prior to viewDidLoad.  Programatic layout best to go here before any IB meddling.
 */
-(void)loadView {
    // build out the root view
    UIView *theRootView = [[UIView alloc] init];
    // add the tableView
    myTableView = [[UITableView alloc] init];
    [myTableView setTranslatesAutoresizingMaskIntoConstraints:false];
    [theRootView addSubview:myTableView];
    // set the rootVC as the view
    self.view = theRootView;
    self.title = @"Our Hotels";
    myTableView.backgroundColor = [UIColor blackColor];
    myTableView.tableFooterView = [[UIView alloc] init];
    
    // call custom method to constrain the table view into the rootVC.
    [self addConstraintsToRootView:theRootView withViews:@{@"tableView" : self.myTableView}];
    
} // loadView

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPersistenceControllerFromDelegate:nil]; 
    // setup table view.
    [myTableView registerClass:[HotelTableViewCell class] forCellReuseIdentifier:HOTEL_CELL_ID];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
}


#pragma mark - UITableView Delegate Methods.
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TABLE_ROW_HEIGHT;
}

/**
 *  Delegate method returning number of sections for the TVC.  Sections based on the NSFetchRequest sectionNameKeyPath
 *
 *  @param tableView the TableView...
 *
 *  @return The number of sections : Integer.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[self fetchedResultsController] sections] count];
}


/**
 *  Delegate method determining the number of rows for the table section.  Rows based on table view section array within the FetchResults Controller setup NSFetchRequest.
 *
 *  @param tableView the table View.
 *  @param section   The Section within the table view.
 *
 *  @return The number of rows for the Section : Integer.
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self myFetchedResultsController] sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotelTableViewCell * theCell = nil;
    Hotel *theHotel = nil;
    
    theHotel = [[self myFetchedResultsController] objectAtIndexPath:indexPath];
    UIImage *theCellImage = [UIImage imageNamed:theHotel.imageName];
    theCell = (HotelTableViewCell *) [tableView dequeueReusableCellWithIdentifier:HOTEL_CELL_ID forIndexPath:indexPath];
    
    if (theCell == nil) {
        theCell = [[HotelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HOTEL_CELL_ID Image:theCellImage AndName:theHotel.name];
    }
    
    if (theCell.cellImageView.image != nil) {
        theCell.cellImageView.image = nil;
        theCell.myHotelName.text = nil;
    }
    
    [theCell setImage:theCellImage AndLabelName:theHotel.name];
    theCell.backgroundColor = [UIColor blackColor];
    return theCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // push on the new VC. Segue to rooms VC.
    Hotel *theHotel = nil;
    
    theHotel = [[self myFetchedResultsController] objectAtIndexPath:indexPath];
    RoomTableViewController *roomVC = [[RoomTableViewController alloc] init];
    [self.navigationController pushViewController:roomVC animated:true];
    roomVC.theHotel = theHotel; 
    [myTableView deselectRowAtIndexPath:indexPath animated:false];
    
}


#pragma mark - VFL UI Setup for the Hotel View Controller.
-(void) addConstraintsToRootView:(UIView *)theRootView withViews:(NSDictionary *)views {
    
    NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
    [theRootView addConstraints:tableViewVertical];
    NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
    [theRootView addConstraints:tableViewHorizontal];
    
}


#pragma mark - NSFetchResultsController.
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_myFetchedResultsController) return _myFetchedResultsController;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:HOTEL_ENTITY];
    [fetchRequest setFetchBatchSize:4];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]]];
    
    NSManagedObjectContext *moc = [[self myPersistenceController] theMainMOC];
    self.myFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:@"HotelViewCache"];
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







@end
