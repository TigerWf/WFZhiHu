//
//  WFLatestNewsModel.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFSingelNewsModel.h"

@interface WFLatestNewsModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSMutableArray *storiesArray;
@property (nonatomic, strong) NSMutableArray *topStoriesArray;


@end
