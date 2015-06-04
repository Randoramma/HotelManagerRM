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
  CoreDataStack *coreDataStack = [[CoreDataStack alloc] init];
  self.hotelService = [[HotelService alloc] initCoreDataStack:coreDataStack]; 

  //FromDateViewController *fromDateVC = [[FromDateViewController alloc] init];
  LoadViewControllerTableViewController *loadVC = [[LoadViewControllerTableViewController alloc] init];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loadVC];
  self.window.rootViewController = navController;
  // must include to test for initial seeding of objects if applicable.
  [coreDataStack seedWithJSON];
  
  //navigation bar setup
  // Navigation bar appearance (background and title)
  
  [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],  [UIFont fontWithName:@"Helvetica Neue" size:NAV_BAR_FONT_SIZE], NSFontAttributeName, nil]];
  
  [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
  [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
   
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  // Saves changes in the application's managed object context before the application terminates.
  [self.hotelService saveContext];
}
@end
