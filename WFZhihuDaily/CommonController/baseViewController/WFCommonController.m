//
//  WFCommonController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFCommonController.h"

@interface WFCommonController ()

@end

@implementation WFCommonController

- (instancetype)initWithViewModel:(WFCommonVM *)viewModel{
    
    if (self == [super init]) {
        self.viewModel = viewModel;
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    self.mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 64.f)];
    self.mainTableView.tableHeaderView.backgroundColor = RGBColor(35, 42, 48, 1.0);

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];
    DLog(@"common Controller will appear");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
