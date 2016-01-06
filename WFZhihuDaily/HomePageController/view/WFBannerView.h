//
//  WFBannerView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFBannerModel.h"

@interface WFBannerView : UIImageView

@property (nonatomic, strong) WFBannerModel *banner;

@property (nonatomic,   copy) void(^clickBannerCallBackBlock)(WFBannerModel *banner);

@end
