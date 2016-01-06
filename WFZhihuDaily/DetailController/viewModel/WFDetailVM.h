//
//  WFDetailVM.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFSingelNewsModel.h"
#import "WFDetailNewsModel.h"
#import "WFDetailHeaderLayout.h"

typedef void(^getDataFinish)();

@interface WFDetailVM : NSObject

@property (nonatomic, strong) WFSingelNewsModel *singleNewsModel;

- (void)requestWebViewData:(getDataFinish)getFinish;

- (WFDetailNewsModel *)detailSourceData;

- (NSString *)loadWebViewHtml;

- (WFDetailHeaderLayout *)detailHeaderLayout;

@end
