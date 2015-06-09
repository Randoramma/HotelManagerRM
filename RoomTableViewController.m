//
//  RoomTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/8/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "RoomTableViewController.h"
#import "AppDelegate.h"
#import "HotelService.h"
#import "Room.h"
#import "Constants.h"

@interface RoomTableViewController ()
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSArray *theRooms;
@end

@implementation RoomTableViewController

-(void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  self.myTableView = [[UITableView alloc] init];
  [self.myTableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.myTableView];
  [self addConstraintsToRootView:rootView withViews:@{@"tableView" : self.myTableView}];
  self.view = rootView;
  
}
- (void)viewDidLoad {
  [super viewDidLoad];
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  HotelService *hotelService = appDelegate.hotelService;
  self.theRooms = [hotelService fetchAllRoomsForHotel:self.theHotel.name];
  [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"RoomCell"];
  self.myTableView.dataSource = self;
  self.myTableView.delegate = self;
  
  self.myTableView.backgroundColor = [UIColor blackColor];
  self.myTableView.tableFooterView = [[UIView alloc] init];
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
  
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.theRooms.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return TABLE_ROW_HEIGHT;
}

-(void) addConstraintsToRootView: (UIView *)rootView withViews:(NSDictionary *)views {
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVertical];
  NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontal];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell" forIndexPath:indexPath];
  
  // Configure the cell...
  theCell.textLabel.textColor = [UIColor whiteColor];
  theCell.backgroundColor = [UIColor blackColor];
  Room *theRoom = self.theRooms[indexPath.row];
  NSString *theRoomInfo = [NSString stringWithFormat:@"Room number: %@  Beds: %@", theRoom.number, theRoom.beds];
  theCell.textLabel.text = theRoomInfo;
  
  return theCell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
