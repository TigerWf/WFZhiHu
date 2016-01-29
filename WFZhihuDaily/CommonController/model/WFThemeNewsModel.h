//
//  WFThemeNewsModel.h
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFThemeNewsModel : NSObject

// /暂时只用到接口中的这三个key
@property(nonatomic, copy) NSString *background;
@property(nonatomic, copy) NSArray *editors;
@property(nonatomic, copy) NSArray *stories;

@end
