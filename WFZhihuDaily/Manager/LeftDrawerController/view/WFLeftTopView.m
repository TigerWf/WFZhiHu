//
//  WFLeftTopView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/8.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFLeftTopView.h"

@implementation WFLeftTopView

- (id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {

        [self configUI];
    }
    return self;
}


- (void)configUI{
    
    UIButton *loginBtn = [UIButton buttonWithType:0];
    loginBtn.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height / 2 - 10);
    [loginBtn setTitle:@"请登录" forState:0];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:loginBtn];
    
    UIButton *favourBtn = [UIButton buttonWithType:0];
    favourBtn.frame = CGRectMake(0, loginBtn.frame.origin.y + loginBtn.frame.size.height, (self.frame.size.width - 60) / 3, self.frame.size.height / 2 - 10);
    [favourBtn setImage:Image(@"leftFavour.png") forState:0];
    [favourBtn setTitle:@"收藏" forState:0];
    [self addSubview:favourBtn];
    [self dealwith:favourBtn];
    
    UIButton *messageBtn = [UIButton buttonWithType:0];
    messageBtn.frame = CGRectMake(favourBtn.frame.size.width + favourBtn.frame.origin.x, loginBtn.frame.origin.y + loginBtn.frame.size.height, (self.frame.size.width - 60) / 3, self.frame.size.height / 2 - 10);
    [messageBtn setImage:Image(@"leftMessage.png") forState:0];
    [messageBtn setTitle:@"消息" forState:0];
    [self addSubview:messageBtn];
    [self dealwith:messageBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:0];
    settingBtn.frame = CGRectMake(messageBtn.frame.size.width + messageBtn.frame.origin.x, loginBtn.frame.origin.y + loginBtn.frame.size.height, (self.frame.size.width - 60) / 3, self.frame.size.height / 2 - 10);
    [settingBtn setImage:Image(@"leftSetting.png") forState:0];
    [settingBtn setTitle:@"设置" forState:0];
    [self addSubview:settingBtn];
    [self dealwith:settingBtn];
    
}


#pragma mark - Private methods -
- (void)dealwith:(UIButton *)dealBtn{
    dealBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [dealBtn setImageEdgeInsets:UIEdgeInsetsMake(-40, 27.f, 0.f, 0.f)];

}


@end
