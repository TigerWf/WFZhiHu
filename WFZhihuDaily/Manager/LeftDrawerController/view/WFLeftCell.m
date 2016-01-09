//
//  WFLeftCell.m
//  WFZhihuDaily
//
//  Created by 阿虎 on 16/1/5.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import "WFLeftCell.h"

@implementation WFLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // cell不可以选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBColor(35, 42, 48, 1.0);
        [self configUI];
        
    }
    return self;
}

- (void)configUI{

    _subfieldLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, 44)];
    _subfieldLbl.textColor = [UIColor whiteColor];
    _subfieldLbl.font = [UIFont systemFontOfSize:16];
    _subfieldLbl.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_subfieldLbl];
    
    
    _arrowsImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * kDrawerRatio - 55, 13, 15, 18)];
    _arrowsImage.image = Image(@"leftEnter.png");
    [self.contentView addSubview:_arrowsImage];

}


- (void)setLeftDataString:(NSString *)leftDataString{
    
    _subfieldLbl.text = leftDataString;

}

@end
