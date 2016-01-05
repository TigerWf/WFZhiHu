//
//  WFSingelNewsModel.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFSingelNewsModel : NSObject

@property (nonatomic, copy) NSArray *imagesUrl; //新闻列表
@property (nonatomic, copy) NSString *imageUrl; //轮播图
@property (nonatomic, copy) NSString *newsType;
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *newsTitle;


@end
