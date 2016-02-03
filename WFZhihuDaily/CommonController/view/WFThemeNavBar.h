//
//  WFThemeNavBar.h
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFThemeNavBar : UIImageView

@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, strong) UIImage     *blurImage;
/**
 *  添加下拉表头的动画
 *
 *  @param offset 偏移量
 *
 */
- (void)wf_parallaxHeaderViewWithOffset:(CGFloat)offset;

@end
