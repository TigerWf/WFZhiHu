//
//  WFLeftContainer.m
//  WFZhihuDaily
//
//  Created by 阿虎 on 16/1/9.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import "WFLeftContainer.h"

@implementation WFLeftContainer

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    CALayer *clickLayer = [CALayer layer];
    clickLayer.frame = CGRectMake(0, 0, 30, 30);
    clickLayer.cornerRadius = 15;
    clickLayer.position = point;
    clickLayer.opacity = 0.4f;
    [self.layer addSublayer:clickLayer];
    clickLayer.contents = (id)Image(@"leftClick.png").CGImage;
    
    DELAYEXECUTE(0.25, [clickLayer removeFromSuperlayer]);
    return YES;
}


@end
