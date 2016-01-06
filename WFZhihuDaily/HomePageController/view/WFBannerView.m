//
//  WFBannerView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFBannerView.h"

@implementation WFBannerView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self configTapGes];
    }
    return self;
}


#pragma mark - 添加手势
- (void)configTapGes{
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapGes];
    
}

#pragma mark - User Action
- (void)tapAction{
    
    _clickBannerCallBackBlock(_banner);
    
}

#pragma mark - Setter
- (void)setBanner:(WFBannerModel *)banner {
    
    _banner = banner;
    [self wf_setImageWithUrlString:banner.bannerImage placeholderImage:nil];

}

@end
