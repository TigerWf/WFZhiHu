//
//  WFDetailHeaderLayout.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDetailHeaderLayout.h"

@implementation WFDetailHeaderLayout

- (void)setDetailModel:(WFDetailNewsModel *)detailModel{

    _imageViewRect = CGRectMake(0.f, 0.f, kScreenWidth, 300.f);
    
    NSDictionary *attributesDic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size = [detailModel.newsTitle boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 60) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributesDic context:nil].size;
    _titleLblRect = CGRectMake(15.f, 260 - 20.f - size.height, kScreenWidth - 30.f, size.height);
    
    _imgSourceLabRect = CGRectMake(10, 240, kScreenWidth - 20, 20);
    
    _titleLblString = [[NSAttributedString alloc] initWithString:detailModel.newsTitle attributes:attributesDic];
    
    _imgSourceString = [NSString stringWithFormat:@"图片: %@",detailModel.imageSource];
    
    _imageUrl = detailModel.imageUrl;
}


@end
