//
//  WFThemeNewsModel.m
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFThemeNewsModel.h"
#import "WFSingelNewsModel.h"
#import "WFEditorModel.h"

@implementation WFThemeNewsModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{
             @"background":@"background",
             @"editors":@"editors",
             @"stories":@"stories",
            };
}

+ (NSDictionary *)objectClassInArray{
    
    return @{
             @"stories":[WFSingelNewsModel class],
             @"editors":[WFEditorModel class],
            };
}


@end
