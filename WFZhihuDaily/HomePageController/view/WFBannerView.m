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
        
        [self configLabel];
        [self configTapGes];
    }
    return self;
}

#pragma mark - Label
- (void)configLabel{

    _bannerTitleLbl = [[UILabel alloc] init];
    _bannerTitleLbl.numberOfLines = 0;
    [self addSubview:_bannerTitleLbl];
   
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
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:banner.newsTitle attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    CGSize size =  [attStr boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    _bannerTitleLbl.frame = CGRectMake(15, 0, kScreenWidth - 30, size.height);
    [_bannerTitleLbl setBottom:175 - _offsetY];
    _bannerTitleLbl.attributedText = attStr;
    _bannerTitleLbl.alpha = _titleAlpha;
    
}

@end
