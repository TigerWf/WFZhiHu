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

@interface WFDetailController ()<WFBottomBarDelegate>
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
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
        }];);
        
        
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
