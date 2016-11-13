//
//  FromDateViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "DateViewController.h"
#import "AppDelegate.h"
#import "AvailabilityTableViewController.h"

@interface DateViewController ()
@property (strong, nonatomic) UIDatePicker *myFromDatePicker;
@property (strong, nonatomic) UIDatePicker *myToDatePicker;
@property (strong, nonatomic) AppDelegate *myAppDelegate;
@property (strong, nonatomic) UILabel *myPickerToLabel;
@property (strong, nonatomic) UILabel *myPickerFromLabel;

@end

@implementation DateViewController


-(void)loadView {
  UIView *myRootView = [[UIView alloc] init];
  
  myRootView.backgroundColor = [UIColor blackColor];
  
  // instantiate date Pickers. Add the objects.  Remove autoconstraints.
  self.myFromDatePicker = [[UIDatePicker alloc] init];
  self.myFromDatePicker.datePickerMode = UIDatePickerModeDate;
  self.myFromDatePicker.backgroundColor = [UIColor blackColor];
  
  self.myToDatePicker = [[UIDatePicker alloc] init];
  self.myToDatePicker.datePickerMode = UIDatePickerModeDate;
  self.myToDatePicker.backgroundColor = [UIColor blackColor];
  
  [myRootView addSubview:self.myFromDatePicker];
  [myRootView addSubview:self.myToDatePicker];
  [self.myFromDatePicker setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.myToDatePicker setTranslatesAutoresizingMaskIntoConstraints:false];
  
  // add label for picker.
  self.myPickerFromLabel = [[UILabel alloc] init];
  self.myPickerFromLabel.text = @"Please select the dates for your stay.";
  self.myPickerFromLabel.textColor = [UIColor whiteColor]; 
  [self.myPickerFromLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [myRootView addSubview:self.myPickerFromLabel];
  
  // add button for date selection.
  self.myDateSelectionButton = [[UIButton alloc] init];
  [self.myDateSelectionButton setTranslatesAutoresizingMaskIntoConstraints:false];
  // add UI to selection button.
  [self.myDateSelectionButton setTitle:@"Make Reservation" forState:UIControlStateNormal];
  [self.myDateSelectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [myRootView addSubview:self.myDateSelectionButton];
  // add all views to dictionary and constrain the container to the view(s).
  NSDictionary *views = @{@"fromDatePicker" : self.myFromDatePicker,
                          @"toDatePicker" : self.myToDatePicker,
                          @"pickerLabel" : self.myPickerFromLabel,
                          @"dateButton" : self.myDateSelectionButton};
  //po [[UIWindow keyWindow] _autolayoutTrace];
  [self addConstraintsToRootView:myRootView forViews:views];
  
  // set the views.
  self.view = myRootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // date picker font adjustments found here:
  [self.myFromDatePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
  [self.myToDatePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
  SEL selector = NSSelectorFromString( @"setHighlightsToday:" );
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature :
                              [UIDatePicker
                               instanceMethodSignatureForSelector:selector]];
  BOOL no = NO;
  [invocation setSelector:selector];
  [invocation setArgument:&no atIndex:2];
  [invocation invokeWithTarget:self.myFromDatePicker];
  [invocation invokeWithTarget:self.myToDatePicker];
  
  // pass in button eventController.
  [self.myDateSelectionButton addTarget:self
                                 action:@selector(endPressed)
                       forControlEvents:UIControlEventTouchUpInside];
  
}

- (void) viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  self.myDateSelectionButton = nil;
}


/**
 UI button pressed inticating that the user has selected their to - from dates and wishes to view available dates.
 */
-(void) endPressed {

  NSDate *endDate = self.myToDatePicker.date;
  NSDate *startDate = self.myFromDatePicker.date;
  
#if DEBUG 
  NSLog(@"DVC: The Start date is %@", startDate);
  NSLog(@"DVC: The End date is %@", endDate);
#endif

  /*
   Set comparator where if the startDate is equal to or greater than the end date, the alert window is shown.  Else the user is allowed to proceed to the Availability VC.
   */
  if ([endDate compare:startDate] > 0) {
  AvailabilityTableViewController *availablityVC = [[AvailabilityTableViewController alloc] init];
  availablityVC.myFromDate = startDate;
  availablityVC.myToDate = endDate;
  // push on new VC.
  [self.navigationController pushViewController:availablityVC animated:true];
  } else {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:@"Please select a start date that proceeds the end date."
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                 NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


-(void) addConstraintsToRootView: (UIView *)rootView forViews:(NSDictionary *)views {

  // label X axis constraints.
  NSLayoutConstraint *pickerLabelY = [NSLayoutConstraint constraintWithItem:self.myPickerFromLabel
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:rootView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0
                                                                   constant:0.0];
  
  // VC Y axis constraints
  NSString *yAxisLayout = [NSString stringWithFormat:@"V:|-70-[pickerLabel]-2-[fromDatePicker]-0-[toDatePicker]-2-[dateButton]"];
  NSArray *viewControllerY = [NSLayoutConstraint constraintsWithVisualFormat:yAxisLayout
                                                                     options:NSLayoutFormatAlignAllCenterX
                                                                     metrics:nil
                                                                       views:views];
  // add constraints
  [rootView addConstraints: viewControllerY];
  [rootView addConstraint:pickerLabelY];
  
  // date button constraints.
  NSLayoutConstraint *dateButtonX = [NSLayoutConstraint constraintWithItem:self.myDateSelectionButton
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:rootView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.0
                                                                  constant:0.0];
  // add label to date button.
  [rootView addConstraint:dateButtonX];
}

@end
