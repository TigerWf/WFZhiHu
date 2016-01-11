//
//  WFManager+DetailInfo.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFManager.h"
#import "WFDetailNewsModel.h"
#import "WFDetailExtraModel.h"

typedef void(^GetNewsDetailSuccessBlock)(WFDetailNewsModel *);
typedef void(^GetNewsExtraSuccessBlock)(WFDetailExtraModel *);

@interface WFManager (DetailInfo)


/**
 *  获得新闻内容
 *
 *  @param newsId  新闻id
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)wf_getNewsDetailWithID:(NSString *)newsId
                       success:(GetNewsDetailSuccessBlock)success
                       failure:(wf_reqFailureBlock)failure;


/**
 *  获得新闻额外信息
 *
 *  @param newsId  新闻id
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)wf_getNewsExtraWithID:(NSString *)newsId
                      success:(GetNewsExtraSuccessBlock)success
                      failure:(wf_reqFailureBlock)failure;


@end
