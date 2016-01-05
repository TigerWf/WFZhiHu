//
//  WFLeftDataModel.m
//  WFZhihuDaily
//
//  Created by 吴福虎 on 16/1/6.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import "WFLeftDataModel.h"
#import "WFBaseController.h"

@implementation WFLeftDataModel

- (id)init{
    
    if (self == [super init]) {
        _leftList = @[@"首页",@"动漫日报"];
        //,@"日常心理学",@"用户推荐日报",@"电影日报",@"不许无聊",@"设计日报",@"大公司日报",@"财经日报",@"互联网安全",@"开始游戏",@"音乐日报",@"体育日报"
        _viewControllerList = [[NSMutableArray alloc] init];
        //@[@"WFHomePageController",@"WFCommonController"];
    }

    return self;
}

- (void)insertViewControllers:(NSMutableArray *)controllers{
    
    for (WFBaseController *vc in controllers) {//左抽屉的tableview 数据源
        
        [_viewControllerList addObject:NSStringFromClass([vc class])];
    }
    
}

@end
