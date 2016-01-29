//
//  WFCommonController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFCommonController.h"
#import "WFThemeNavBar.h"

@interface WFCommonController ()<UIScrollViewDelegate>

@property (nonatomic, strong) WFThemeNavBar *themeNavBar;

@end

@implementation WFCommonController

- (instancetype)initWithViewModel:(WFCommonVM *)viewModel{
    
    if (self == [super init]) {
        self.viewModel = viewModel;
    }
    return self;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.statusBar.hidden = YES;
    self.navigationBar.hidden = YES;
    [self.leftBarItemButton setImage:Image(@"detail_NavBack.png") forState:0];
    self.mainTableView.tableHeaderView = nil;
    ((UIScrollView *)self.mainTableView).delegate = self;
    [self.view addSubview:self.themeNavBar];
}

- (void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];
    DLog(@"common Controller will appear");

}


#pragma mark - UIScrollView Delegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offSetY = scrollView.contentOffset.y;
    
    if (-offSetY <= 64 && -offSetY >= 0){
        
        [_themeNavBar wf_parallaxHeaderViewWithOffset:scrollView.contentOffset.y];
    }
    if (-offSetY > 64) {//到－64 让webview不再能被拉动
        
        self.mainTableView.contentOffset = CGPointMake(0, -64);
        
    }
}

#

#pragma mark - Getter
- (WFThemeNavBar *)themeNavBar{

    if (!_themeNavBar) {
        _themeNavBar = [[WFThemeNavBar alloc] initWithFrame:CGRectMake(0, -36, kScreenWidth, 100)];
    }
    return _themeNavBar;

}


@end
