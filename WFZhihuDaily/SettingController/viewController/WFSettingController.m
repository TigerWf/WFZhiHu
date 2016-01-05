//
//  WFSettingController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFSettingController.h"

@interface WFSettingController ()

@end

@implementation WFSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    DLog(@"setting Controller");
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    DLog(@"setting Controller will appear");
    
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
