//
//  WFManager+ThemeInfo.m
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFManager+ThemeInfo.h"

@implementation WFManager (ThemeInfo)

+ (void)wf_getThemeDetailWithID:(NSString *)newsId
                        success:(GetThemeDetailSuccessBlock)success
                        failure:(wf_reqFailureBlock)failure{
    NSString *strUrl = [NSString stringWithFormat:@"theme/%@",newsId];

    [WFManager wf_reqWithMethod:WFRequestGET urlStr:strUrl params:nil class:NSClassFromString(@"WFThemeNewsModel") success:^(id data) {
        
        success(data);
        
    } failure:^(WFError *error) {
        
        failure(error);
    }];
    
}

@end
