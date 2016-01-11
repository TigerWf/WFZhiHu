//
//  WFSharePanelView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFSharePanelView.h"
#import "WFShareButton.h"

NSString * const WFSharePlatformWeChat = @"微信好友";
NSString * const WFSharePlatformWeChatFriends = @"微信朋友圈";
NSString * const WFSharePlatformSinaWeibo = @"新浪微博";
NSString * const WFSharePlatformQQ = @"QQ";
NSString * const WFSharePlatformMail = @"邮件";
NSString * const WFSharePlatformNULL = @"NULL";
NSString * const WFSharePlatformCopyLink = @"复制链接";
NSString * const WFSharePlatformYouDao = @"有道云笔记"; // 有道云
NSString * const WFSharePlatformYinXiang = @"印象笔记";//印象笔记
NSString * const WFSharePlatformTencentWeibo = @"腾讯微博";//腾讯微博
NSString * const WFSharePlatformMessage = @"信息";//信息
NSString * const WFSharePlatformInstapaper = @"Instapaper";//Instapaper
NSString * const WFSharePlatformTwitter = @"推特";//推特
NSString * const WFSharePlatformRenRen = @"人人";//人人


#define kCellW  65
#define kCellH  80

#define kOffSetX (kScreenWidth - 4 * kCellW)/5

@implementation WFSharePanelView
{
    NSDictionary *_platformDict;
    int _platformCount;//平台个数
    UIScrollView *_scrollView;
    float kPanelH;
    UIPageControl *_pageControl;
}

#pragma mark - 初始化相关
+ (WFSharePanelView *)sharedManager {
    
    static dispatch_once_t onceToken;
    static WFSharePanelView *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[WFSharePanelView alloc] init];
    });
    return _instance;
}


- (id)init{
    
    if (self = [super init]){
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        
        _platformDict = @{WFSharePlatformWeChat:@[@(SharePlatformWeChat),@"weChat.png"],
                          WFSharePlatformWeChatFriends:@[@(SharePlatformWeChatFriends),@"weChaFriend.png"],
                          WFSharePlatformSinaWeibo:@[@(SharePlatformSinaWeibo),@"sinaWeiBo.png"],
                          WFSharePlatformQQ:@[@(SharePlatformQQ),@"QQ.png"],
                          WFSharePlatformCopyLink:@[@(SharePlatformCopyLink),@"copyLink.png"],
                          WFSharePlatformYouDao:@[@(SharePlatformYouDao),@"youDao.png"],
                          WFSharePlatformYinXiang:@[@(SharePlatformYinXiang),@"yinXiang.png"],
                          WFSharePlatformTencentWeibo:@[@(SharePlatformTencentWeibo),@"tencentWeiBo.png"],
                          WFSharePlatformMessage:@[@(SharePlatformMessage),@"message.png"],
                          WFSharePlatformInstapaper:@[@(SharePlatformInstapaper),@"instapaper.png"],
                          WFSharePlatformTwitter:@[@(SharePlatformTwitter),@"twitter.png"],
                          WFSharePlatformRenRen:@[@(SharePlatformRenRen),@"renRen.png"],
                          WFSharePlatformMail:@[@(SharePlatformMail),@"mail.png"]};
        _platformCount = 0;
    }
    return self;
}

#pragma mark - 外部方法
- (void)showSharePanelHasStore:(BOOL)hasStore
                       byClick:(ClickActionBlock)actionBlock
                  withPlatform:(NSString *)platformTitle,...NS_REQUIRES_NIL_TERMINATION{
    
    if(_whitePanel){
        return;
    }
    _actionBlock = [actionBlock copy];
    kPanelH = hasStore?350.f:300.f;
    [self addWhitePanel];
    [self addCancelCell];
    [self addScrollView];
    [self addPageControl];
    [self addOtherButton];
    
    if([self canOpenWithPlatformTitle:platformTitle]) {
        [self addButtonWithPlatform:platformTitle];
    }
    
    if (platformTitle) {
        
        va_list args;
        va_start(args, platformTitle);
        NSString *title = nil;
        while ((title = va_arg(args, NSString *))) {
            if([self canOpenWithPlatformTitle:title]) {
                [self addButtonWithPlatform:title];
            }
        }
        va_end(args);
    }
    
    [self show];
    
}

#pragma mark - 内部方法
#pragma mark - 白板部分
- (void)addWhitePanel{
    
    _whitePanel = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight , kScreenWidth, kPanelH)];
    _whitePanel.backgroundColor = RGBColor(233, 233, 233, 1.0f);
    [self addSubview:_whitePanel];
}

- (void)addScrollView{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kCellW - 10, kScreenWidth, 160)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    [_whitePanel addSubview:_scrollView];

}

- (void)addPageControl{
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    _pageControl.enabled = NO;
    [_whitePanel addSubview:_pageControl];

}

- (void)addCancelCell{
    
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kCellW)];
    tipLab.text = @"分享这篇内容";
    tipLab.backgroundColor = [UIColor clearColor];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont boldSystemFontOfSize:18.0f];
    tipLab.textColor = RGBColor(87.f, 87.f, 87.f, 1);
    [_whitePanel addSubview:tipLab];
    

}

- (void)addOtherButton{
   
    if (kPanelH == 350.f) {
        
        UIButton *storeBtn = [UIButton buttonWithType:0];
        storeBtn.frame = CGRectMake(20, _scrollView.frame.origin.y + _scrollView.frame.size.height + 20, kScreenWidth - 40, 40);
        storeBtn.backgroundColor = [UIColor whiteColor];
        [storeBtn setTitle:@"收藏" forState:0];
        storeBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [storeBtn setTitleColor:[UIColor grayColor] forState:0];
        [storeBtn addTarget:self action:@selector(storeNewsInfo) forControlEvents:1<<6];
        [_whitePanel addSubview:storeBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:0];
        cancelBtn.frame = CGRectMake(20, storeBtn.frame.origin.y + storeBtn.frame.size.height + 16, kScreenWidth - 40, 40);
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn setTitle:@"取消" forState:0];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [cancelBtn setTitleColor:[UIColor grayColor] forState:0];
        [cancelBtn addTarget:self action:@selector(dismissSelf) forControlEvents:1<<6];
        [_whitePanel addSubview:cancelBtn];
        
        
    }else{
        
        UIButton *cancelBtn = [UIButton buttonWithType:0];
        cancelBtn.frame = CGRectMake(20, _scrollView.frame.origin.y + _scrollView.frame.size.height + 20, kScreenWidth - 40, 40);
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn setTitle:@"取消" forState:0];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [cancelBtn setTitleColor:[UIColor grayColor] forState:0];
        [cancelBtn addTarget:self action:@selector(dismissSelf) forControlEvents:1<<6];
        [_whitePanel addSubview:cancelBtn];
    
    }
  
}

#pragma mark - 分享按钮
- (void)addButtonWithPlatform:(NSString *)platform{
    
    WFShareButton *btn = [[WFShareButton alloc] initWithFrame:CGRectMake(kScreenWidth * (_platformCount/8) + (_platformCount%8)%4 * kCellW + kOffSetX * ((_platformCount%8)%4 + 1), 0 + ((_platformCount%8)/4) * kCellH , kCellW, kCellH)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:RGBColor(87.f, 87.f, 87.f, 1) forState:0];
     btn.platform = [[[_platformDict valueForKey:platform] objectAtIndex:0] integerValue];
    [btn setImage:Image([[_platformDict valueForKey:platform] objectAtIndex:1]) forState:0];
    [btn addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth * (_platformCount/8 + 1) , 0);
    CGSize pcSize = [_pageControl sizeForNumberOfPages:_platformCount/8 + 1];
    _pageControl.frame = CGRectMake((kScreenWidth - pcSize.width) * 0.5, _scrollView.frame.origin.y + _scrollView.frame.size.height - 10, pcSize.width, pcSize.height);
    _pageControl.numberOfPages = _platformCount/8 + 1;
    
    _platformCount ++;
}


#pragma mark － 判断 是否显示该分享功能
- (BOOL)canOpenWithPlatformTitle:(NSString *)platformTitle {
    
    if (platformTitle == WFSharePlatformWeChat || platformTitle == WFSharePlatformWeChatFriends ) {
        return YES;//是否能打开微信  这里默认打开
    }else if (platformTitle == WFSharePlatformQQ) {
        return YES;//是否能打开qq 这里默认打开
    }else if (platformTitle == WFSharePlatformNULL) {
        return NO;
    }
    return YES;
}


#pragma mark - ScrollView Delegate- 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _pageControl.currentPage = scrollView.contentOffset.x / kScreenWidth;
}

#pragma mark - 按钮事件
- (void)shareButtonAction:(WFShareButton *)sender{
    
    _actionBlock(sender.platform);
    DELAYEXECUTE(.4, {[self dismissSelf];});
    
}

#pragma mark - 展现
- (void)show{
    
    _whitePanel.frame = CGRectMake(0, kScreenHeight , kScreenWidth,kPanelH);
    [[self getUnhiddenFrontWindowOfApplication] addSubview:self];
    
    [UIView animateWithDuration:.4 animations:^{
        
        _whitePanel.frame = CGRectMake(0, kScreenHeight - kPanelH, kScreenWidth,kPanelH);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 消失
- (void)dismissSelf{
    
    [UIView animateWithDuration:.4 animations:^{
        
        _whitePanel.frame = CGRectMake(0, kScreenHeight , kScreenWidth,kPanelH);
        
    } completion:^(BOOL finished) {
        for (UIView *btn in _whitePanel.subviews) {
            [btn removeFromSuperview];
        }
        
        [_whitePanel removeFromSuperview];
        _whitePanel = nil;
        [self removeFromSuperview];
        _platformCount = 0;
        
    }];
}

#pragma mark - 收藏
- (void)storeNewsInfo{

    [WFToastView showMsg:@"收藏" inView:nil];
}

#pragma mark - 获得window
- (UIWindow *) getUnhiddenFrontWindowOfApplication{
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    NSInteger windowCnt = [windows count];
    for (NSInteger i = windowCnt - 1; i >= 0; i--) {
        UIWindow* window = [windows objectAtIndex:i];
        if (FALSE == window.hidden) {
            //定制：防止产生bar提示，用的是新增window,排除这个window
            if (window.frame.size.height > 50.0f) {
                window.windowLevel = 1001;
                return window;
            }
        }
    }
    return NULL;
}


@end
