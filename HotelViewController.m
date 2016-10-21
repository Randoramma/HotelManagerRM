//
//  HotelViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "HotelViewController.h"
#import "HotelService.h"
#import "CoreDataStack.h"
#import "RoomTableViewController.h"
#import "Hotel.h"
#import "HotelTableViewCell.h"
#import "Constants.h"

@interface HotelViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSArray *myHotels;
@property (strong, nonatomic) AppDelegate *myAppDelegate;


@end


/**
 View Controller allowing user to view the available Hotels.  User can select a Cell from the list of hotels and observe the list of rooms for that hotel.
 */
@implementation HotelViewController

@synthesize myTableView; 
/**
 Custom init providing a reference to the AppDelegate.

 @param theAppDelegate AppDelegate: reference to the classes app Delegate.

 @return self
 */
-(instancetype) initWithAppDelegate:(AppDelegate *)theAppDelegate {
  _myAppDelegate = theAppDelegate;
  self = [super init];

  return self;
}

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
  
  // declare this VC as the delegate of the AppDelegate class.
  HotelService *hotelService = _myAppDelegate.hotelService;
  // fetch list of hotels from hotel service;
  self.myHotels = hotelService.fetchAllHotels;

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
 // theCell.myHotelName.text = [NSString stringWithFormat:@"%@", theHotel.name];
 // theCell.cellImageView.image = [UIImage imageNamed:theHotel.imageName];
  
 //[theCell setImage:theCellImage AndLabelName:theHotel.name];
  return theCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  // push on the new VC. Segue to rooms VC.
  RoomTableViewController *roomVC = [[RoomTableViewController alloc] init];
  [self.navigationController pushViewController:roomVC animated:true];
  roomVC.theHotel = self.myHotels[indexPath.row];
 // [myTableView deselectRowAtIndexPath:indexPath animated:false];
  
}

-(void) addConstraintsToRootView:(UIView *)theRootView withViews:(NSDictionary *)views {
  
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
    [theRootView addConstraints:tableViewVertical];
  NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];

  [theRootView addConstraints:tableViewHorizontal];
  
  
}


@end
