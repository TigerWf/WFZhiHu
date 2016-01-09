//
//  WFWebView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFWebView.h"
#import "WFWebImageShowView.h"

@implementation WFWebView
{
    UITapGestureRecognizer  *tapGesture;//给webview添加单击手势
}
- (id)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        self.delegate = self;
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}


#pragma mark - UIGestureRecognizerDelegate -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if (gestureRecognizer == tapGesture){//如果是自定义的单击手势 返回yes
        return YES;
    }
    return NO;
}


#pragma mark - Override -
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


#pragma mark - Tap Action -
- (void)tapAction:(UITapGestureRecognizer *)gesture{
    
    CGPoint touchPoint = [gesture locationInView:self];
    [self getImage:touchPoint];
    
}

- (void)getImage:(CGPoint)pt{
    
    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", pt.x, pt.y];
    
    NSString * tagName = [self stringByEvaluatingJavaScriptFromString:js];
    DLog(@"tagName = %@",tagName);
    if ([tagName isEqualToString:@"IMG"]) {
        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
        NSString *urlToSave = [self stringByEvaluatingJavaScriptFromString:imgURL];
        NSLog(@"image url=%@", urlToSave);
        
        
        __block WFWebImageShowView *showImageView = [[WFWebImageShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) imageUrl:urlToSave];
        
        [showImageView show:[[UIApplication sharedApplication] keyWindow] didFinish:^{
            [showImageView removeFromSuperview];
            showImageView = nil;
            
        }];
    }

}

@end
