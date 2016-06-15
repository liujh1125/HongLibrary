//
//  APIClient.m
//  ChunYu
//
//  Created by SF/Liu on 15/8/6.
//  Copyright (c) 2015年 LingShang Lt.Co. All rights reserved.
//

#import "HttpClient.h"
#include <HongLibrary.h>

@implementation HttpClient


+ (instancetype)sharedClient{
    static HttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HttpClient alloc] init];
        _sharedClient.requestSerializer.timeoutInterval = 40.0f;
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"charset=UTF-8", @"application/json", nil];
        _sharedClient.networkOperations = [[NSMutableArray alloc] init];
    });
    return _sharedClient;
}



+ (NSError *)formatAFHTTPRequestOperation:(NSURLSessionDataTask *)dataTask error:(NSError *)error
{
    NSString *errMsg = @"";
    if (error) {
        if (error.code == kCFURLErrorNotConnectedToInternet)
        {
            errMsg = @"网络中断";       //无网络或者网络中断
        }
        else if (error.code == kCFURLErrorTimedOut)
        {
            errMsg = @"请求超时";      //网络请求超时
        }
        else if (error.code == kCFURLErrorCannotConnectToHost || error.code == kCFURLErrorCannotFindHost || error.code == kCFURLErrorBadURL || error.code == kCFURLErrorNetworkConnectionLost)
        {
            errMsg = @"无法连接服务器"; //无法连接服务器
        }
        else if (error.code == 400)
        {
            errMsg = @"请求格式错误";
        }
        else if (error.code == 403)
        {
            errMsg = @"鉴权成功，但是该用户没有权限";
        }
        else if (error.code == 404)
        {
            errMsg = @"请求的资源不存在";
        }
        else if (error.code == 404)
        {
            errMsg = @"请求的资源不存在";
        }
        else if (error.code == kCFURLErrorBadServerResponse)
        {
            errMsg = @"损坏的服务器响应";
        }
        else
        {
            errMsg = @"未知错误";      //未知的网络错误码
        }
    }
    else
    {
        errMsg = @"接口返回错误";  //  id responseObject = dataTask.response;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[error userInfo]];
    [userInfo setObject:errMsg forKey:NSLocalizedFailureReasonErrorKey];
    NSError *formattedError = [[NSError alloc] initWithDomain:NSOSStatusErrorDomain code:error.code userInfo:userInfo];
    return formattedError;
}

- (NSURLSessionDataTask*)Connect:(NSString*)CType
                             URL:(NSString*)URLString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * progress))progress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSLog(@"\nHttp Request Send：%@ \n参数：%@",URLString,parameters);

    NSURLSessionDataTask *dataTask = nil;
    if ([CType isEqualToString:POST_CONNECT])
    {
        dataTask = [super POST:URLString parameters:parameters progress:^(NSProgress * uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * task, id responseObject) {
            if (success) {
                success(task,responseObject);
            }
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            if (failure) {
                failure(task,error);
            }
        }];
    }
    else if ([CType isEqualToString:GET_CONNECT])
    {
        dataTask = [super GET:URLString parameters:parameters progress:^(NSProgress * downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * task, id responseObject) {
            if (success) {
                success(task,responseObject);
            }
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            if (failure) {
                failure(task,error);
            }
        }];
    }
    else if ([CType isEqualToString:PUT_CONNECT])
    {
        dataTask = [super PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task,error);
            }
        }];
    }
    else if ([CType isEqualToString:HEAD_CONNECT])
    {
        dataTask = [super HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
            if (success) {
                success(task,@"");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task,error);
            }
        }];
    }
    else if ([CType isEqualToString:DELETE_CONNECT])
    {
        dataTask = [super DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task,error);
            }
        }];
    }
    else if ([CType isEqualToString:PATCH_CONNECT])
    {
        dataTask = [super PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task,error);
            }
        }];
    }
    
    [self.networkOperations addObject:dataTask];
    
    return dataTask;
}


- (NSURLSessionUploadTask*)UploadFileConnect:(NSString*)CType
                                         URL:(NSString*)URLString
                                        file:(id)imageOrFile
                                    progress:(void (^)(NSProgress * progress))progress
                                     success:(void (^)(NSURLResponse *responseObj, id responseObject))success
                                     failure:(void (^)(NSURLResponse *task, NSError *error))failure {
    
    NSString *boundary = [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:40];
    NSData * imagedata = UIImageJPEGRepresentation(imageOrFile,1.0);
    
    NSURLSessionUploadTask *uploadtask = [super uploadTaskWithRequest:request
                                                             fromData:imagedata
                                                             progress:^(NSProgress * _Nonnull uploadProgress) {
                                                                 
                                                             } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                 
                                                                 NSLog(@"文件上传： response = %@  \n responseObject = %@ \n error = %@",response,responseObject,error);
                                                                 
                                                                 if (error) {
                                                                     if (failure) {
                                                                         failure(response,error);
                                                                     }
                                                                 }else{
                                                                     if (success) {
                                                                         success(response,responseObject);
                                                                     }
                                                                 }
                                                             }];
    [uploadtask resume];
    
    return uploadtask;
}


-(void)cancelAllSessionDataTask{
    for (NSURLSessionDataTask *dataTask in self.networkOperations) {
        [dataTask cancel];
    }
    [self.networkOperations removeAllObjects];
}



@end
