//
//  WFFinanceController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFFinanceController.h"

@interface WFFinanceController ()

@end

@implementation WFFinanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // ////***********************************写死*************************************
    WFThemeModel *themeModel = [[WFThemeModel alloc] init];
    themeModel.themeId = @"6";
    themeModel.themeName = @"财经日报";
    
    self.viewModel.themeModel = themeModel;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self configNavBarUI];
    
}

@end
