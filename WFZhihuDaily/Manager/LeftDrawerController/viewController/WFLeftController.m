//
//  WFLeftController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFLeftController.h"
#import "WFLeftCell.h"
#import "WFLeftBottomView.h"
#import "WFLeftTopView.h"

@interface WFLeftController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_mainTable;
}


@end

@implementation WFLeftController

#pragma mark - CELL REUSE ID
static NSString * const kLeftCellID = @"WFLeftCell";

- (id)initWithViewModel:(WFLeftVM *)viewModel{

    if (self == [super init]) {
      
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(35, 42, 48, 1.0);
    [self configUI];
}

- (void)configUI{
   
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight - 120 - 50)];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.backgroundColor = RGBColor(35, 42, 48, 1.0);
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
    [self registCellClass];
    
    WFLeftBottomView *bottomView = [[WFLeftBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth *kDrawerRatio, 50)];
    [self.view addSubview:bottomView];
    
    WFLeftTopView *topView = [[WFLeftTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * kDrawerRatio, 120)];
    [self.view addSubview:topView];
}

- (void)registCellClass{
    [_mainTable registerClass:[WFLeftCell class] forCellReuseIdentifier:kLeftCellID];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WFLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftCellID forIndexPath:indexPath];
    cell.leftDataString = [_viewModel leftSubfieldAtIndexPath:indexPath];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    _drawerAction([_viewModel leftListClickAction:indexPath]);

}

@end
