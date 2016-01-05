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
//
//+ (void)yy_getNewsDetailWithID:(NSString *)newsId
//                      success:(GetNewsDetailSuccessBlock)success
//                      failure:(yy_reqFailureBlock)failure{
//    [YYManager yy_reqWithMethod:YYRequestGET urlStr:newsId params:nil class:NSClassFromString(@"YYDetailNewsBO") success:^(id data) {
//
//        success(data);
//    } failure:^(YYError *error) {
//        failure(error);
//    }];
//
//}
//
//+ (void)yy_getPreviousNewsWithDate:(NSString *)dateStr
//                           success:(GetMainViewInfoSuccessBlock)success
//                           failure:(yy_reqFailureBlock)failure{
//    NSString *appendStr = [NSString stringWithFormat:@"before/%@",dateStr];
//    [YYManager yy_reqWithMethod:YYRequestGET urlStr:appendStr params:nil class:NSClassFromString(@"YYLatestNewsBO") success:^(id data) {
//        success(data);
//    } failure:^(YYError *error) {
//        failure(error);
//    }];
//}
//
//

@end
