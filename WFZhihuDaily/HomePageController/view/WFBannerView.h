//
//  WFBannerView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFBannerModel.h"

/**
 *  banner视图
 */
@interface WFBannerView : UIImageView

@property (nonatomic, strong) WFBannerModel *banner;

@property (nonatomic,   copy) void(^clickBannerCallBackBlock)(WFBannerModel *banner);

@property (nonatomic, strong)  UILabel *bannerTitleLbl;

@property (nonatomic, assign)  CGFloat offsetY;

@property (nonatomic, assign)  CGFloat titleAlpha;

@end
