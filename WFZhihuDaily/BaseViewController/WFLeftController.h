//
//  WFLeftController.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftDrawerAction)(NSString *);

@interface WFLeftController : UIViewController

@property (nonatomic, strong) NSMutableArray *drawerSource;//数据源

@property (nonatomic, copy) LeftDrawerAction drawerAction;


@end
