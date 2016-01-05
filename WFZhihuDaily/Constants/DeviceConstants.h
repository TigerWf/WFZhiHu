//
//  DeviceConstants.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#ifndef DeviceConstants_h
#define DeviceConstants_h

#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenBounds [UIScreen mainScreen].bounds

#define kMaxMovingOffsetX kScreenWidth * 0.2

#define TopMinY 64.f
#define kDrawerRatio 0.6
#define kNavigationBarColor [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:1.f];
#define kAppdelegate (AppDelegate *)[UIApplication sharedApplication].delegate;

#endif /* DeviceConstants_h */
