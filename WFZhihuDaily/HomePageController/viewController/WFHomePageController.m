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

@interface WFHomePageController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_singleModelArray;//单条消息的数据源
}
@property(strong,nonatomic) WFHomePageVM *viewModel;


@end

@implementation WFHomePageController

#pragma mark - CELL REUSE ID
static NSString * const kCellID = @"WFCell";

- (id)initWithViewModel:(WFHomePageVM *)viewModel{
  
    if (self == [super init]) {
        self.viewModel = viewModel;
        _singleModelArray = [[NSMutableArray alloc] init];
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
    self.navigationTitle = @"今日热闻";
    self.navigationBar.alpha = 0.f;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[WFMainViewCell class] forCellReuseIdentifier:kCellID];
    [_viewModel requestLatestNewsData:^{
        [weakSelf.mainTableView reloadData];
    }];
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


@end
