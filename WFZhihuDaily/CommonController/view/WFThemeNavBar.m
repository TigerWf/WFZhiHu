//
//  WFThemeNavBar.m
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFThemeNavBar.h"

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

    _blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 138)];
    [self addSubview:_blurView];
    _blurView.tintColor = [UIColor clearColor];
    _blurView.hidden = YES;

}

- (void)wf_parallaxHeaderViewWithOffset:(CGFloat)offset{
    
    if (offset == 0.f) {
        _blurView.hidden = YES;
    }else{
        _blurView.hidden = NO;
        _blurView.blurRadius = -offset/2;
    }
    self.frame = CGRectMake(0, -74 - offset/2, kScreenWidth, 138 - offset/2);
    _blurView.frame = CGRectMake(0, 0, kScreenWidth, 138 - offset/2);

  
}

@end
