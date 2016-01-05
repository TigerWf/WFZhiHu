//
//  WFBaseController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFBaseController.h"

@interface WFBaseController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_navigationLabel;
    
}


@end

@implementation WFBaseController

- (id)init{

    if (self == [super init]) {
        
        _showFlag = NO;
        _needUpdate = NO;
    }
    return self;
}

#pragma mark - View Load
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigationBar];
    [self configListView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


#pragma mark - View
#pragma mark - View factory
- (void)configNavigationBar{

    _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _navigationBar.backgroundColor = RGBColor(5, 143, 214, 1.0f);
    [self.view addSubview:_navigationBar];
    
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    _navigationLabel.textAlignment = NSTextAlignmentCenter;
    _navigationLabel.font = [UIFont systemFontOfSize:18];
    _navigationLabel.textColor = [UIColor whiteColor];
    _navigationLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navigationLabel];
  
    
}


- (void)configListView{

    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 20.f, kScreenWidth, kScreenHeight-20.f)];
    _mainTableView.rowHeight = 88;
    _mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 200.f)];
    [self.view addSubview:_mainTableView];

}



#pragma mark - Setter
- (void)setNavigationTitle:(NSString *)navigationTitle{
    
    _navigationLabel.text = navigationTitle;

}

@end
