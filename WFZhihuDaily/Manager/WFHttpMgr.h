//
//  WFHttpMgr.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"


// 网络访问的回调block预定义
typedef void(^HttpRequestSuccessBlock)(id json);
typedef void(^HttpRequestFailureBlock)(NSError *error);

@interface WFHttpMgr : NSObject

/**
 *  post请求
 *
 *  @param baseUrlStr 基准url
 *  @param urlStr     urlstr
 *  @param params     参数
 *  @param success    成功回调block
 *  @param failure    失败回调block
 */
+ (void)postReqWithBaseUrlStr:(NSString *)baseUrlStr
                       urlStr:(NSString *)urlStr
                       params:(NSDictionary *)params
                      success:(HttpRequestSuccessBlock)success
                      failure:(HttpRequestFailureBlock)failure;

/**
 *  get请求baseUrlStr ＋ urlStr
 *
 *  @param baseUrlStr 基准urlStr
 *  @param urlStr     url
 *  @param params     参数
 *  @param success    成功回调block
 *  @param failure    失败回调block
 */
+ (void)getReqWithBaseUrlStr:(NSString *)baseUrlStr
                      urlStr:(NSString *)urlStr
                      params:(NSDictionary *)params
                     success:(HttpRequestSuccessBlock)success
                     failure:(HttpRequestFailureBlock)failure;


/**
 *  文件下载
 *
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
+ (void)downloadFileWithInferface:(NSString*)requestURL
                        savedPath:(NSString*)savedPath
                  downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                         progress:(void (^)(float progress))progress;

@end
