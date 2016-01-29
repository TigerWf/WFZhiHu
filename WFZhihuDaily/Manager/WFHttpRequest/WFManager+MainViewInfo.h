//
//  WFManager+MainViewInfo.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFManager.h"
#import "WFLatestNewsModel.h"


typedef void(^GetMainViewInfoSuccessBlock)(WFLatestNewsModel *);

@interface WFManager (MainViewInfo)

+ (void)wf_getMainViewNewsWithField:(NSString *)fieldTxt
                            success:(GetMainViewInfoSuccessBlock)success
                            failure:(wf_reqFailureBlock)failure;



+ (void)wf_getPreviousNewsWithDate:(NSString *)dateStr
                           success:(GetMainViewInfoSuccessBlock)success
                           failure:(wf_reqFailureBlock)failure;


+ (void)wf_getLaunchImageWithSize:(NSString *)size
                          success:(wf_reqSuccessBlock)success
                          failure:(wf_reqFailureBlock)failure;

@end
