//
//  WFSharePanelView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/11.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const WFSharePlatformWeChat; //微信好友
UIKIT_EXTERN NSString * const WFSharePlatformWeChatFriends; //微信朋友圈
UIKIT_EXTERN NSString * const WFSharePlatformSinaWeibo; // 新浪微博
UIKIT_EXTERN NSString * const WFSharePlatformQQ; // qq
UIKIT_EXTERN NSString * const WFSharePlatformCopyLink; // 复制链接
UIKIT_EXTERN NSString * const WFSharePlatformMail; // 邮件
UIKIT_EXTERN NSString * const WFSharePlatformYouDao; // 有道云
UIKIT_EXTERN NSString * const WFSharePlatformYinXiang;//印象笔记
UIKIT_EXTERN NSString * const WFSharePlatformTencentWeibo;//腾讯微博
UIKIT_EXTERN NSString * const WFSharePlatformMessage;//信息
UIKIT_EXTERN NSString * const WFSharePlatformInstapaper;//Instapaper
UIKIT_EXTERN NSString * const WFSharePlatformTwitter;//推特
UIKIT_EXTERN NSString * const WFSharePlatformRenRen;//人人
UIKIT_EXTERN NSString * const WFSharePlatformNULL; //NUll

typedef void(^ClickActionBlock)(SharePlatform);
/**
 *  分享面板
 */
@interface WFSharePanelView : UIView<UIScrollViewDelegate>

@property (nonatomic, copy)   ClickActionBlock actionBlock;
@property (nonatomic, strong) UIView *whitePanel;

/**
 *  单例
 *
 *  @return 单例
 */
+ (WFSharePanelView *)sharedManager;


/**
 *  弹出分享视图
 *  @param hasStore      是否有收藏按钮
 *  @param actionBlock   点击对应平台按钮的回调
 *  @param platformTitle 对应平台 请传WFSharePlatformWeChat/WFSharePlatformWeChatFriends 如果增多 请自行添加并添加_platformDict字典
 */
- (void)showSharePanelHasStore:(BOOL)hasStore
                       byClick:(ClickActionBlock)actionBlock
                  withPlatform:(NSString *)platformTitle,...NS_REQUIRES_NIL_TERMINATION;


@end
