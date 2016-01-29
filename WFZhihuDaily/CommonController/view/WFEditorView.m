//
//  WFEditorView.m
//  WFZhihuDaily
//
//  Created by wfh on 16/1/29.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFEditorView.h"
#import "WFEditorModel.h"

@implementation WFEditorView

- (id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 40, 40)];
    titleLabel.text = @"主编";
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:titleLabel];
    
    UIImageView *arrowsImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 35, 12, 15, 15)];
    arrowsImage.image = Image(@"leftEnter.png");
    [self addSubview:arrowsImage];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];

}


#pragma mark - Setter - 
- (void)setAvatarImageArr:(NSArray *)avatarImageArr{
  
    float braBtnX = 60;
    
    for (WFEditorModel *editor in avatarImageArr) {
        
        UIImageView *avatarImg = [[UIImageView alloc ] init];
        avatarImg.frame = CGRectMake(braBtnX, 8, 24, 24);
        braBtnX += (12 + 24);
        avatarImg.backgroundColor = [UIColor whiteColor];
        
        if ((kScreenWidth - braBtnX) <= 12) {
           
            return;
        }
        avatarImg.layer.cornerRadius = 12;
        avatarImg.clipsToBounds = YES;
        [avatarImg wf_setImageWithUrlString:editor.editorAvatar placeholderImage:Image(@"tags_selected.png")];
        [self addSubview:avatarImg];

    }
  
}

@end
