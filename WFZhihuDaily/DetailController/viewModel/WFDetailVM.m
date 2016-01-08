//
//  WFDetailVM.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDetailVM.h"
#import "WFManager+MainViewInfo.h"

@implementation WFDetailVM
{
    WFDetailNewsModel *_detailModel;
    WFDetailHeaderLayout *_headerLayout;
    NSString *_currentNewsId;
}


- (void)requestWebViewData:(getDataFinish)getFinish{
    
    [WFManager wf_getNewsDetailWithID:self.singleNewsModel.newsId success:^(WFDetailNewsModel *detailModel) {
        
        _detailModel = detailModel;
        _headerLayout = [WFDetailHeaderLayout new];
        _headerLayout.detailModel = detailModel;
        
        _currentNewsId = self.singleNewsModel.newsId;
        
        if ([_storeIdArray indexOfObject:self.singleNewsModel.newsId] == 0) {//如果是数组的第0个 说明已经没有上一条了
            _isHasPrevious = NO;
        }else{
            _isHasPrevious = YES;
        }
        
        if ([_storeIdArray indexOfObject:self.singleNewsModel.newsId] == _storeIdArray.count - 1) {//没有下一条了
            _isHasNext = NO;
        }else{
            _isHasNext = YES;
        }
        
        
        getFinish();
        
    } failure:^(WFError *error) {
        
    }];

}

- (void)getPreviousData:(getDataFinish)getFinish{
 
    NSInteger index = [_storeIdArray indexOfObject:_currentNewsId];
    
    if (--index >= 0) {
        
        NSString *previousId = [_storeIdArray objectAtIndex:index];
        
        if (index == 0) {//没有上一条了
            _isHasPrevious = NO;
        }else{
            _isHasPrevious = YES;
        }
        
        [WFManager wf_getNewsDetailWithID:previousId success:^(WFDetailNewsModel *detailModel) {
            
            _detailModel = detailModel;
            _headerLayout = [WFDetailHeaderLayout new];
            _headerLayout.detailModel = detailModel;
            _currentNewsId = _detailModel.newsId;
            
            getFinish();
            
        } failure:^(WFError *error) {
            
        }];

    }
}


- (void)getNextData:(getDataFinish)getFinish{

    NSInteger index = [_storeIdArray indexOfObject:_currentNewsId];
    
    if (++index < _storeIdArray.count) {
        
        NSString *nextId = [_storeIdArray objectAtIndex:index];
        
        if (index == _storeIdArray.count - 1) {//没有下一条了
            _isHasNext = NO;
        }else{
            _isHasNext = YES;
        }
        
        [WFManager wf_getNewsDetailWithID:nextId success:^(WFDetailNewsModel *detailModel) {
            
            _detailModel = detailModel;
            _headerLayout = [WFDetailHeaderLayout new];
            _headerLayout.detailModel = detailModel;
            _currentNewsId = _detailModel.newsId;
            
            getFinish();
            
        } failure:^(WFError *error) {
            
        }];
        
    }


}

- (WFDetailNewsModel *)detailSourceData{
  
    return _detailModel;

}

- (NSString *)loadWebViewHtml{

    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",_detailModel.cssType[0],_detailModel.newsBody];
 
}

- (WFDetailHeaderLayout *)detailHeaderLayout{

    return _headerLayout;
}

@end
