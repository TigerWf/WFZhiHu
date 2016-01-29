//
//  WFEditorModel.m
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFEditorModel.h"

@implementation WFEditorModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{
             @"editorUrl":@"url",
             @"editorBio":@"bio",
             @"editorId":@"id",
             @"editorAvatar":@"avatar",
             @"editorName":@"name",
             };
}

@end
