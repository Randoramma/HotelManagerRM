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
#import "GuestListTableViewController.h"

@interface GuestServicesViewController () <UITextFieldDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UILabel *myGuestIntro;
@property (strong, nonatomic) UILabel *myFirstNameLabel;
@property (strong, nonatomic) UILabel *myLastNameLabel;
@property (strong, nonatomic) UIScrollView *myScrollView;
@property (strong, nonatomic) NSString *myFirstName;
@property (strong, nonatomic) NSString *myLastName;
@property (strong, nonatomic) NSDictionary *myMetrics;
@property (assign) int viewHeight;
@property (assign) int viewWidth;


@end

/**
 *  View Controller providing access to a list of guests based on first or last name input (list generated on next VC (GuestReservationsTVC).
 */
@implementation GuestServicesViewController

int TEXT_FIELD_HEIGHT = 18;
int TEXT_FIELD_WIDTH = 225;
long OFFSET_FOR_KEYBOARD = 00.0;


/**
 *  Aspect prior to the view being loaded from Interface Builder. A ScrollView was required as the root view to support the choice of using
 *  UITextFields to input the guest credentials. In order for the keyboard to not superimpose over a textfield that may be located on the bottom of the screen
 *  a scroll view was required so the view could raise above the view.  When using a scroll view it is important to rememver the that the all the space in a
 *  height and width must be accounted for using constraints.
 */
-(void)loadView {
  
  CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
  [self setViewHeight: [UIScreen mainScreen].bounds.size.height];
  [self setViewWidth:[UIScreen mainScreen].bounds.size.width];
  // values to build out dynamic spacing for the view to account for varying screen sizes.
  NSNumber * topWelcomeSpace = [NSNumber numberWithInt:(_viewWidth *(.33))];
  NSNumber * bottomWelcomeSpace = [NSNumber numberWithInt:20];
  NSNumber * sideSpace = [NSNumber numberWithInt: (_viewWidth *.5) - (TEXT_FIELD_WIDTH *.5)];
  
  _myMetrics = @{@"TWS": topWelcomeSpace, @"BWS": bottomWelcomeSpace, @"SS": sideSpace};
  
  UIView *myRootView = [[UIView alloc] initWithFrame:frame];
  myRootView.backgroundColor = [UIColor blackColor];
  [myRootView setTranslatesAutoresizingMaskIntoConstraints:FALSE];
  self.view = myRootView;
  
  // Create the scroll view and the image view.
  self.myScrollView  = [[UIScrollView alloc] initWithFrame:frame];
  [self.myScrollView setDelegate:self];
  [self.myScrollView  setBackgroundColor:[UIColor blackColor]];
  [myRootView addSubview:self.myScrollView ];
  
  // Set the translatesAutoresizingMaskIntoConstraints to NO so that the views autoresizing mask is not translated into auto layout constraints.
  [self.myScrollView setTranslatesAutoresizingMaskIntoConstraints:FALSE];
  
  // Set the constraints for the scroll view and the image view.
  NSDictionary *viewsDictionary = @{@"scrollView": self.myScrollView};
  [myRootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
  
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
  
  CGRect TEXT_FIELD_RECT = CGRectMake(0, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT);
  self.myFirstNameField = [[UITextField alloc] initWithFrame:TEXT_FIELD_RECT];
  
  [self textFieldInitializer:self.myFirstNameField];
  [myRootView addSubview:self.myFirstNameField];
  
  self.myLastNameField = [[UITextField alloc] initWithFrame:TEXT_FIELD_RECT];
  [self textFieldInitializer:self.myLastNameField];
  [myRootView addSubview:self.myLastNameField];
  
  self.myButton = [[UIButton alloc] init];
  [self.myButton setTitle:@"Next" forState:UIControlStateNormal];
  [self.myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [myRootView addSubview:self.myButton];
  [self.myButton setTranslatesAutoresizingMaskIntoConstraints:false];
  
  NSDictionary *views = NSDictionaryOfVariableBindings(_myGuestIntro, _myFirstNameLabel, _myLastNameLabel, _myFirstNameField, _myLastNameField, _myButton);
  [self addConstraintsToRootView:myRootView forViews:views];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.myGuestIntro.text = @"Welcome to guest services!";
  self.myFirstNameLabel.text = @"Please enter your first name.";
  self.myLastNameLabel.text = @"Please enter your last name.";
  
  // set textfield delegates
  [self.myFirstNameField setPlaceholder:@"enter first name here."];
  [self.myFirstNameField setPlaceholder:@"enter last name here."];
  self.myFirstNameField.delegate = self;
  self.myLastNameField.delegate = self;
  
  // UIButton event controller
  [self.myButton addTarget:self
                    action:@selector(nextPress)
          forControlEvents:UIControlEventTouchUpInside];
}

-(void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
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

-(void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSLog(@"View Appeared.");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  if (textField == self.myFirstNameField) {
    [self.myLastNameField becomeFirstResponder];
  }
  return true;
}

/**
 *  Method animates the current view up and out of the way of the textfield.
 */
-(void) keyboardWillShow {
  if(self.view.frame.origin.y >= 0) {
    [self setViewMovedUp:YES];
  } else if (self.view.frame.origin.y < 0) {
    [self setViewMovedUp:NO];
  }
}

/**
 *  Method animates the current view up and out of the way of the textfield.
 */
-(void) keyboardWillHide {
  if(self.view.frame.origin.y >= 0) {
    [self setViewMovedUp:YES];
  } else if (self.view.frame.origin.y < 0) {
    [self setViewMovedUp:NO];
  }
}

/**
 *  Method to move the view up/down whenever the keyboard is shown/dismissed
 *
 *  @param movedUp BOOL
 */
-(void)setViewMovedUp:(BOOL)movedUp
{
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.3]; // if you want to slide up the view
  
  CGRect rect = self.view.frame;
  if (movedUp)
  {
    // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
    // 2. increase the size of the view so that the area behind the keyboard is covered up.
    rect.origin.y -= OFFSET_FOR_KEYBOARD;
    rect.size.height += OFFSET_FOR_KEYBOARD;
  }
  else
  {
    // revert back to the normal state.
    rect.origin.y += OFFSET_FOR_KEYBOARD;
    rect.size.height -= OFFSET_FOR_KEYBOARD;
  }
  self.view.frame = rect;
  
  [UIView commitAnimations];
}

/* Will proceed to the Guest reservation table view controller to display a list of the guest reservations this guest currently has
 based on the four different hotels.
 */

#pragma mark - Layout Constraints
-(void) addConstraintsToRootView: (UIView *)rootView forViews:(NSDictionary *)views {
  //myGuestIntro constraints.
  //  NSLayoutConstraint *fromGuestIntroX = [NSLayoutConstraint constraintWithItem:self.myGuestIntro attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  //
  
  NSArray *fromGuestIntroX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-SS-[_myGuestIntro]-SS-|" options:0 metrics:_myMetrics views:views];
  
  NSArray *buttonX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-SS-[_myButton]-SS-|" options:0 metrics:_myMetrics views:views];
  
  NSArray *firstNameLabelX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-SS-[_myFirstNameLabel]-SS-|" options:0 metrics:_myMetrics views:views];
  
  NSArray *lastNameLabelX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-SS-[_myLastNameLabel]-SS-|" options:0 metrics:_myMetrics views:views];
  
  NSArray *firstNameFieldX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-SS-[_myFirstNameField]-SS-|" options:0 metrics:_myMetrics views:views];
  
  NSArray *lastNameFieldX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-SS-[_myLastNameField]-SS-|" options:0 metrics:_myMetrics views:views];
  
  
  //  NSLayoutConstraint *buttonX =  [NSLayoutConstraint constraintWithItem:(self.myButton) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  //
  //  NSLayoutConstraint *firstNameLabelX =  [NSLayoutConstraint constraintWithItem:(self.myFirstNameLabel) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  //
  //  NSLayoutConstraint *lastNameLabelX =  [NSLayoutConstraint constraintWithItem:(self.myLastNameLabel) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  //
  //  NSLayoutConstraint *firstNameFieldX =  [NSLayoutConstraint constraintWithItem:(self.myFirstNameField) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  //
  //  NSLayoutConstraint *lastNameFieldX =  [NSLayoutConstraint constraintWithItem:(self.myLastNameField) attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  //
  
  
  [rootView addConstraints:fromGuestIntroX];
  [rootView addConstraints:buttonX];
  [rootView addConstraints:firstNameLabelX];
  [rootView addConstraints: lastNameLabelX];
  [rootView addConstraints:firstNameFieldX];
  [rootView addConstraints:lastNameFieldX];
  
  NSArray *theYAxisConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-TWS-[_myGuestIntro]-BWS-[_myFirstNameLabel]-BWS-[_myFirstNameField]-BWS-[_myLastNameLabel]-BWS-[_myLastNameField]-[_myButton]-|" options:0 metrics:_myMetrics views:views];
  
  [rootView addConstraints:theYAxisConstraints];
  
}

/**
 *  Initializer for textfields populating all properties required for this UITextView.
 *  BoarderStyle
 *  Font
 *  BackgroundColor
 *  Keyboard type, and formatting.
 *  Content alignment
 *  Turn off autoLayout resizing masks.
 *
 *  @param theTextField formatted UITextField.
 */
-(void) textFieldInitializer:(UITextField *)theTextField {
  
  [theTextField setTextColor: [UIColor whiteColor]];
  theTextField.borderStyle = UITextBorderStyleRoundedRect;
  theTextField.font = [UIFont systemFontOfSize:15];
  theTextField.placeholder = @"enter name here";
  theTextField.backgroundColor = [UIColor colorWithRed:83/255.0f green:78/255.0f blue:78/255.0f alpha:1.0f];
  theTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  theTextField.keyboardType = UIKeyboardTypeDefault;
  theTextField.returnKeyType = UIReturnKeyDone;
  theTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  theTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  [theTextField setTranslatesAutoresizingMaskIntoConstraints:false];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - UIButton Action Delegates.
/**
 *  Method aggregating the data from information entered within the fields, fetching the data, and passing to the next VC.
 */
-(void) nextPress {
  
  // pass the first and last names to the GuestListTVC.
  
  if (self.myFirstName.length > 0 || self.myFirstName.length >0) {
    GuestListTableViewController * GuestLTVC = [[GuestListTableViewController alloc] init];
    GuestLTVC.myGuestLastName = self.myLastName;
    GuestLTVC.myGuestFirstName = self.myFirstName;
    
    [self.navigationController pushViewController:GuestLTVC animated:TRUE];
  } else {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:@"Please enter a guest name in the fields."
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



#pragma mark - Core Data Fetches






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
}

@end
