//
//  WFCartoonController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFCartoonController.h"

@interface WFCartoonController ()

@end

@implementation WFCartoonController

- (void)viewDidLoad {
    [super viewDidLoad];
// ////***********************************写死*************************************
    WFThemeModel *themeModel = [[WFThemeModel alloc] init];
    themeModel.themeId = @"9";
    themeModel.themeName = @"动漫日报";
    
    self.viewModel.themeModel = themeModel;
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self configNavBarUI];
    
}


@end
