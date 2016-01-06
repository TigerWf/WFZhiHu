//
//  WFBannerModel.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFBannerModel : NSObject

@property (nonatomic, copy) NSString *bannerImage; // 配图url
@property (nonatomic, copy) NSString *bannerLink; // 配图link
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *newsTitle;

@end
