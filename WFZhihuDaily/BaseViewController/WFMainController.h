//
//  WFMainController.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFLeftController.h"

@interface WFMainController : UIViewController

/**
 *  根视图控制器
 */
@property(nonatomic,strong) NSMutableArray   *controllers;//控制器数组
@property(nonatomic,assign) BOOL isFold;//是否已经展开

/**
 *  打开抽屉
 */
- (void)showDrawerList;


/**
 *  隐藏抽屉
 */
- (void)hideDrawerList;

/**
 *  初始化main viewcontroller
 *
 *  @param leftController 左侧菜单controller
 *  @param controllers    右侧控制器数组
 *
 *  @return id
 */
- (id)initWithLeftController:(WFLeftController *)leftController
              andControllers:(NSMutableArray *)controllers;



@end
