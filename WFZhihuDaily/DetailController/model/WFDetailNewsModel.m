//
//  WFDetailNewsModel.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDetailNewsModel.h"

@implementation WFDetailNewsModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"newsBody":@"body",
             @"imageSource":@"image_source",
             @"newsTitle":@"title",
             @"imageUrl":@"image",
             @"shareUrl":@"share_url",
             @"js":@"js",
             @"gaPrefix":@"ga_prefix",
             @"newsType":@"type",
             @"newsId":@"id",
             @"cssType":@"css",
             };
}

@end
