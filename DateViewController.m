//
//  FromDateViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/7/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityTableViewController.h"

@interface DateViewController ()


@end

@implementation DateViewController


-(void)loadView {
    UIView *myRootView = [[UIView alloc] init];
    
    myRootView.backgroundColor = [UIColor blackColor];
    
    // instantiate date Pickers. Add the objects.  Remove autoconstraints.
    self.myFromDatePicker = [[UIDatePicker alloc] init];
    self.myFromDatePicker.backgroundColor = [UIColor blackColor];
    
    self.myToDatePicker = [[UIDatePicker alloc] init];
    self.myToDatePicker.backgroundColor = [UIColor blackColor];
    
    [myRootView addSubview:self.myFromDatePicker];
    [myRootView addSubview:self.myToDatePicker];
    [self.myFromDatePicker setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.myToDatePicker setTranslatesAutoresizingMaskIntoConstraints:false];
    
    // add label for picker.
    self.myPickerLabel = [[UILabel alloc] init];
    [self.myPickerLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    
    [myRootView addSubview:self.myPickerLabel];
    
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
                            @"pickerLabel" : self.myPickerLabel,
                            @"dateButton" : self.myDateSelectionButton};
    //po [[UIWindow keyWindow] _autolayoutTrace]);
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
    [self.myDateSelectionButton addTarget:self action:@selector(endPressed) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.myDateSelectionButton = nil; 
}

-(void) endPressed {
    
    NSDate *myEndDate = self.myToDatePicker.date;
    NSDate *myStartDate = self.myFromDatePicker.date;
    
    AvailabilityTableViewController *availablityVC = [[AvailabilityTableViewController alloc] init];
    availablityVC.fromDate = myStartDate;
    availablityVC.toDate = myEndDate;
    // push on new VC.
    [self.navigationController pushViewController:availablityVC animated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) addConstraintsToRootView: (UIView *)rootView forViews:(NSDictionary *)views {
    //datePicker constraints.
    NSLayoutConstraint *fromDatePickerCenterX = [NSLayoutConstraint constraintWithItem:self.myFromDatePicker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *toDatePickerCenterX = [NSLayoutConstraint constraintWithItem:self.myToDatePicker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    [rootView addConstraints:@[fromDatePickerCenterX, toDatePickerCenterX]];

    // label constraints.
    NSLayoutConstraint *pickerLabelX = [NSLayoutConstraint constraintWithItem:self.myPickerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSArray *pickerLabelY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[pickerLabel]-20-[fromDatePicker]-20-[toDatePicker]"
                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                    metrics:nil
                                                                      views:views];
    // add constraints
    [rootView addConstraint:pickerLabelX];
    [rootView addConstraints:pickerLabelY];
    
    
    // date button constraints.
    NSLayoutConstraint *dateButtonX = [NSLayoutConstraint constraintWithItem:self.myDateSelectionButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSArray *dateButtonY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[toDatePicker]-20-[dateButton]" options:0 metrics:nil views:views];
    // add label to date button.
    [rootView addConstraint:dateButtonX];
    [rootView addConstraints:dateButtonY];
    
}

@end
