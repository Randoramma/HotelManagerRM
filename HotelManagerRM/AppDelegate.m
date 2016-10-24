//
//  AppDelegate.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "FromDateViewController.h"
#import "LoadViewControllerTableViewController.h"
#import "Constants.h"

@interface AppDelegate ()
@property (readwrite, strong, nonatomic) HotelService *hotelService;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyAndVisible];
  // initialize Core data Stack and HotelService.
  [self setMyPersistenceController:[[CDPersistenceController alloc] initWithCallback:^{
    [self completeUserInterface];
  }]];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  [[self myPersistenceController] save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  [[self myPersistenceController] save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [[self myPersistenceController] save];
}
   
-(void) completeUserInterface {
  
  
  self.hotelService = [[HotelService alloc] initWithCoreDataStack:_myPersistenceController];
  
  //FromDateViewController *fromDateVC = [[FromDateViewController alloc] init];
  LoadViewControllerTableViewController *loadVC = [[LoadViewControllerTableViewController alloc]
                                                   initWithAppDelegate:self];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loadVC];
  self.window.rootViewController = navController;
  // must include to test for initial seeding of objects if applicable.
 // [_hotelService seedWithJSON];
  
  [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor whiteColor]];
  
  //navigation bar setup
  // Navigation bar appearance (background and title)
  NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"Helvetica Neue" size:NAV_BAR_FONT_SIZE], NSFontAttributeName, nil];
  
  [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
  
  // status bar setup
  // Set "View controller-based status bar appearance” to NO in your info.list file;
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 
}
@end
