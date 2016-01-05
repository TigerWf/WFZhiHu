//
//  WFSingelNewsModel.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFSingelNewsModel.h"

@implementation WFSingelNewsModel

+(NSDictionary *)replacedKeyFromPropertyName{
    
    return @{
             
             @"imagesUrl":@"images",
             @"imageUrl":@"image",
             @"newsType":@"type",
             @"newsId":@"id",
             @"ga_prefix":@"ga_prefix",
             @"newsTitle":@"title"
             
             };
}

@end
