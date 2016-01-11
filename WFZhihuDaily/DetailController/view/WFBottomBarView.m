//
//  WFBottomBarView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFBottomBarView.h"


@implementation WFBottomBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI:frame];
        
    }
    return self;
}

- (void)configUI:(CGRect)frame{
    
    UIImageView *barBackV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50.f)];
    barBackV.backgroundColor = [UIColor whiteColor];
    barBackV.layer.shadowOffset = CGSizeMake(0, - 4.f);
    barBackV.layer.shadowColor = RGBColor(198.f, 198.f, 198.f, 1).CGColor;
    [self addSubview:barBackV];
    barBackV.layer.shadowOpacity = 0.2;
    
    NSArray *imgArr = @[@"detail_Back",@"detail_Next",@"detail_Voted",@"detail_Share",@"detail_Comment"];
    
    for (NSUInteger i = 0; i < imgArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:0];
        button.tag = kBottomTag + i;
        NSInteger leftWidth= (kScreenWidth / 5 - 50)/2;
        button.frame = CGRectMake(leftWidth + (50.f + 2 * leftWidth) * i - 10, 0, 70.f, 50.f);
        [button setImage:Image(imgArr[i]) forState:0];
       
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:1<<6];
        [self addSubview:button];
        
        if (i == 1) {
            button.enabled = _nextArrowsEnable;
        }
        if (i == 4) {
             [button setTitleColor:[UIColor whiteColor] forState:0];
        }
        if (i == 2) {
             [button setTitleColor:[UIColor grayColor] forState:0];
        }
    }
}

#pragma mark - Setter -
- (void)setNextArrowsEnable:(BOOL)nextArrowsEnable{
   
    UIButton *btn = (UIButton *)[self viewWithTag:kBottomTag + 1];
    btn.enabled = nextArrowsEnable;
}


- (void)setCommentNum:(NSString *)commentNum{

    UIButton *btn = (UIButton *)[self viewWithTag:kBottomTag + 4];//赞
    if ([commentNum isEqualToString:@"0"]) {
        
    }else{
        if ([commentNum integerValue] >= 999) {
            commentNum = @"999";
        }
        [btn setTitle:commentNum forState:0];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, 18, 0)];
    }


}


- (void)setVoteNum:(NSString *)voteNum{
    
    UIButton *btn = (UIButton *)[self viewWithTag:kBottomTag + 2];//赞
    if ([voteNum isEqualToString:@"0"]) {
        
    }else{
       
        [btn setTitle:voteNum forState:0];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 20, 0)];
    }

}

- (void)selectBtn:(UIButton *)button{
    
    [_delegate selectBtn:button];
}
@end
