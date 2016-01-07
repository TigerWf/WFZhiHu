//
//  WFWebView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFWebView.h"

@implementation WFWebView

- (id)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    if (event.type == UIEventTypeTouches) {
        
        NSSet *touches = [event touchesForView:self];
        UITouch *touch = [touches anyObject];
        
        if (touch.phase == UITouchPhaseBegan) {
            
            [self addGestureRecognizer:self.scrollView.panGestureRecognizer];
        }
    }
    return [super hitTest:point withEvent:event];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    DLog(@"finish");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    DLog(@"request.URL = %@",request.URL);
    return YES;

}

@end
