//
//  WFLeftBottomView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/7.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFLeftBottomView.h"

@implementation WFLeftBottomView

- (id)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{

    UIButton *downLoadBtn = [UIButton buttonWithType:0];
    downLoadBtn.frame = CGRectMake(0, 0, kScreenWidth * kDrawerRatio / 2, 50);
    [downLoadBtn setImage:Image(@"leftDownload.png") forState:0];
    [self addSubview:downLoadBtn];
    
    UIButton *dayNightBtn = [UIButton buttonWithType:0];
    dayNightBtn.frame = CGRectMake(kScreenWidth * kDrawerRatio / 2, 0, kScreenWidth * kDrawerRatio / 2, 50);
    [dayNightBtn setImage:Image(@"leftNight.png") forState:0];
    [self addSubview:dayNightBtn];
    

}

@end
