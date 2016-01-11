//
//  WFDetailVM.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFSingelNewsModel.h"
#import "WFDetailNewsModel.h"
#import "WFDetailHeaderLayout.h"
#import "WFDetailExtraModel.h"

typedef void(^getDataFinish)();
typedef void(^getExtraFinish)();

@interface WFDetailVM : NSObject

@property (nonatomic, strong) WFSingelNewsModel *singleNewsModel;

/**
 *  新闻额外信息
 */
@property (nonatomic, strong) WFDetailExtraModel *extraModel;

/**
 *  存放内容id的数组
 */
@property (nonatomic, strong) NSMutableArray *storeIdArray;

/**
 *  是否还有上一条
 */
@property (nonatomic, assign) BOOL isHasPrevious;

/**
 *  是否还有下一条
 */
@property (nonatomic, assign) BOOL isHasNext;

@property (nonatomic, assign) BOOL isLoading;//是否正在请求

- (void)requestWebViewData:(getDataFinish)getFinish;


/**
 *  获得上一条的信息
 *
 *  @param getFinish 回调
 */
- (void)getPreviousData:(getDataFinish)getFinish;


/**
 *  获得下一条的信息
 *
 *  @param getFinish 回调
 */
- (void)getNextData:(getDataFinish)getFinish;


/**
 *  获得该新闻的额外信息
 *
 *  @param getFinish 回调
 */
- (void)requestExtraInfo:(getExtraFinish)getExtraFinish;


- (void)getPreviousExtraData:(getDataFinish)getExtraFinish;

- (void)getNextExtraData:(getDataFinish)getExtraFinish;

- (WFDetailNewsModel *)detailSourceData;

- (NSString *)loadWebViewHtml;

- (WFDetailHeaderLayout *)detailHeaderLayout;


@end
