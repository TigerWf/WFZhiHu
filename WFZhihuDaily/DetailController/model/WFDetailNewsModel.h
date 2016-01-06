//
//  WFDetailNewsModel.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFDetailNewsModel : NSObject

@property (nonatomic, copy) NSString *newsBody; //消息体
@property (nonatomic, copy) NSString *imageSource;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *js;
@property (nonatomic, copy) NSArray *recommenders;
@property (nonatomic, copy) NSString *gaPrefix;
@property (nonatomic, copy) NSString *newsType;
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSArray *cssType;

@end
