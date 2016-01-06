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
    WFWebView *_detailWeb;
    WFDetailHeaderView *_detailHeaderView;
    WFBottomBarView *_detailBottomView;
}
@property(strong,nonatomic) WFDetailVM *viewModel;
@property (nonatomic,strong) WFLoadingView *loadingView;//加载视图

@end

@implementation WFDetailController

- (instancetype)initWithViewModel:(WFDetailVM *)viewModel{

    if (self == [super init]) {
        self.viewModel = viewModel;
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
    [_viewModel requestWebViewData:^{
        [weakSelf refreshUI];
        [_loadingView dismissLoadingView];
        _loadingView = nil;
    }];
    
    [self.view addSubview:self.loadingView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)configUI{

    _detailWeb = [[WFWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20 - 44)];
    _detailWeb.scrollView.delegate = self;
    [self.view addSubview:_detailWeb];
    
    _detailHeaderView = [[WFDetailHeaderView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 260)];
    [self.view addSubview:_detailHeaderView];
    _detailHeaderView.webView = _detailWeb;
    
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
            //[self.viewmodel getPreviousStoryContent];
        }
    }else if (-offSetY > 80) {
        
        _detailWeb.scrollView.contentOffset = CGPointMake(0, -80);
        
    }else if (offSetY <= 300 ){
        _detailHeaderView.frame = CGRectMake(0, -40 - offSetY, kScreenWidth, 260);
    }
    
    if (offSetY + kScreenHeight > scrollView.contentSize.height + 160 && !_detailWeb.scrollView.isDragging) {
        // [self.viewmodel getNextStoryContent];
    }

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
