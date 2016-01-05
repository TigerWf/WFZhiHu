//
//  WFLeftDataModel.h
//  WFZhihuDaily
//
//  Created by 吴福虎 on 16/1/6.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFLeftDataModel : NSObject

@property (nonatomic, copy) NSArray *leftList;
@property (nonatomic, copy) NSMutableArray *viewControllerList;
//用户信息 等等


- (void)insertViewControllers:(NSMutableArray *)controllers;

@end
