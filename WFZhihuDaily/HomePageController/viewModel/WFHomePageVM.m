//
//  WFHomePageVM.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFHomePageVM.h"

@implementation WFHomePageVM
{
    NSMutableArray *_listLayoutArr;
}
- (void)requestLatestNewsData:(getDataFinish)getFinish{
   
    [WFManager wf_getMainViewNewsWithField:@"latest" success:^(WFLatestNewsModel *newsModel) {
        
        NSMutableArray *listNewsArr = [[NSMutableArray alloc] init];
        [listNewsArr addObjectsFromArray:newsModel.storiesArray];
        
        _listLayoutArr = [[NSMutableArray alloc] init];
        
        for (WFSingelNewsModel *singeModel in listNewsArr) {
            @autoreleasepool {
                
                WFSingelNewsLayout *layout = [WFSingelNewsLayout new];
                layout.singeModel = singeModel;
                [_listLayoutArr addObject:layout];

            }
        }
        
        getFinish();
        
    } failure:^(WFError *error) {
        
    }];
    
}

- (NSUInteger)numberOfSections {
    
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section{

    return _listLayoutArr.count;
}

- (WFSingelNewsLayout *)singleNewsAtIndexPath:(NSIndexPath *)indexPath{

    WFSingelNewsLayout *singleNewsLayout = _listLayoutArr[indexPath.row];
    return singleNewsLayout;

}

@end






