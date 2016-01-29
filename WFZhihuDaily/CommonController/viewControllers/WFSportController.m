//
//  WFSportController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFSportController.h"

@interface WFSportController ()

@end

@implementation WFSportController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // ////***********************************写死*************************************
    WFThemeModel *themeModel = [[WFThemeModel alloc] init];
    themeModel.themeId = @"8";
    themeModel.themeName = @"体育日报";
    
    self.viewModel.themeModel = themeModel;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self configNavBarUI];
    
}

@end
