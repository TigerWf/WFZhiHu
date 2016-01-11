//
//  XPToolKit.h
//  SeekClient
//
//  Created by origin on 14/10/20.
//  Copyright (c) 2014年 Dorigin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBottomTag 9999

typedef NS_ENUM(NSInteger, SharePlatform) {
    SharePlatformWeChat = 1, // 微信
    SharePlatformWeChatFriends,// 微信朋友圈
    SharePlatformQQ, // qq
    SharePlatformSinaWeibo, // 新浪微博
    SharePlatformCopyLink, // 复制链接
    SharePlatformMail, // 邮件
    SharePlatformYouDao, // 有道云
    SharePlatformYinXiang,//印象笔记
    SharePlatformTencentWeibo,//腾讯微博
    SharePlatformMessage,//信息
    SharePlatformInstapaper,//Instapaper
    SharePlatformTwitter,//推特
    SharePlatformRenRen,//人人
};

UIColor *RGBColor(float R,float G,float B,float A);

void setExtraCellLineHidden(UITableView *tableView);

//bundle图片加载
extern UIImage* Image(NSString* imageName);
