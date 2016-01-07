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
#import "WFDateHeaderView.h"
#import "AppDelegate.h"
#import "WFMainController.h"

@interface WFHomePageController ()<UITableViewDelegate,UITableViewDataSource>
{
    WFAutoLoopView *_autoLoopView;
}
@property(strong,nonatomic) WFHomePageVM *viewModel;


@end

@implementation WFHomePageController

#pragma mark - CELL REUSE ID
static NSString * const kCellID = @"WFCell";
static NSString * const kHeaderID = @"WFHeader";

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

#pragma mark - Private Method -
- (void)openLeftDrawer{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.window.rootViewController isKindOfClass:[WFMainController class]]) {
        WFMainController *mainVc = (WFMainController *)appDelegate.window.rootViewController;
        if (mainVc.isFold == YES) {
            [mainVc hideDrawerList];
        }else{
            [mainVc showDrawerList];
        }
    }
}

#pragma mark - View
#pragma mark - View factory
- (void)configUI{
  
    WS(weakSelf);
  
    self.navigationBar.alpha = 0.f;
    self.statusBar.alpha = 0.f;

    self.navigationTitle = @"今日要闻";
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[WFMainViewCell class] forCellReuseIdentifier:kCellID];
    [self.mainTableView registerClass:[WFDateHeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderID];
    
    [_viewModel requestLatestNewsData:^{
        [weakSelf addTopView];
        [weakSelf.mainTableView reloadData];
    }];
}

- (void)addTopView{

    if (_autoLoopView) {
        [_autoLoopView removeFromSuperview];
    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return nil;
    }
    WFDateHeaderView *headerView =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderID];
    headerView.contentView.backgroundColor = RGBColor(5, 143, 214, 1.0f);
    headerView.textLabel.attributedText = [_viewModel headerTitleForSection:section];
    return headerView;
}

#pragma mark - ScrollView Delegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [super scrollViewDidScroll:scrollView];
    
    if (scrollView == self.mainTableView){
     
        CGFloat offSetY = scrollView.contentOffset.y;
        float h = offSetY / 200;
        self.navigationBar.alpha = (h > 1)?1:h;
        self.statusBar.alpha = (h > 1)?1:h;
        
        if ([self.mainTableView.tableHeaderView isKindOfClass:[WFAutoLoopView class]]) {
             [(WFAutoLoopView *)(self.mainTableView.tableHeaderView) wf_parallaxHeaderViewWithOffset:scrollView.contentOffset];
        }
        
        CGFloat dateHeaderHeight = 44;
        if (offSetY <= dateHeaderHeight && offSetY >= 0) {
          
            scrollView.contentInset = UIEdgeInsetsMake(-offSetY, 0, 0, 0);
        }
        else if (offSetY >= dateHeaderHeight) {//偏移20
            
            scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        }
      
        if (offSetY >=  80.f * ([_viewModel numberOfRowsInSection:0]) + 180) {//第一个section到达后 隐藏navbar 和 标题
            self.navigationBar.alpha = 0.f;
            self.navigationTitle = @"";
        }else{//透明度变化上面已经设置完成
            self.navigationTitle = @"今日要闻";
        }
    }

}

- (void)requestNewData{
    
    [super requestNewData];
    
     WS(weakSelf);
    
    [_viewModel requestLatestNewsData:^{
        weakSelf.isLoading = NO;
        [self.refreshView stopAnimation];
        [weakSelf addTopView];
        [weakSelf.mainTableView reloadData];
    }];
    
}

- (void)requestOldData{

    [super requestOldData];
    WS(weakSelf);
    
    [_viewModel requestPreviousNewsData:^{
        weakSelf.isLoading = NO;
        [self.refreshView stopAnimation];
        [weakSelf.mainTableView reloadData];
    }];

}

@end
