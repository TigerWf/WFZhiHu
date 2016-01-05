//
//  WFLeftVM.h
//  WFZhihuDaily
//
//  Created by 吴福虎 on 16/1/6.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFLeftDataModel.h"


@interface WFLeftVM : NSObject

- (void)requestLeftData:(NSMutableArray *)controllers;


- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSString *)leftSubfieldAtIndexPath:(NSIndexPath *)indexPath;


- (NSString *)leftListClickAction:(NSIndexPath *)indexPath;


@end
