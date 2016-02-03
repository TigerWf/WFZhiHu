//
//  WFThemeNavBar.m
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFThemeNavBar.h"
#import "UIImage+ImageEffects.h"

@implementation WFThemeNavBar

- (id)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = RGBColor(35, 42, 48, 1.0);
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        [self configBlurView];
    }
    return self;
}


- (void)configBlurView{

    _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 138)];
    _blurView.backgroundColor = [UIColor clearColor];
    _blurView.clipsToBounds = YES;
    _blurView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_blurView];

}


- (void)configBlurImage{

    UIImage *blurImg = [_blurImage applyBlurWithRadius:12 tintColor:nil saturationDeltaFactor:1.0 maskImage:nil];
    
    _blurView.image = blurImg;
    
}

#pragma mark - Public methods
- (void)wf_parallaxHeaderViewWithOffset:(CGFloat)offset{
    
    self.frame = CGRectMake(0, -74 - offset/2, kScreenWidth, 138 - offset/2);
    
    _blurView.frame = CGRectMake(0, 0, kScreenWidth, 138 - offset/2);
    _blurView.alpha = (74 + offset) / 74;
}

#pragma mark - Setter
- (void)setBlurImage:(UIImage *)blurImage{
    
    _blurImage = blurImage;
    
    [self configBlurImage];
}


@end
