//
//  WFCommonVM.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFThemeModel.h"
#import "WFThemeNewsModel.h"
#import "WFSingelNewsLayout.h"

typedef void(^getDataFinish)();//失败暂时还没处理

@interface WFCommonVM : NSObject

@property (nonatomic, strong) WFThemeModel *themeModel;
@property (nonatomic, strong) WFThemeNewsModel *themeNewsModel;

- (void)requestLatestNewsData:(getDataFinish)getFinish;
- (void)requestPreviousNewsData:(getDataFinish)getFinish;

- (WFSingelNewsLayout *)singleNewsAtIndexPath:(NSIndexPath *)indexPath;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;

@end
