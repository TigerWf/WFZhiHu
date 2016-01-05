//
//  WFLeftController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFLeftController.h"

@interface WFLeftController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_mainTable;
}
@end

@implementation WFLeftController

#pragma mark - CELL REUSE ID
static NSString * const kMallCellID = @"XPMallCell";

- (id)init{

    if (self == [super init]) {
        _drawerSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self configUI];
}

- (void)configUI{
   
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;

    [self.view addSubview:_mainTable];
    [self registCellClass];
}

- (void)registCellClass{
    [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kMallCellID];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _drawerSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMallCellID forIndexPath:indexPath];
    cell.textLabel.text = [_drawerSource objectAtIndex:indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _drawerAction([_drawerSource objectAtIndex:indexPath.row]);

}

@end
