//
//  WFBaseController.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFRefreshView.h"

/**
 *  父视图控制器
 */
@interface WFBaseController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,assign) BOOL showFlag;//显示在最上面的viewcontroller 缺省为no

@property(nonatomic,assign) BOOL needUpdate;//是否需要更新，缺省为no

@property(nonatomic,assign) BOOL isLoading;

/**
 *  导航栏（假）
 */
@property(nonatomic,strong)  UIView *navigationBar;

/**
 *  状态栏（假）
 */
@property(nonatomic,strong)  UIView *statusBar;

/**
 *  导航标题内容
 */
@property(nonatomic,copy)  NSString *navigationTitle;

@property(strong,nonatomic) UITableView  *mainTableView;

@property (nonatomic, strong)WFRefreshView *refreshView;

@property (nonatomic, strong) UIButton *leftBarItemButton;


/**
 *  请求新数据
 */
- (void)requestNewData;


/**
 *  请求旧数据
 */
- (void)requestOldData;


/**
 *  打开左抽屉
 */
- (void)openLeftDrawer;

@end
