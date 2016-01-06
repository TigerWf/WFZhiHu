//
//  WFDetailController.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WFDetailVM.h"

@interface WFDetailController : UIViewController<UIScrollViewDelegate>

- (instancetype)initWithViewModel:(WFDetailVM *)viewModel;

@end
