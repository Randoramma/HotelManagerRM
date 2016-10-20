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
extern NSString* const TITLE_FONT;

extern const CGFloat TABLE_ROW_HEIGHT;
//Core Data constants.
extern NSString * const URL_PATH_FOR_MOMD;
extern NSString * const URL_PATH_FOR_SQLITE_DB; 

//Core Data entities.  
extern NSString * const GUEST_ENTITY;
extern NSString * const HOTEL_ENTITY;
extern NSString * const ROOM_ENTITY;
extern NSString * const RESERVATION_ENTITY; 
@interface Constants : NSObject
@end
