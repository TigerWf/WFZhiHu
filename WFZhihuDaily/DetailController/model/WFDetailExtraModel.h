//
//  WFDetailExtraModel.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  新闻额外信息模型
 */
@interface WFDetailExtraModel : NSObject

@property (nonatomic, copy) NSString *post_reasons;
@property (nonatomic, copy) NSString *long_comments;//长评论数
@property (nonatomic, copy) NSString *short_comments;//短评论数
@property (nonatomic, copy) NSString *comments;//评论综述
@property (nonatomic, copy) NSString *normal_comments;//未知其作用
@property (nonatomic, copy) NSString *popularity;//点赞数

@end
