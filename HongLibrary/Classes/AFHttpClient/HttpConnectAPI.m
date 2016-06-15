//
//  APIModel
//
//
//  Created by LiuJh on 14-7-4.
//  Copyright (c) 2015年 Ling Shang. All rights reserved.
//

#import "HttpConnectAPI.h"
#import "HongLibrary.h"
#import "NSDate+Ext.h"
#import "NSString+Extrens.h"
#import "HttpClient.h"

/**
 *网络异常
 */
#define kNetworkBroken      @"网络连接失败，请检查你的网络设置"
#define kServerUnavailable  @"访问网络数据超时，请稍后重试"
#define kCannotConnectToHost @"无法连接服务器，请稍后重试"
#define kServerUnCode @"访问服务器异常，请稍后重试"
#define kServerUnmessage @"服务器返回未知错误信息"
#define kNerworkWait  @"网络请求中..."


@implementation HttpConnectAPI



+ (void)settingHeaders{

//    [[MYAPIClient sharedClient].requestSerializer setValue:valStr forHTTPHeaderField:@"eh_valid"];

    
}


+ (void)APIGET:(NSString *)URLString parameters:(id)parameters success:(void (^)(HttpConnectAPI *model))success failure:(void (^)(NSError *error))failure{

//    NSMutableDictionary *dictionary = [HttpClient creatAPIDictionary];
//    [dictionary addEntriesFromDictionary:parameters];
    
    [[HttpClient sharedClient] Connect:GET_CONNECT URL:URLString parameters:parameters
                              progress:^(NSProgress *progress) {
                                  
                              } success:^(NSURLSessionDataTask *task, id responseObject) {
                                  NSError *error;
                                  HttpConnectAPI *receiveModel = [[HttpConnectAPI alloc] initWithDictionary:responseObject error:&error];
                                  if (error) {
                                      if (failure) {
                                          failure(error);
                                      }
                                  }else {
                                      if(success){
                                          success(receiveModel);
                                      }
                                  }
                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                  NSError *formatError = [HttpClient formatAFHTTPRequestOperation:task error:error];
                                  if (failure) {
                                      failure(formatError);
                                  }
                              }];
}



+ (void)APIPOST:(NSString *)URLString parameters:(id)parameters success:(void (^)(HttpConnectAPI *model))success failure:(void (^)(NSError *error))failure{
    
//    NSMutableDictionary *dictionary = [HttpClient creatAPIDictionary];
//    [dictionary addEntriesFromDictionary:parameters];
    
    [[HttpClient sharedClient] Connect:POST_CONNECT URL:URLString parameters:parameters
                              progress:^(NSProgress *progress) {
                                  
                              } success:^(NSURLSessionDataTask *task, id responseObject) {
                                  NSError *error;
                                  HttpConnectAPI *receiveModel = [[HttpConnectAPI alloc] initWithDictionary:responseObject error:&error];
                                  if (error) {
                                      if (failure) {
                                          failure(error);
                                      }
                                  }else {
                                      if(success){
                                          success(receiveModel);
                                      }
                                  }
                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                  NSError *formatError = [HttpClient formatAFHTTPRequestOperation:task error:error];
                                  NSLog(@"接口失败返回:%@ \n %@",task.response.URL.absoluteString,formatError);
                                  if (failure) {
                                      failure(formatError);
                                  }
                              }];
}



@end
