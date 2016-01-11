//
//  WFDetailExtraModel.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDetailExtraModel.h"

@implementation WFDetailExtraModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"post_reasons":@"post_reasons",
             @"long_comments":@"long_comments",
             @"short_comments":@"short_comments",
             @"comments":@"comments",
             @"normal_comments":@"normal_comments",
             @"popularity":@"popularity",
             };
}

@end
