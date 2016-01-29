//
//  WFDesignController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDesignController.h"

@interface WFDesignController ()

@end

@implementation WFDesignController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // ////***********************************写死*************************************
    WFThemeModel *themeModel = [[WFThemeModel alloc] init];
    themeModel.themeId = @"4";
    themeModel.themeName = @"设计日报";
    
    self.viewModel.themeModel = themeModel;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self configNavBarUI];
    
}

@end
