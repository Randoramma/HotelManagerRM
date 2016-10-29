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

@interface HotelViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSArray *myHotels;
@property (strong, atomic) CDPersistenceController *myPersistenceController;

@end


/**
 View Controller allowing user to view the available Hotels.  User can select a Cell from the list of hotels and observe the list of rooms for that hotel.
 */
@implementation HotelViewController
@synthesize myTableView;


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
    // must initialize the controller prior to implementing it.  In future builds this needs to be in a seperate class handling all the fetches while
    self.myPersistenceController = [[CDPersistenceController alloc] init];
    [self.myPersistenceController initializeCoreDataWithCompletion:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            NSFetchRequest *hotelListFetch = [NSFetchRequest fetchRequestWithEntityName:HOTEL_ENTITY];
            NSError *fetchError;
            NSManagedObjectContext *theContext = [_myPersistenceController theMainMOC];
            NSArray *hotelList = [theContext executeFetchRequest:hotelListFetch
                                                           error:&fetchError];
            if (fetchError) {
                NSLog(@"%@", fetchError.localizedDescription);
            } else {
                _myHotels = hotelList;
            }
            
            [self.myTableView reloadData];
        } else {
            NSLog(@"There was an error loading the Core Data Stack %@", error.description);
        }
        
    }];
    
    // setup table view.
    [myTableView registerClass:[HotelTableViewCell class] forCellReuseIdentifier:HOTEL_CELL_ID];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TABLE_ROW_HEIGHT;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myHotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Hotel *theHotel = self.myHotels[indexPath.row];
    UIImage *theCellImage = [UIImage imageNamed:theHotel.imageName];
    HotelTableViewCell * theCell = (HotelTableViewCell *) [tableView dequeueReusableCellWithIdentifier:HOTEL_CELL_ID forIndexPath:indexPath];
    
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
    RoomTableViewController *roomVC = [[RoomTableViewController alloc] init];
    [self.navigationController pushViewController:roomVC animated:true];
    roomVC.theHotel = self.myHotels[indexPath.row];
    [myTableView deselectRowAtIndexPath:indexPath animated:false];
    
}

-(void) addConstraintsToRootView:(UIView *)theRootView withViews:(NSDictionary *)views {
    
    NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
    [theRootView addConstraints:tableViewVertical];
    NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
    [theRootView addConstraints:tableViewHorizontal];
    
}


@end
