//
//  Constants.m
//  HotelManagerRM
//
//  Created by Randy McLain on 6/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "Constants.h"

@implementation Constants : NSObject 

const CGFloat TITLE_LABEL_HEIGHT = 20;
const CGFloat TITLE_LABEL_WIDTH = 100;
const CGFloat TITLE_FONT_SIZE = 15;

const CGFloat NAV_BAR_FONT_SIZE = 18;
NSString* const TITLE_FONT = @"Helvetica Neue";

const CGFloat TABLE_ROW_HEIGHT = 100;

// cell Identifiers
NSString * const OPTION_CELL_ID = @"optionCell";
NSString * const HOTEL_CELL_ID = @"hotelCell";

//Core Data constants.
NSString * const URL_PATH_FOR_MOMD = @"HotelManagerRM";
NSString * const URL_PATH_FOR_SQLITE_DB = @"HotelManagerRM.sqlite";

//Core Data entities.  
NSString * const GUEST_ENTITY = @"Guest";
NSString * const HOTEL_ENTITY = @"Hotel";
NSString * const ROOM_ENTITY = @"Room";
NSString * const RESERVATION_ENTITY = @"Reservation";

//HotelImages.
NSString * const OK_HOTEL_IMAGE_TVC = @"OKRoomImage";
NSString * const DECENT_HOTEL_IMAGE_TVC = @"DecentInnRoomImage";
NSString * const SOLID_HOTEL_IMAGE_TVC = @"SolidStayRoomImage";
NSString * const FANCY_HOTEL_IMAGE_TVC = @"FancyEstateRoomImage";

//Hotel Names.
NSString * const FANCY_HOTEL_NAME = @"Fancy Estates";
NSString * const SOLID_HOTEL_NAME = @"Solid Stay";
NSString * const DECENT_HOTEL_NAME = @"Decent Inn";
NSString * const OK_HOTEL_NAME = @"Okay Motel";

NSString * const CURRENT_MEMBER_COUNT = @"Member Count"; 

@end
