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
#import "Hotel.h"

@interface HotelViewController () <UITableViewDataSource>

@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSArray *myHotels;


@end

@implementation HotelViewController

-(void)loadView {
  // build out the root view
  UIView *theRootView = [[UIView alloc] init];
  // add the tableView
  self.myTableView = [[UITableView alloc] init];
  [self.myTableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [theRootView addSubview:self.myTableView];
  // set the rootVC as the view
  self.view = theRootView;
  // call custom method to constrain the table view into the rootVC.
  [self addConstraintsToRootView:theRootView withViews:@{@"tableView" : self.myTableView}];
  
} // loadView

-(void)viewDidLoad {
  [super viewDidLoad];
  // declare this VC as the delegate of the AppDelegate class.
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
  // fetch the data to build out the VC
  NSFetchRequest *theHotelFetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  // add the Error
  NSError *theHotelFetchError;
  
  self.myHotels = [context executeFetchRequest:theHotelFetch error:&theHotelFetchError];
  
  if (theHotelFetchError) {
    NSLog(@"%@", theHotelFetchError.localizedDescription);
  }
  
  [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];
  self.myTableView.dataSource = self;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.myHotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
  
  Hotel *theHotel = self.myHotels[indexPath.row];
  theCell.textLabel.text = theHotel.name;
  
  return theCell;
}

-(void) addConstraintsToRootView:(UIView *)theRootView withViews:(NSDictionary *)views {
  
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
    [theRootView addConstraints:tableViewVertical];
  NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];

  [theRootView addConstraints:tableViewHorizontal];
  
  
}


@end
