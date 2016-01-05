//
//  WFManager.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//
#import <Foundation/Foundation.h>

@class WFError;
typedef void(^wf_reqSuccessBlock)(id data);
typedef void(^wf_reqFailureBlock)(WFError *error);

/**
 *  接口调用返回码
 */
typedef NSString * WFReturnCode;

/**
 *  操作成功
 */
extern WFReturnCode const WFReturnCodeSuccess;//9001
/**
 *  查询失败 操作失败
 */
extern WFReturnCode const WFReturnCodeError;//9999


@interface WFManager : NSObject

/**
 *  所有的对服务器的请求均调用该方法（该方法的成功回调会返回成功后的json数据中的data字段的信息，data的类型(一般为NSDictionary、NSArray等)请参考api文档）
 *
 *  @param method  get post
 *  @param urlStr  api url
 *  @param params  参数
 *  @param cls     模型类名
 *  @param success 成功回调block
 *  @param failure 失败回调block
 */
+ (void)wf_reqWithMethod:(NSString *)method
                  urlStr:(NSString *)urlStr
                  params:(NSDictionary *)params
                   class:(Class )cls
                 success:(wf_reqSuccessBlock)success
                 failure:(wf_reqFailureBlock)failure;

/**
 *  @param method  get post
 *  @param urlStr  api url
 *  @param params  参数
 *  @param success 成功回调block
 *  @param failure 失败回调block
 */
+ (void)wf_baseReqWithMethod:(NSString *)method
                      urlStr:(NSString *)urlStr
                      params:(NSDictionary *)params
                     success:(wf_reqSuccessBlock)success
                     failure:(wf_reqFailureBlock)failure;





@end


#pragma mark - 失败错误类
@interface WFError : NSObject

/**
 *  返回错误类实例
 *
 *  @param code   错误码
 *  @param errMsg 错误描述信息
 *
 *  @return 错误类实例
 */
+ (instancetype)errorWithErrorCode:(WFReturnCode)code errMsg:(NSString *)errMsg;

@property (nonatomic, copy, readonly) WFReturnCode code; // 返回码
@property (nonatomic, copy, readonly) NSString *errMsg; // 返回码对应的错误信息

@end