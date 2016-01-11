//
//  WFOutsideWebController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFOutsideWebController.h"

@interface WFOutsideWebController ()<UIWebViewDelegate>
{
    UIWebView *_detailWeb;
    NSString  *_reqString;
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
    
    if (!_detailWeb) {
        
        _detailWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 50)];
        _detailWeb.delegate = self;
        [self.view addSubview:_detailWeb];
        
    }
}

#pragma mark - WebView Delegate -
- (void)webViewDidFinishLoad:(UIWebView *)webView{
   
    self.navigationTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
@end
