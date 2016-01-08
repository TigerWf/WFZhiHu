//
//  WFDetailHeaderView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDetailHeaderView.h"

@implementation WFDetailHeaderView

- (id)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor redColor];
        [self configUI];
    }
    return self;
}

- (void)configUI{

    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLab.numberOfLines = 0;
    [self addSubview:_titleLab];
    
    _imgSourceLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _imgSourceLab.textAlignment = NSTextAlignmentRight;
    _imgSourceLab.font = [UIFont systemFontOfSize:12];
    _imgSourceLab.textColor = [UIColor whiteColor];
    [self addSubview:_imgSourceLab];

}

- (void)refreshHeaderView:(WFDetailVM *)viewModel{

    _imageView.frame    = [[viewModel detailHeaderLayout] imageViewRect];
    _titleLab.frame     = [[viewModel detailHeaderLayout] titleLblRect];
    _imgSourceLab.frame = [[viewModel detailHeaderLayout] imgSourceLabRect];
    
    [_imageView wf_setImageWithUrlString:[[viewModel detailHeaderLayout] imageUrl] placeholderImage:Image(@"tags_selected.png")];
    _titleLab.attributedText = [[viewModel detailHeaderLayout] titleLblString];
    _imgSourceLab.text = [[viewModel detailHeaderLayout] imgSourceString];

    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (event.type == UIEventTypeTouches) {
        
        NSSet *touches = [event touchesForView:self];
        UITouch *touch = [touches anyObject];
        
        if (touch.phase == UITouchPhaseBegan) {
           [self addGestureRecognizer:_webView.scrollView.panGestureRecognizer];
        }
    }
    return [super hitTest:point withEvent:event];
}


- (void)wf_parallaxHeaderViewWithOffset:(CGFloat)offset{
    
     self.frame = CGRectMake(0, -40 - offset/2, kScreenWidth, 260 - offset/2);
    
     [_imgSourceLab setTop:240 - offset/2];
     [_titleLab setBottom:_imgSourceLab.bottom - 20];
}

@end
