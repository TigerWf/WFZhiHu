//
//  WFOutsideWebBottomBarView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFOutsideWebBottomBarView.h"

@implementation WFOutsideWebBottomBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI:frame];
        
    }
    return self;
}

- (void)configUI:(CGRect)frame{
    
    UIImageView *barBackV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50.f)];
    barBackV.backgroundColor = RGBColor(60, 60, 60, 1.0);
    barBackV.layer.shadowOffset = CGSizeMake(0, - 4.f);
    barBackV.layer.shadowColor = RGBColor(198.f, 198.f, 198.f, 1).CGColor;
    [self addSubview:barBackV];
    barBackV.layer.shadowOpacity = 0.2;
    
    NSArray *imgArr = @[@"webView_1",@"webView_2",@"webView_3",@"webView_4",@"webView_5"];
    
    for (NSUInteger i = 0; i < imgArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:0];
        button.tag = kBottomTag + i;
        NSInteger leftWidth= (kScreenWidth / 5 - 50)/2;
        button.frame = CGRectMake(leftWidth + (50.f + 2 * leftWidth) * i - 10, 0, 70.f, 50.f);
        [button setImage:Image(imgArr[i]) forState:0];
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:1<<6];
        [self addSubview:button];
        
    }
}

#pragma mark - Setter -
- (void)selectBtn:(UIButton *)button{
    
    [_delegate selectBtn:button];
}
@end
