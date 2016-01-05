//
//  WFSingelNewsLayout.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFSingelNewsModel.h"

/**
 *  改模型对应的cell的布局为固定的 所以不需要处理
 */
@interface WFSingelNewsLayout : NSObject

@property(nonatomic, strong) WFSingelNewsModel *singeModel;

@end
