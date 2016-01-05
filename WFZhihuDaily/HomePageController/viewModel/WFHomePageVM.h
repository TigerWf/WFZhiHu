//
//  WFHomePageVM.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFManager+MainViewInfo.h"
#import "WFSingelNewsLayout.h"

typedef void(^getDataFinish)();

@interface WFHomePageVM : NSObject

- (void)requestLatestNewsData:(getDataFinish)getFinish;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (WFSingelNewsLayout *)singleNewsAtIndexPath:(NSIndexPath *)indexPath;

@end
