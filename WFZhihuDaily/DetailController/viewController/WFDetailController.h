//
//  WFDetailController.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WFDetailVM.h"
/*
 * 详情页
 */
@interface WFDetailController : UIViewController<UIScrollViewDelegate>

/**
 *  详情页初始化
 *
 *  @param viewModel 详情页viewmodel
 *
 *  @return id
 */
- (instancetype)initWithViewModel:(WFDetailVM *)viewModel;

@end
