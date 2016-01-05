//
//  WFHttpMgr.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFHttpMgr.h"
#import <AFNetworking/AFNetworking.h>

@implementation WFHttpMgr

#pragma mark 网络请求的方法

/**
 *  网络请求的方法（支持post、get等请求方式），请求超时时间为20s
 *
 *  @param method     请求方式（post、get等）
 *  @param baseUrlStr 基准路径
 *  @param urlStr     请求路径
 *  @param params     参数
 *  @param success    成功回调block
 *  @param failure    失败回调block
 */
+ (void)requestWithMethod:(NSString *)method
               baseUrlStr:(NSString *)baseUrlStr
                   urlStr:(NSString *)urlStr
                   params:(NSDictionary *)params
                  success:(HttpRequestSuccessBlock)success
                  failure:(HttpRequestFailureBlock)failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = WFTimeoutInterval;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrlStr,urlStr] relativeToURL:manager.baseURL] absoluteString] parameters:params error:nil];
    
    
    // 网络指示器开始显示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        // 网络指示器结束显示
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         DLog(@"错误信息 : %@", error);
        if (failure) {
            failure(error);
        }
        // 网络指示器结束显示
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    [manager.operationQueue addOperation:operation];
}



#pragma mark post请求
+ (void)postReqWithBaseUrlStr:(NSString *)baseUrlStr
                       urlStr:(NSString *)urlStr
                       params:(NSDictionary *)params
                      success:(HttpRequestSuccessBlock)success
                      failure:(HttpRequestFailureBlock)failure {
   
        [self requestWithMethod:@"POST" baseUrlStr:baseUrlStr urlStr:urlStr params:params success:success failure:failure];
    
}

#pragma mark get baseUrlStr ＋ urlStr请求
+ (void)getReqWithBaseUrlStr:(NSString *)baseUrlStr
                      urlStr:(NSString *)urlStr
                      params:(NSDictionary *)params
                     success:(HttpRequestSuccessBlock)success
                     failure:(HttpRequestFailureBlock)failure {
    [self requestWithMethod:@"GET" baseUrlStr:baseUrlStr urlStr:urlStr params:params success:success failure:failure];
}


+ (void)downloadFileWithInferface:(NSString*)requestURL
                        savedPath:(NSString*)savedPath
                  downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                         progress:(void (^)(float progress))progress{
    
    NSString *totalUrl = [NSString stringWithFormat:@"%@%@",IP_HEADER,requestURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:totalUrl]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        DLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
        
        DLog(@"下载失败");
        
    }];
    
    [operation start];
    
}


+ (void)downLoadWithUrl:(NSString *)URLString
                success:(HttpRequestSuccessBlock)success
                failure:(HttpRequestFailureBlock)failure{
    
    if (URLString.length>0){
        
        NSString *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *zipName = [[URLString componentsSeparatedByString:@"/"] lastObject];
        NSString *path = [paths stringByAppendingPathComponent:zipName];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
            DLog(@"Successfully downloaded file to %@", responseObject);
            success(zipName);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }];
        [operation start];
    }
    
}



@end
