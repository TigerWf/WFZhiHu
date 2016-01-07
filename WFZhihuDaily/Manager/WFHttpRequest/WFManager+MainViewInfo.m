//
//  WFManager+MainViewInfo.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFManager+MainViewInfo.h"

@implementation WFManager (MainViewInfo)

+ (void)wf_getMainViewNewsWithField:(NSString *)fieldTxt
                            success:(GetMainViewInfoSuccessBlock)success
                            failure:(wf_reqFailureBlock)failure{
  
    [WFManager wf_reqWithMethod:WFRequestGET urlStr:fieldTxt params:nil class:NSClassFromString(@"WFLatestNewsModel") success:^(id data) {
        
        success(data);
    } failure:^(WFError *error) {
        failure(error);
    }];
}


+ (void)wf_getNewsDetailWithID:(NSString *)newsId
                       success:(GetNewsDetailSuccessBlock)success
                       failure:(wf_reqFailureBlock)failure{

    [WFManager wf_reqWithMethod:WFRequestGET urlStr:newsId params:nil class:NSClassFromString(@"WFDetailNewsModel") success:^(id data) {
        
        success(data);
        
    } failure:^(WFError *error) {
        
        failure(error);
    }];
}

+ (void)wf_getPreviousNewsWithDate:(NSString *)dateStr
                           success:(GetMainViewInfoSuccessBlock)success
                           failure:(wf_reqFailureBlock)failure{

    NSString *appendStr = [NSString stringWithFormat:@"before/%@",dateStr];
    [WFManager wf_reqWithMethod:WFRequestGET urlStr:appendStr params:nil class:NSClassFromString(@"WFLatestNewsModel") success:^(id data) {
        success(data);
    } failure:^(WFError *error) {
        failure(error);
    }];
}

@end
