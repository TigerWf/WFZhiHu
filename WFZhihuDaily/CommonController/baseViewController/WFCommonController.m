//
//  WFCommonController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFCommonController.h"
#import "WFThemeNavBar.h"
#import "WFMainViewCell.h"
#import "WFEditorView.h"
#import "AppDelegate.h"
#import "WFMainController.h"

@interface WFCommonController ()<UITableViewDataSource,UITableViewDelegate>
{
    WFEditorView *_editorView;
}
@property (nonatomic, strong) WFThemeNavBar *themeNavBar;

@end

@implementation WFCommonController

#pragma mark - CELL REUSE ID
static NSString * const kCellID = @"WFCell";

- (instancetype)initWithViewModel:(WFCommonVM *)viewModel{
    
    if (self == [super init]) {
        self.viewModel = viewModel;
    }
    return self;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configUI];
    
}

#pragma mark - View
#pragma mark - View factory
- (void)configUI{
    
    self.statusBar.hidden = YES;
    self.navigationBar.hidden = YES;
    [self.leftBarItemButton setImage:Image(@"detail_NavBack.png") forState:0];
    self.mainTableView.tableHeaderView = nil;
    self.mainTableView.frame = CGRectMake(0.f, 64.f, kScreenWidth, kScreenHeight - 64);
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[WFMainViewCell class] forCellReuseIdentifier:kCellID];
    [self.view insertSubview:self.themeNavBar belowSubview:self.leftBarItemButton];
    
    
    _editorView = [[WFEditorView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.mainTableView.tableHeaderView = _editorView;
}

#pragma mark - Data
- (void)configData{

    WS(weakSelf);
    
    [_viewModel requestLatestNewsData:^{
        
        [weakSelf refreshNavBarUI];
        [weakSelf refreshHeaderUI];
        [weakSelf.mainTableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];
    DLog(@"common Controller will appear");
    [self configData];
}


#pragma mark - UIScrollView Delegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offSetY = scrollView.contentOffset.y;

    if (-offSetY <= 74 && -offSetY >= 0){
        
        [_themeNavBar wf_parallaxHeaderViewWithOffset:scrollView.contentOffset.y];
    }
    if (-offSetY > 74) {//到－74 让scrollview不再能被拉动
        
        self.mainTableView.contentOffset = CGPointMake(0, -74);
        
    }
}

#pragma mark - TableView Delegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WFMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.singleNewsLayout = [_viewModel singleNewsAtIndexPath:indexPath];
    return cell;
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

#pragma mark - Public Methods
- (void)configNavBarUI{
    
    self.navigationTitle = _viewModel.themeModel.themeName;

}

- (void)refreshNavBarUI{

    [_themeNavBar wf_setImageWithUrlString:_viewModel.themeNewsModel.background placeholderImage:nil];
}

- (void)refreshHeaderUI{

    _editorView.avatarImageArr = _viewModel.themeNewsModel.editors;
}

#pragma mark - Getter
- (WFThemeNavBar *)themeNavBar{

    if (!_themeNavBar) {
        _themeNavBar = [[WFThemeNavBar alloc] initWithFrame:CGRectMake(0, -74, kScreenWidth, 138)];
    }
    return _themeNavBar;

}


@end
