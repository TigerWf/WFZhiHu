//
//  WFOutsideWebBottomBarView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WFOutsideWebBottomBarDelegate <NSObject>

@optional

- (void)selectBtn:(UIButton *)button;

@end

@interface WFOutsideWebBottomBarView : UIView

@property (nonatomic,assign) id<WFOutsideWebBottomBarDelegate>delegate;

@end
