//
//  WFLeftVM.m
//  WFZhihuDaily
//
//  Created by 阿虎 on 16/1/6.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import "WFLeftVM.h"
#import "WFManager+MainViewInfo.h"

@implementation WFLeftVM
{
    WFLeftDataModel *_dataModel;
}

- (void)requestLeftData:(NSMutableArray *)controllers{
   
   
    _dataModel = [[WFLeftDataModel alloc] init];
    [_dataModel insertViewControllers:controllers];
    
}

- (NSUInteger)numberOfSections {
    
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section{
    
    return _dataModel.leftList.count;
}

- (NSString *)leftSubfieldAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *leftSubfieldTitle = _dataModel.leftList[indexPath.row];
    return leftSubfieldTitle;
    
}

- (NSString *)leftListClickAction:(NSIndexPath *)indexPath{
 
    NSString *leftListClickString = _dataModel.viewControllerList[indexPath.row];
    return leftListClickString;


}

@end
