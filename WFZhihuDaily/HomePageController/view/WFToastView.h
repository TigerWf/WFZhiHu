//
//  WFToastView.h
//  WFZhihuDaily
//
//  Created by 阿虎 on 16/1/9.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  弹出toast视图
 */
@interface WFToastView : UIView

{
    UIFont *msgFont;
}
@property (nonatomic, copy)   NSString *msg;
@property (nonatomic, retain) UILabel  *labelText;
@property (nonatomic, assign) float leftMargin;
@property (nonatomic, assign) float topMargin;
@property (nonatomic, assign) float animationLeftScale;
@property (nonatomic, assign) float animationTopScale;
@property (nonatomic, assign) float totalDuration;

+ (void)showMsg:(NSString *)msg inView:(UIView*)theView;


@end
