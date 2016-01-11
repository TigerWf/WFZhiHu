//
//  WFOutsideWebController.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFBaseController.h"

@interface WFOutsideWebController : WFBaseController

/**
 *  初始化
 *
 *  @param reqUrlString 请求的url的string
 *
 *  @return id
 */
- (id)initWithReqUrl:(NSString *)reqUrlString;

@end
