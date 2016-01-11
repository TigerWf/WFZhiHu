//
//  WFWebView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFDetailVM.h"

@protocol WFWebViewDelegate <NSObject>

@optional
/**
 *  点击图片触发事件
 *
 *  @param imageUrl 图片url
 */
- (void)clickActionOnImage:(NSString *)imageUrl;


/**
 *  点击超链接触发事件
 *
 *  @param linkUrl 链接url
 */
- (void)clickActionOnHyperlink:(NSString *)linkUrl;

@end

@interface WFWebView : UIWebView<UIWebViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, assign) id<WFWebViewDelegate>webDelegate;

@end
