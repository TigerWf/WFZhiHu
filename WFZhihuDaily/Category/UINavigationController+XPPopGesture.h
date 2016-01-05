//
//  UINavigationController+XPPopGesture.h
//  Test
//
//  Created by xiupintech on 15/7/24.
//  Copyright (c) 2015年 L. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 *  自定义pan手势
 */
@interface XPPanGestureRecognizer : UIPanGestureRecognizer

@property (strong, nonatomic) UIEvent *event;

@end


@class XPPanGestureRecognizer;
/**
 *  导航控制器类别
 */
@interface UINavigationController (XPPopGesture)

@property (nonatomic, strong, readonly) XPPanGestureRecognizer *xp_fullscreenPopGestureRecognizer;

@property (nonatomic, assign) BOOL xp_viewControllerBasedNavigationBarAppearanceEnabled;

@property (nonatomic, assign) BOOL showFlag;//显示在最上面的viewcontroller 缺省为no

@end


/**
 *  控制器类别
 */
@interface UIViewController (XPPopGesture)

/**
 *  如果为yes 则禁止左滑返回 默认不禁止
 */
@property (nonatomic, assign) BOOL xp_interactivePopDisabled;


/**
 *  是否隐藏导航栏  默认为NO 不隐藏
 */
@property (nonatomic, assign) BOOL xp_prefersNavigationBarHidden;

@property (nonatomic, assign) CGFloat xp_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
