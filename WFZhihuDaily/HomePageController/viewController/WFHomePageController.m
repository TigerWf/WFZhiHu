//
//  WFHomePageController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFHomePageController.h"
#import "WFDetailController.h"
#import "WFMainViewCell.h"
#import "WFAutoLoopView.h"

@interface WFHomePageController ()<UITableViewDelegate,UITableViewDataSource>
{
    WFAutoLoopView *_autoLoopView;
}
@property(strong,nonatomic) WFHomePageVM *viewModel;


@end

@implementation WFHomePageController

#pragma mark - CELL REUSE ID
static NSString * const kCellID = @"WFCell";

- (id)initWithViewModel:(WFHomePageVM *)viewModel{
  
    if (self == [super init]) {
        self.viewModel = viewModel;
    }
    return self;

}
#pragma mark - View Load
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
    DLog(@"home page Controller will appear");
    
}

#pragma mark - View
#pragma mark - View factory
- (void)configUI{
  
    WS(weakSelf);
  
    self.navigationBar.alpha = 0.f;
    self.navigationTitle = @"今日要闻";
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[WFMainViewCell class] forCellReuseIdentifier:kCellID];
    [_viewModel requestLatestNewsData:^{
        [weakSelf addTopView];
        [weakSelf.mainTableView reloadData];
    }];
}

- (void)addTopView{

    WS(weakSelf);
    _autoLoopView = [[WFAutoLoopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200.f)];
    _autoLoopView.stretchAnimation = YES;
    _autoLoopView.banners = [_viewModel getAutoLoopData];;
    _autoLoopView.clickAutoLoopCallBackBlock = ^(WFBannerModel *bannerModel){
        
        WFSingelNewsModel *singleNewsModel= [[WFSingelNewsModel alloc] init];
        singleNewsModel.newsId = bannerModel.newsId;
        singleNewsModel.imagesUrl = @[bannerModel.bannerImage];
        
        WFDetailVM *detailVM = [[WFDetailVM alloc] init];
        detailVM.singleNewsModel = singleNewsModel;
        
        WFDetailController *detail = [[WFDetailController alloc] initWithViewModel:detailVM];
        [weakSelf.navigationController pushViewController:detail animated:YES];
    };
    
    [self.mainTableView setTableHeaderView:_autoLoopView];

}

#pragma mark - TableView Delegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WFMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.singleNewsLayout = [_viewModel singleNewsAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WFDetailVM *detailVM = [[WFDetailVM alloc] init];
    detailVM.singleNewsModel = [[_viewModel singleNewsAtIndexPath:indexPath] singeModel];
    
    WFDetailController *detail = [[WFDetailController alloc] initWithViewModel:detailVM];
    [self.navigationController pushViewController:detail animated:YES];
    
}


#pragma mark - ScrollView Delegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [super scrollViewDidScroll:scrollView];
    if (scrollView == self.mainTableView){
     
        CGFloat offSetY = scrollView.contentOffset.y;
        float h = offSetY / 200;
        self.navigationBar.alpha = (h > 1)?1:h;
    
        if ([self.mainTableView.tableHeaderView isKindOfClass:[WFAutoLoopView class]]) {
             [(WFAutoLoopView *)(self.mainTableView.tableHeaderView) wf_parallaxHeaderViewWithOffset:scrollView.contentOffset];
        }
        
    }


}

- (void)requestNewData{
    [super requestNewData];
    DLog(@"requestNewData");
    DELAYEXECUTE(3.0f, self.isLoading = NO;[self.refreshView stopAnimation];);

}

@end
