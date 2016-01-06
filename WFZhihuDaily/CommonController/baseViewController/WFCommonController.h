//
//  WFCommonController.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFBaseController.h"
#import "WFCommonVM.h"

@interface WFCommonController : WFBaseController

@property(strong,nonatomic) WFCommonVM *viewModel;

- (instancetype)initWithViewModel:(WFCommonVM *)viewModel;

@end
