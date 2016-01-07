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
    NSMutableArray *_dateList;//日期数组 可用来显示有多少section
}
- (void)requestLatestNewsData:(getDataFinish)getFinish{
    
    [WFManager wf_getMainViewNewsWithField:@"latest" success:^(WFLatestNewsModel *newsModel) {
        
        _currentDay = newsModel.date;
        
        if (_dateList) {
            [_dateList removeAllObjects];
            _dateList = nil;
        }
        _dateList = [[NSMutableArray alloc] init];
        [_dateList addObject:_currentDay];
        
        
        NSMutableArray *listNewsArr = [[NSMutableArray alloc] init];
        [listNewsArr addObjectsFromArray:newsModel.storiesArray];
        
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
        
        if (_autoLoopNewsArr) {
            [_autoLoopNewsArr removeAllObjects];
            _autoLoopNewsArr = nil;
        }
        _autoLoopNewsArr = [[NSMutableArray alloc] init];//顶部循环图的数据
        
        for (NSUInteger i = 0; i< newsModel.topStoriesArray.count; i++) {
        
                WFSingelNewsModel *scrollNewsModel = newsModel.topStoriesArray[i];
                WFBannerModel *bannerModel = [[WFBannerModel alloc] init];
                bannerModel.bannerImage = scrollNewsModel.imageUrl;
                bannerModel.newsId = scrollNewsModel.newsId;
                bannerModel.newsTitle = scrollNewsModel.newsTitle;
                [_autoLoopNewsArr addObject:bannerModel];
        }

        
        getFinish();
        
    } failure:^(WFError *error) {
        
    }];
    
}

- (void)requestPreviousNewsData:(getDataFinish)getFinish{

    [WFManager wf_getPreviousNewsWithDate:_currentDay success:^(WFLatestNewsModel *newsModel) {
        
        _currentDay = newsModel.date;

        [_dateList addObject:_currentDay];
        
        NSMutableArray *listNewsArr = [[NSMutableArray alloc] init];
        [listNewsArr addObjectsFromArray:newsModel.storiesArray];
        
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

- (NSAttributedString *)headerTitleForSection:(NSInteger)section {
    
    NSString *dateString =  [self stringConvertToSectionTitleText:_dateList[section]];
    return [[NSAttributedString alloc] initWithString:dateString attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (NSString *)dateOfSections:(NSUInteger)section{

    return _dateList[section];
}

- (NSUInteger)numberOfSections {
    
    return _listLayoutArr.count;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section{
    
    if (_listLayoutArr.count > section) {
        return [[_listLayoutArr objectAtIndex:section] count];

    }
    return 0;
}

- (WFSingelNewsLayout *)singleNewsAtIndexPath:(NSIndexPath *)indexPath{

    WFSingelNewsLayout *singleNewsLayout = _listLayoutArr[indexPath.section][indexPath.row];
    return singleNewsLayout;

}

- (NSMutableArray *)getAutoLoopData{
   
    return _autoLoopNewsArr;

}


#pragma mark - 时间格式转换
- (NSString*)stringConvertToSectionTitleText:(NSString*)str {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:str];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CH"];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *sectionTitleText = [formatter stringFromDate:date];
    return sectionTitleText;
}

@end






