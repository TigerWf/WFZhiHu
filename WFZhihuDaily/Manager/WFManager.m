//
//  WFManager.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFManager.h"
#import "WFHttpMgr.h"


WFReturnCode const WFReturnCodeSuccess = @"9001";
WFReturnCode const WFReturnCodeError = @"9999";

@implementation WFManager

#pragma mark - 单例

static WFManager *_instance;

+ (WFManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    return _instance;
}


+ (void)wf_baseReqWithMethod:(NSString *)method
                      urlStr:(NSString *)urlStr
                      params:(NSDictionary *)params
                     success:(wf_reqSuccessBlock)success
                     failure:(wf_reqFailureBlock)failure{
    
    if ([method isEqualToString:WFRequestGET]) {
        NSString *baseUrl = IP_HEADER;
        
        [WFHttpMgr getReqWithBaseUrlStr:baseUrl urlStr:urlStr params:nil success:^(id json) {
            if (success) {
                success(json);
            }
        } failure:^(NSError *error) {
            
            WFError *err = [WFError errorWithErrorCode:WFReturnCodeError errMsg:nil];
            if (failure) {
                
                failure(err);
            }
            
        }];
    }
    
    if ([method isEqualToString:WFRequestPOST]) {
        
        NSString *baseUrl = IP_HEADER;
        
        [WFHttpMgr postReqWithBaseUrlStr:baseUrl urlStr:urlStr params:params success:^(id json) {
            if (success) {
                success(json);
            }
        } failure:^(NSError *error) {
            
            WFError *err = [WFError errorWithErrorCode:WFReturnCodeError errMsg:nil];
            if (failure) {
                
                failure(err);
            }
            
        }];
        
    }
    
}

#pragma mark 调用api的公用方法
+ (void)wf_reqWithMethod:(NSString *)method
                  urlStr:(NSString *)urlStr
                  params:(NSDictionary *)params
                   class:(Class )cls
                 success:(wf_reqSuccessBlock)success
                 failure:(wf_reqFailureBlock)failure{
    
    [self wf_baseReqWithMethod:method urlStr:urlStr params:params success:^(id data) {
        if (cls == nil) {
            success(data);
        }else{
            success([cls objectWithKeyValues:data]);
     
        }

        
    } failure:failure];
}

@end

#pragma mark - 失败错误模型
@implementation WFError

- (NSString *)errMsgWithCode:(WFReturnCode)code {
    NSDictionary *errMsgDict = @{
                                 @"9001" : @"操作成功",                               
                                 @"9999" : @"未能连接到服务器，请稍后再试^_^",
                                
                                 };
    return errMsgDict[code];
}

- (instancetype)initWithErrorCode:(WFReturnCode)code {
    
    return [self initWithErrorCode:code errMsg:nil];
}

- (instancetype)initWithErrorCode:(WFReturnCode)code
                           errMsg:(NSString *)errMsg {
    self = [super init];
    if (self) {
        _code = code;
        _errMsg  = errMsg.length ? errMsg : [self errMsgWithCode:code];
    }
    return self;
}

+ (instancetype)errorWithErrorCode:(WFReturnCode)code
                            errMsg:(NSString *)errMsg {
    
    return [[self alloc] initWithErrorCode:code errMsg:errMsg];
}

@end
