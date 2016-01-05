//
//  WFLatestNewsModel.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFLatestNewsModel.h"

@implementation WFLatestNewsModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"date":@"date",
             @"storiesArray":@"stories",
             @"topStoriesArray":@"top_stories",
             };
}

+ (NSDictionary *)objectClassInArray{
    
    return @{
             @"storiesArray":[WFSingelNewsModel class],
             @"topStoriesArray":[WFSingelNewsModel class],
             };
}

@end
