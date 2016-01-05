//
//  UIImageView+WFImg.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WFWebImageCompletionWithFinishedBlock)(UIImage *image);

@interface UIImageView (WFImg)

- (void)wf_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeHolderImage;

@end
