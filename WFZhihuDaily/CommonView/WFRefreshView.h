//
//  WFRefreshView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFRefreshView : UIView

- (void)circleDependProgress:(CGFloat)progress;
- (void)startAnimation;
- (void)stopAnimation;

@end
