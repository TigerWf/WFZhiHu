//
//  WFManager+DetailInfo.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFManager+DetailInfo.h"

@implementation WFManager (DetailInfo)

+ (void)wf_getNewsDetailWithID:(NSString *)newsId
                       success:(GetNewsDetailSuccessBlock)success
                       failure:(wf_reqFailureBlock)failure{
    
    [WFManager wf_reqWithMethod:WFRequestGET urlStr:[NSString stringWithFormat:@"news/%@",newsId] params:nil class:NSClassFromString(@"WFDetailNewsModel") success:^(id data) {
        
        success(data);
        
    } failure:^(WFError *error) {
        
        failure(error);
    }];
}


+ (void)wf_getNewsExtraWithID:(NSString *)newsId
                      success:(GetNewsExtraSuccessBlock)success
                      failure:(wf_reqFailureBlock)failure{
    
    [WFManager wf_reqWithMethod:WFRequestGET urlStr:[NSString stringWithFormat:@"story-extra/%@",newsId] params:nil class:NSClassFromString(@"WFDetailExtraModel") success:^(id data) {
        
        success(data);
        
    } failure:^(WFError *error) {
        
        failure(error);
    }];


}

@end
