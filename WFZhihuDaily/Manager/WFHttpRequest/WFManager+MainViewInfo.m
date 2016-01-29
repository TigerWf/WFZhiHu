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
    
    [WFManager wf_reqWithMethod:WFRequestGET urlStr:[NSString stringWithFormat:@"news/%@",fieldTxt] params:nil class:NSClassFromString(@"WFLatestNewsModel") success:^(id data) {
        
        success(data);
    } failure:^(WFError *error) {
        failure(error);
    }];
}




+ (void)wf_getPreviousNewsWithDate:(NSString *)dateStr
                           success:(GetMainViewInfoSuccessBlock)success
                           failure:(wf_reqFailureBlock)failure{

    NSString *appendStr = [NSString stringWithFormat:@"news/before/%@",dateStr];
    [WFManager wf_reqWithMethod:WFRequestGET urlStr:appendStr params:nil class:NSClassFromString(@"WFLatestNewsModel") success:^(id data) {
        success(data);
    } failure:^(WFError *error) {
        failure(error);
    }];
}

+ (void)wf_getLaunchImageWithSize:(NSString *)size
                          success:(wf_reqSuccessBlock)success
                          failure:(wf_reqFailureBlock)failure{
    
    NSString *appendStr = [NSString stringWithFormat:@"start-image/%@",size];
    [WFManager wf_reqWithMethod:WFRequestGET urlStr:appendStr params:nil class:nil success:^(id data) {
        
        success(data);
    } failure:^(WFError *error) {
        failure(error);
    }];


}

@end
