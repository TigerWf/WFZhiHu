//
//  WFMainViewCell.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFSingelNewsModel.h"
#import "WFSingelNewsLayout.h"

@interface WFMainViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *newsImageView;

@property (nonatomic, strong) UILabel     *newsTitleLbl;

@property (nonatomic, strong) WFSingelNewsLayout *singleNewsLayout;

@end
