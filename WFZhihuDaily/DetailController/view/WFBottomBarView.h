//
//  WFBottomBarView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WFBottomBarDelegate <NSObject>

@optional
- (void)selectBtn:(UIButton *)button;

@end

@interface WFBottomBarView : UIView

@property (nonatomic,assign) id<WFBottomBarDelegate>delegate;

@end
