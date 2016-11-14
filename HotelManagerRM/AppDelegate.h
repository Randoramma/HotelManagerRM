//
//  AppDelegate.h
//  HotelManagerRM
//
//  Created by Randy McLain on 5/4/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CDPersistenceController.h"
#import "HotelService.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, atomic) CDPersistenceController *myPersistenceController;
@property (strong, nonatomic) NSDateFormatter *myDateFormatter;
// post SRP methods / properties
@end

