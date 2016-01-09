//
//  WFWebImageShowView.h
//  WFZhihuDaily
//
//  Created by 阿虎 on 16/1/9.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didRemoveImage)(void);

@interface WFWebImageShowView : UIView<UIScrollViewDelegate>

@property (nonatomic,copy) didRemoveImage removeImg;

/**
 *  展现
 *
 *  @param bgView    展现所在的视图
 *  @param tempBlock 移除自身的回调
 */
- (void)show:(UIView *)bgView didFinish:(didRemoveImage)tempBlock;


/**
 *  初始化
 *
 *  @param frame       大小
 *  @param imageUrl    图片url
 *
 *  @return id
 */
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl;


@end
