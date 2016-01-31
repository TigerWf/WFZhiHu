//
//  WFRefreshView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFRefreshView.h"

@interface WFRefreshView ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) CGFloat progress;

@end


@implementation WFRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_indicatorView];
        _indicatorView.hidden = YES;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    if (self.progress == 0) {
        return;
    }

    CGFloat radius = (self.width - 5) / 2;
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGFloat endAngle =  2 * M_PI * self.progress;
    CGContextAddArc(context2, self.width / 2, self.width / 2, radius, 0, endAngle, 0);
    [[UIColor whiteColor] set];
    CGContextStrokePath(context2);
    
}


- (void)circleDependProgress:(CGFloat)progress {
    
    if (progress > 1) {
        return;
    }
   
    self.progress = progress;
    [self setNeedsDisplay];
    
}

- (void)startAnimation {
    
    [_indicatorView startAnimating];
}

- (void)stopAnimation {
    
    [_indicatorView stopAnimating];
}
@end
