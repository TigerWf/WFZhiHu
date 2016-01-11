//
//  WFOutsideWebController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFOutsideWebController.h"
#import "WFOutsideWebBottomBarView.h"

@interface WFOutsideWebController ()<UIWebViewDelegate,WFOutsideWebBottomBarDelegate>
{
    UIWebView *_detailWeb;
    NSString  *_reqString;
    UIActivityIndicatorView *_indicatorView;
    WFOutsideWebBottomBarView *_bottomView;
}
@end

@implementation WFOutsideWebController

- (id)initWithReqUrl:(NSString *)reqUrlString{
    
    if (self = [super init]) {
        
        _reqString = [reqUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mainTableView removeFromSuperview];
    [self configUI];
    [_detailWeb loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_reqString]]];
}

- (void)configUI{
    
    [self congifIndicator];
    [self.leftBarItemButton setImage:Image(@"detail_NavBack.png") forState:0];
    if (!_detailWeb) {
        
        _detailWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 50)];
        _detailWeb.delegate = self;
        [self.view addSubview:_detailWeb];
        
    }
    
    _bottomView = [[WFOutsideWebBottomBarView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50.f, kScreenWidth, 50.f)];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
}

- (void)congifIndicator{

    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 42, 0, 0)];
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

#pragma mark - WebView Delegate -
- (void)webViewDidFinishLoad:(UIWebView *)webView{
   
    self.navigationTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [_indicatorView stopAnimating];
    [_indicatorView removeFromSuperview];
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
            [_detailWeb reload];
            break;
        }
        case 2:
        {
            if ([_detailWeb canGoBack]) {
                [_detailWeb goBack];
            }
            break;
        }
        case 3:
        {
            if ([_detailWeb canGoForward]) {
                [_detailWeb goForward];
            }
            break;
        }
            
        case 4:
        {
            [[WFSharePanelView sharedManager] showSharePanelHasStore:NO byClick:^(SharePlatform plat) {
                DLog(@"plat == %zi",plat);
                
            } withPlatform:WFSharePlatformWeChat,WFSharePlatformWeChatFriends,WFSharePlatformQQ,WFSharePlatformSinaWeibo,WFSharePlatformCopyLink,WFSharePlatformMail,WFSharePlatformYouDao,WFSharePlatformYinXiang,WFSharePlatformTencentWeibo,WFSharePlatformMessage,WFSharePlatformInstapaper,WFSharePlatformTwitter,WFSharePlatformRenRen, nil];
            break;
        }
        default:
            break;
    }
}
@end
