//
//  WFLeftController.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFLeftVM.h"

typedef void(^LeftDrawerAction)(NSString *);

@interface WFLeftController : UIViewController

@property (nonatomic, copy) LeftDrawerAction drawerAction;

@property (nonatomic,strong) WFLeftVM *viewModel;

- (instancetype)initWithViewModel:(WFLeftVM *)viewModel;

@end
