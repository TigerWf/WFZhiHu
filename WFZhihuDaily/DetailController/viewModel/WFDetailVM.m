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
}
- (void)requestWebViewData:(getDataFinish)getFinish{
    
    [WFManager wf_getNewsDetailWithID:self.singleNewsModel.newsId success:^(WFDetailNewsModel *detailModel) {
        
        _detailModel = detailModel;
        _headerLayout = [WFDetailHeaderLayout new];
        _headerLayout.detailModel = detailModel;
        
        getFinish();
        
    } failure:^(WFError *error) {
        
    }];

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
