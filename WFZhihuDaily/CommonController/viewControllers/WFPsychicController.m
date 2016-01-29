//
//  WFPsychicController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFPsychicController.h"

@interface WFPsychicController ()

@end

@implementation WFPsychicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // ////***********************************写死*************************************
    WFThemeModel *themeModel = [[WFThemeModel alloc] init];
    themeModel.themeId = @"13";
    themeModel.themeName = @"日常心理学";
    
    self.viewModel.themeModel = themeModel;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self configNavBarUI];
    
}


@end
