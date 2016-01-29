//
//  WFCommonVM.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFCommonVM.h"
#import "WFManager+ThemeInfo.h"
#import "WFSingelNewsModel.h"

@implementation WFCommonVM
{
    NSMutableArray *_listLayoutArr;
}
- (void)requestLatestNewsData:(getDataFinish)getFinish{

   [WFManager wf_getThemeDetailWithID:_themeModel.themeId success:^(WFThemeNewsModel *themeNewsModel) {
       
       _themeNewsModel = themeNewsModel;
       
       NSMutableArray *listNewsArr = [[NSMutableArray alloc] init];
       [listNewsArr addObjectsFromArray:_themeNewsModel.stories];
       
       if (_listLayoutArr) {
           [_listLayoutArr removeAllObjects];
           _listLayoutArr = nil;
       }
       
       _listLayoutArr = [[NSMutableArray alloc] init];
       NSMutableArray *tempArray = [[NSMutableArray alloc] init];
       
       for (WFSingelNewsModel *singeModel in listNewsArr) {
           
           WFSingelNewsLayout *layout = [WFSingelNewsLayout new];
           layout.singeModel = singeModel;
           [tempArray addObject:layout];
       }
       [_listLayoutArr addObject:tempArray];
       
        getFinish();
       
   } failure:^(WFError *error) {
       
   }];
}



- (WFSingelNewsLayout *)singleNewsAtIndexPath:(NSIndexPath *)indexPath{
    
    WFSingelNewsLayout *singleNewsLayout = _listLayoutArr[indexPath.section][indexPath.row];
    return singleNewsLayout;
    
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section{
    
    if (_listLayoutArr.count > section) {
        return [[_listLayoutArr objectAtIndex:section] count];
        
    }
    return 0;
}

@end
