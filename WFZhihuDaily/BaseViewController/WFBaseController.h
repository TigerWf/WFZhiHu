//
//  WFBaseController.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  父视图控制器
 */
@interface WFBaseController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,assign) BOOL showFlag;//显示在最上面的viewcontroller 缺省为no

@property(nonatomic,assign) BOOL needUpdate;//是否需要更新，缺省为no

@property(nonatomic,assign) BOOL isLoading;

@property(nonatomic,strong)  UIView *navigationBar;

@property(nonatomic,copy)  NSString *navigationTitle;

@property(strong,nonatomic) UITableView  *mainTableView;

- (void)requestNewData;

@end
