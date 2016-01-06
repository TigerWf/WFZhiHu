//
//  WFHomePageVM.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFHomePageVM.h"
#import "WFBannerModel.h"

@implementation WFHomePageVM
{
    NSMutableArray *_listLayoutArr;
    NSMutableArray *_autoLoopNewsArr;
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
        
       
        _autoLoopNewsArr = [[NSMutableArray alloc] init];//顶部循环图的数据
        
        for (NSUInteger i=0; i< newsModel.topStoriesArray.count; i++) {
            
            @autoreleasepool {
                
                WFSingelNewsModel *scrollNewsModel = newsModel.topStoriesArray[i];
                WFBannerModel *bannerModel = [[WFBannerModel alloc] init];
                bannerModel.bannerImage = scrollNewsModel.imageUrl;
                bannerModel.newsId = scrollNewsModel.newsId;
                [_autoLoopNewsArr addObject:bannerModel];
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

- (NSMutableArray *)getAutoLoopData{
   
    return _autoLoopNewsArr;

}

@end






