//
//  WFDetailHeaderLayout.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFDetailNewsModel.h"

@interface WFDetailHeaderLayout : NSObject

@property (nonatomic, strong) WFDetailNewsModel *detailModel;

@property (nonatomic, assign) CGRect titleLblRect;

@property (nonatomic, assign) CGRect imageViewRect;

@property (nonatomic, assign) CGRect imgSourceLabRect;

@property (nonatomic, copy) NSAttributedString *titleLblString;

@property (nonatomic, copy) NSString *imgSourceString;

@property (nonatomic, copy) NSString *imageUrl;

@end
