//
//  WFDetailController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDetailController.h"
#import "WFDetailHeaderView.h"
#import "WFWebView.h"
#import "WFBottomBarView.h"
#import "WFLoadingView.h"
#import "WFWebImageShowView.h"
#import "WFOutsideWebController.h"

@interface WFDetailController ()<WFBottomBarDelegate,WFWebViewDelegate>
{
    WFWebView           *_detailWeb;
    WFDetailHeaderView  *_detailHeaderView;
    WFBottomBarView     *_detailBottomView;
    UIView              *_containerView;

}
@property(strong,nonatomic) WFDetailVM *viewModel;
@property (nonatomic,strong) WFLoadingView *loadingView;//加载视图

@end

@implementation WFDetailController

- (instancetype)initWithViewModel:(WFDetailVM *)viewModel{

    if (self == [super init]) {
        _viewModel = viewModel;
        _viewModel.isLoading = NO;
    }
    return self;
}

#pragma mark - View Load
- (void)viewDidLoad {
    
    [super viewDidLoad];
    WS(weakSelf);
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self configUI];
    [self configBottomUI];
    [_viewModel requestWebViewData:^{
        _detailBottomView.nextArrowsEnable = _viewModel.isHasNext;
        [weakSelf refreshUI];
        [_loadingView dismissLoadingView];
        _loadingView = nil;
    }];
    
    [_viewModel requestExtraInfo:^{
        [weakSelf refreshBottomUI];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (_detailWeb.scrollView.contentOffset.y >= 200) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
    }else{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark - View factory
- (void)configUI{

    if (!_containerView) {
        
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_containerView];
        _containerView.backgroundColor = [UIColor whiteColor];

    }
    
    if (!_detailWeb) {
        
        _detailWeb = [[WFWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20 - 44)];
        _detailWeb.scrollView.delegate = self;
        _detailWeb.webDelegate = self;
        [_containerView addSubview:_detailWeb];

    }
    
    if (!_detailHeaderView) {
        
        _detailHeaderView = [[WFDetailHeaderView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 260)];
        [_containerView addSubview:_detailHeaderView];
        _detailHeaderView.webView = _detailWeb;

    }
    
    [_containerView addSubview:self.loadingView];
    
}

- (void)configBottomUI{

    _detailBottomView = [[WFBottomBarView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50.f, kScreenWidth, 50.f)];
    _detailBottomView.delegate = self;
    [self.view addSubview:_detailBottomView];
}

- (void)refreshUI{

    [_detailWeb loadHTMLString:[_viewModel loadWebViewHtml] baseURL:nil];
    [_detailHeaderView refreshHeaderView:_viewModel];
   
}

- (void)refreshBottomUI{

    _detailBottomView.voteNum = _viewModel.extraModel.popularity;
    _detailBottomView.commentNum = _viewModel.extraModel.comments;

}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offSetY = scrollView.contentOffset.y;

    if (-offSetY <= 80 && -offSetY >= 0) {
        
        [_detailHeaderView wf_parallaxHeaderViewWithOffset:offSetY];
       
        if (-offSetY > 40 && !_detailWeb.scrollView.isDragging){
            
            [self getPreviousNews];
        }
    }else if (-offSetY > 80) {//到－80 让webview不再能被拉动
        
        _detailWeb.scrollView.contentOffset = CGPointMake(0, -80);
        
    }else if (offSetY <= 300 ){
        
        _detailHeaderView.frame = CGRectMake(0, -40 - offSetY, kScreenWidth, 260);
    }
    
    if (offSetY + kScreenHeight > scrollView.contentSize.height + 160 && !_detailWeb.scrollView.isDragging) {
        
         [self getNextNews];
    }

    if (offSetY >= 200) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
    }else{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}


#pragma mark - 获得上一条
- (void)getPreviousNews{

    WS(weakSelf);
    
    if (_viewModel.isHasPrevious == NO) {
        return;
    }
    if (_viewModel.isLoading) {
        return;
    }
     _viewModel.isLoading = YES;
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _containerView.frame = CGRectMake(0, kScreenHeight + 40, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        
        [self.view insertSubview:self.loadingView belowSubview:_detailBottomView];
        DELAYEXECUTE(0.25, _containerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                     
                            [_viewModel getPreviousData:^{
            
                                    _detailBottomView.nextArrowsEnable = YES;//肯定有下一条
                                    [weakSelf refreshUI];
                                    [self.loadingView dismissLoadingView];
                                    self.loadingView = nil;
                                    _viewModel.isLoading = NO;
            
                            }];
                     
                            [_viewModel getPreviousExtraData:^{
                                    [weakSelf refreshBottomUI];
                            }];);
            }];
}


#pragma mark - 获得下一条
- (void)getNextNews{
    
    WS(weakSelf);
    
    if (_viewModel.isHasNext == NO) {
        return;
    }
    if (_viewModel.isLoading) {
        return;
    }
    _viewModel.isLoading = YES;
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _containerView.frame = CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        
        [self.view insertSubview:self.loadingView belowSubview:_detailBottomView];
        DELAYEXECUTE(0.25, _containerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                     
                     [_viewModel getNextData:^{
            
                            _detailBottomView.nextArrowsEnable = _viewModel.isHasNext;
                            [weakSelf refreshUI];
                            [self.loadingView dismissLoadingView];
                            self.loadingView = nil;
                            _viewModel.isLoading = NO;
                    }];
                     
                    [_viewModel getNextExtraData:^{
            
                            [weakSelf refreshBottomUI];
                    }];);
        
        }];
}

#pragma mark - WFWebViewDelegate -
- (void)clickActionOnHyperlink:(NSString *)linkUrl{

    WFOutsideWebController *outSideWeb = [[WFOutsideWebController alloc] initWithReqUrl:linkUrl];
    [self.navigationController pushViewController:outSideWeb animated:YES];

}


- (void)clickActionOnImage:(NSString *)imageUrl{

    __block WFWebImageShowView *showImageView = [[WFWebImageShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) imageUrl:imageUrl];
    
    [showImageView show:[[UIApplication sharedApplication] keyWindow] didFinish:^{
        [showImageView removeFromSuperview];
        showImageView = nil;
        
    }];


}


#pragma mark - WFBottomBarDelegate -
- (void)selectBtn:(UIButton *)button{
    
    switch (button.tag - kBottomTag){
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case 1:
        {
            [self getNextNews];
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            
            [[WFSharePanelView sharedManager] showSharePanelHasStore:YES byClick:^(SharePlatform plat) {
                DLog(@"plat == %zi",plat);
                
            } withPlatform:WFSharePlatformWeChat,WFSharePlatformWeChatFriends,WFSharePlatformQQ,WFSharePlatformSinaWeibo,WFSharePlatformCopyLink,WFSharePlatformMail,WFSharePlatformYouDao,WFSharePlatformYinXiang,WFSharePlatformTencentWeibo,WFSharePlatformMessage,WFSharePlatformInstapaper,WFSharePlatformTwitter,WFSharePlatformRenRen, nil];
      
            break;
        }
            
        case 4:
        {
           
            break;
        }
        default:
            break;
    }
}


#pragma mark - Getter
- (WFLoadingView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[WFLoadingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    return _loadingView;
}
@end
