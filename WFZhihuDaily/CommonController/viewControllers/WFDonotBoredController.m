//
//  WFDonotBoredController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDonotBoredController.h"

@interface WFDonotBoredController ()

@end

@implementation WFDonotBoredController

- (void)viewDidLoad {
    [super viewDidLoad];
    // ////***********************************写死*************************************
    WFThemeModel *themeModel = [[WFThemeModel alloc] init];
    themeModel.themeId = @"11";
    themeModel.themeName = @"不许无聊";
    
    self.viewModel.themeModel = themeModel;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self configNavBarUI];
    
}
@end
