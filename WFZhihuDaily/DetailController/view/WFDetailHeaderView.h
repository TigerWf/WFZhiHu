//
//  WFDetailHeaderView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFDetailVM.h"
#import "WFWebView.h"

@interface WFDetailHeaderView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *imgSourceLab;
@property (nonatomic, weak) WFWebView *webView;

- (void)refreshHeaderView:(WFDetailVM *)viewModel;

- (void)wf_parallaxHeaderViewWithOffset:(CGFloat)offset;

@end
