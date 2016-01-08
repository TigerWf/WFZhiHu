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

typedef void(^getDataFinish)();//失败暂时还没处理

@interface WFHomePageVM : NSObject

@property(copy,nonatomic)NSString *currentDay;
/**
 *  存放内容id的数组
 */
@property(strong,nonatomic) NSMutableArray *newsIdArray;

- (void)requestLatestNewsData:(getDataFinish)getFinish;
- (void)requestPreviousNewsData:(getDataFinish)getFinish;


- (NSAttributedString *)headerTitleForSection:(NSInteger)section;

- (NSString *)dateOfSections:(NSUInteger)section;

- (NSUInteger)numberOfSections;

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;

- (WFSingelNewsLayout *)singleNewsAtIndexPath:(NSIndexPath *)indexPath;

- (NSMutableArray *)getAutoLoopData;

@end
