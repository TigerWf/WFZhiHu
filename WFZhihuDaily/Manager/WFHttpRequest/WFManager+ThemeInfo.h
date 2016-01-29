//
//  WFManager+ThemeInfo.h
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFManager.h"
#import "WFThemeNewsModel.h"

typedef void(^GetThemeDetailSuccessBlock)(WFThemeNewsModel *);

@interface WFManager (ThemeInfo)

+ (void)wf_getThemeDetailWithID:(NSString *)newsId
                       success:(GetThemeDetailSuccessBlock)success
                       failure:(wf_reqFailureBlock)failure;

@end
