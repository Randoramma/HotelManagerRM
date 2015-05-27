//
//  AvailabilityTableViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AvailabilityTableViewController.h"
#import "HotelService.h"
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "Room.h"


@interface AvailabilityTableViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSArray *myRooms;
@property (strong, nonatomic) NSFetchedResultsController *fetchMyResults;


@end

@implementation AvailabilityTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  // declare this VC as the delegate of the AppDelegate class.
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  HotelService *hotelService = appDelegate.hotelService;
  // fetch list of rooms from hotel service;
  self.myRooms = [hotelService fetchAvailableRoomsForFromDate:self.fromDate toDate:self.toDate];
  
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
  

    return [self.myRooms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomRow" forIndexPath:indexPath];
  if ([self.fetchMyResults.sections count] !=0) {
    // Configure the cell...
    Room *theRoom = self.myRooms[indexPath.row];
    cell.textLabel.text = @("%@", theRoom.number);
    
    return cell;
  } else {

  
    
    return cell;
  }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [theRoom.hotel.text];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  
  
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

@end
