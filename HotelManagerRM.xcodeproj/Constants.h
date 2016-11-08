//
//  Constants.h
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const CGFloat TITLE_LABEL_HEIGHT;
extern const CGFloat TITLE_LABEL_WIDTH;
extern const CGFloat TITLE_FONT_SIZE;

extern const CGFloat NAV_BAR_FONT_SIZE;
extern NSString * const TITLE_FONT;

extern const CGFloat TABLE_ROW_HEIGHT;
//Core Data constants.
extern NSString * const URL_PATH_FOR_MOMD;
extern NSString * const URL_PATH_FOR_SQLITE_DB; 

//Core Data entities.  
extern NSString * const GUEST_ENTITY;
extern NSString * const HOTEL_ENTITY;
extern NSString * const ROOM_ENTITY;
extern NSString * const RESERVATION_ENTITY;
// TVC cell id's.
extern NSString * const OPTION_CELL_ID;
extern NSString * const HOTEL_CELL_ID;
extern NSString * const ROOM_CELL_ID;

//Hotel TVC images.
extern NSString * const OK_HOTEL_IMAGE_TVC;
extern NSString * const DECENT_HOTEL_IMAGE_TVC;
extern NSString * const SOLID_HOTEL_IMAGE_TVC;
extern NSString * const FANCY_HOTEL_IMAGE_TVC;

//Hotel Names.
extern NSString * const FANCY_HOTEL_NAME;
extern NSString * const SOLID_HOTEL_NAME;
extern NSString * const DECENT_HOTEL_NAME;
extern NSString * const OK_HOTEL_NAME;

extern NSString * const CURRENT_MEMBER_COUNT; 

static NSString * const kCDDataBaseManagerErrorDomain;

extern NSString * const FRC__HOTEL_CACHE_NAME;
extern NSString * const FRC__HOTEL_SORT_DESCRIPTOR_KEY;

extern NSString * const FRC_ROOM_SORT_DESCRIPTOR_KEY;
extern NSString * const FRC_AVAILABILITY_CACHE_NAME;
extern NSString * const FRC_GUEST_LIST_CACHE_NAME;

@interface Constants : NSObject

@end
