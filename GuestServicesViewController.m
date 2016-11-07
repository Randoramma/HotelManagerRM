//
//  GuestServicesViewController.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/10/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "GuestServicesViewController.h"
#import "GuestReservationsTableViewController.h"
#import "Guest+CoreDataProperties.h"

@interface GuestServicesViewController () <UITextFieldDelegate>
@property (strong, nonatomic) UILabel *myGuestIntro;
@property (strong, nonatomic) UILabel *myFirstNameLabel;
@property (strong, nonatomic) UILabel *myLastNameLabel;

@property (strong, nonatomic) NSString *myFirstName;
@property (strong, nonatomic) NSString *myLastName;

@end

@implementation GuestServicesViewController

-(void)loadView {
  UIView *myRootView = [[UIView alloc] init];
  myRootView.backgroundColor = [UIColor blackColor];
  
  
  self.myGuestIntro = [[UILabel alloc] init];
  [self.myGuestIntro setTextColor:[UIColor whiteColor]];
  [myRootView addSubview:self.myGuestIntro];
  [self.myGuestIntro setTranslatesAutoresizingMaskIntoConstraints:false];
  
  self.myFirstNameLabel = [[UILabel alloc] init];
  [self.myFirstNameLabel setTextColor:[UIColor whiteColor]];
  [myRootView addSubview:self.myFirstNameLabel];
  [self.myFirstNameLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  
  self.myLastNameLabel = [[UILabel alloc] init];
  [self.myLastNameLabel setTextColor:[UIColor whiteColor]];
  [myRootView addSubview:self.myLastNameLabel];
  [self.myLastNameLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  
  self.myFirstNameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 18)];
  [self.myFirstNameField setTextColor: [UIColor whiteColor]];
  self.myFirstNameField.borderStyle = UITextBorderStyleRoundedRect;
  self.myFirstNameField.font = [UIFont systemFontOfSize:15];
  self.myFirstNameField.placeholder = @"enter first name here";
  self.myFirstNameField.backgroundColor = [UIColor colorWithRed:83/255.0f green:78/255.0f blue:78/255.0f alpha:1.0f];
  self.myFirstNameField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.myFirstNameField.keyboardType = UIKeyboardTypeDefault;
  self.myFirstNameField.returnKeyType = UIReturnKeyDone;
  self.myFirstNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.myFirstNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  [myRootView addSubview:self.myFirstNameField];
  [self.myFirstNameField setTranslatesAutoresizingMaskIntoConstraints:false];
  
  self.myLastNameField = [[UITextField alloc] init];
  [self.myLastNameField setTextColor:[UIColor whiteColor]];
  self.myLastNameField.borderStyle = UITextBorderStyleRoundedRect;
  self.myLastNameField.font = [UIFont systemFontOfSize:15];
  self.myLastNameField.placeholder = @"enter first name here";
  self.myLastNameField.backgroundColor = [UIColor colorWithRed:83/255.0f green:78/255.0f blue:78/255.0f alpha:1.0f];
  self.myLastNameField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.myLastNameField.keyboardType = UIKeyboardTypeDefault;
  self.myLastNameField.returnKeyType = UIReturnKeyDone;
  self.myLastNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.myLastNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  [myRootView addSubview:self.myLastNameField];
  [self.myLastNameField setTranslatesAutoresizingMaskIntoConstraints:false];
  
  self.myButton = [[UIButton alloc] init];
  [self.myButton setTitle:@"Next" forState:UIControlStateNormal];
  [self.myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [myRootView addSubview:self.myButton];
  [self.myButton setTranslatesAutoresizingMaskIntoConstraints:false];
  
  NSDictionary *views = @{@"guestIntro" : self.myGuestIntro, @"firstNameLabel" : self.myFirstNameLabel, @"lastNameLabel" : self.myLastNameLabel, @"firstNameField": self.myFirstNameField, @"lastNameField" : self.myLastNameField, @"button"  : self.myButton};
  [self addConstraintsToRootView:myRootView forViews:views];
  // set the views.
  self.view = myRootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.myGuestIntro.text = @"Welcome to guest services!";
  self.myFirstNameLabel.text = @"Please enter your first name.";
  self.myLastNameLabel.text = @"Please enter your last name.";
  
  // set textfield delegates
  self.myFirstNameField.delegate = self;
  self.myLastNameField.delegate = self;
  
  
}

#pragma mark - Text Field Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView {
  
  return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField {
  
  if ([textField isEqual:self.myFirstNameField]) {
    if (self.myFirstNameField.text.length != 0) {
      self.myFirstName = self.myFirstNameField.text;
    }
  } else if ([textField isEqual:self.myLastNameField]) {
    if (self.myLastNameField.text.length != 0) {
      self.myLastName = self.myLastNameField.text;
    }
  } else {
    
  }
  return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  if (textField == self.myFirstNameField) {
    [self.myLastNameField becomeFirstResponder];
  }
  return true;
}




/* Will proceed to the Guest reservation table view controller to display a list of the guest reservations this guest currently has
 based on the four different hotels.
 */

#pragma mark - Layout Constraints
-(void) addConstraintsToRootView: (UIView *)rootView forViews:(NSDictionary *)views {
  //myGuestIntro constraints.
  NSLayoutConstraint *fromGuestIntroX = [NSLayoutConstraint constraintWithItem:self.myGuestIntro attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  
  NSLayoutConstraint *fromGuestIntroY = [NSLayoutConstraint constraintWithItem:self.myGuestIntro attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-50.0];
  // add array of constraints.
  [rootView addConstraints:@[fromGuestIntroX, fromGuestIntroY]];
  // firstNameLabel
  NSArray *firstNameLabelY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[guestIntro]-20-[firstNameLabel]"  options:0 metrics:nil views:views];
  [rootView addConstraints:firstNameLabelY];
  NSLayoutConstraint *firstNameLabelX =  [NSLayoutConstraint constraintWithItem:(self.myFirstNameLabel) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [rootView addConstraint:firstNameLabelX];
  // firstNameField
  NSArray *firstNameFieldY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstNameLabel]-20-[firstNameField]"  options:0 metrics:nil views:views];
  [rootView addConstraints:firstNameFieldY];
    NSLayoutConstraint *firstNameFieldX =  [NSLayoutConstraint constraintWithItem:(self.myFirstNameField) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [rootView addConstraint:firstNameFieldX];
  
  NSLayoutConstraint *firstNameFieldWidth = [NSLayoutConstraint constraintWithItem:(self.myFirstNameField)
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:300];
  [rootView addConstraint:firstNameFieldWidth];
  
  // lastNameLabel
  NSArray *lastNameLabelY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstNameField]-20-[lastNameLabel]"  options:0 metrics:nil views:views];
  [rootView addConstraints:lastNameLabelY];
  NSLayoutConstraint *lastNameLabelX =  [NSLayoutConstraint constraintWithItem:(self.myLastNameLabel) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [rootView addConstraint:lastNameLabelX];
  //lastNameField
  NSArray *lastNameFieldY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastNameLabel]-20-[lastNameField]"  options:0 metrics:nil views:views];
  [rootView addConstraints:lastNameFieldY];
  NSLayoutConstraint *lastNameFieldX =  [NSLayoutConstraint constraintWithItem:(self.myLastNameField) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
  [rootView addConstraint:lastNameFieldX];
  
  NSLayoutConstraint *lastNameFieldWidth = [NSLayoutConstraint constraintWithItem:(self.myLastNameField)
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:300];
  [rootView addConstraint:lastNameFieldWidth];
  
  
  
  // button
  NSLayoutConstraint *buttonX =  [NSLayoutConstraint constraintWithItem:(self.myButton) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [rootView addConstraint:buttonX];
  NSArray *buttonY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastNameField]-[button]" options:0 metrics:nil views:views];
  [rootView addConstraints:buttonY];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
}

@end
