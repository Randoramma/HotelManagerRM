//
//  AppDelegate.m
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "AppDelegate.h"
#import "DateViewController.h"
#import "LoadViewControllerTableViewController.h"
#import "Constants.h"

@interface AppDelegate ()

-(void) completeUserInterface;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self setMyPersistenceController:[[CDPersistenceController alloc] initWithCompletion:^(BOOL succeeded, NSError *error) {
        
#if DEBUG
        if (succeeded) {
        NSLog(@"setup of the stack was successful, with error %@", error.description);
        } else {
        NSLog(@"setup of the stack failed, with error %@", error.description);    
        }

        NSLog(@"theMainMoc (appDelegate)  identity is %@", self.myPersistenceController.theMainMOC.description);

#endif
    }]];
    
    [self completeUserInterface];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[self myPersistenceController] saveDataWithReturnBlock:^(BOOL succeeded, NSError *error) {
        
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[self myPersistenceController] saveDataWithReturnBlock:^(BOOL succeeded, NSError *error) {
        
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[self myPersistenceController] saveDataWithReturnBlock:^(BOOL succeeded, NSError *error) {
        
    }];
}

-(void) completeUserInterface {
    
    LoadViewControllerTableViewController *loadVC = [[LoadViewControllerTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loadVC];
    self.window.rootViewController = navController;
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
