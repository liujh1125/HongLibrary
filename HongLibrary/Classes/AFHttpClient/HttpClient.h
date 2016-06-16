//
//  APIClient.h
//  ChunYu
//
//  Created by SF/Liu on 15/8/6.
//  Copyright (c) 2015年 LingShang Lt.Co. All rights reserved.
//

#import "AFHTTPSessionManager.h"


#define POST_CONNECT    @"POST"
#define GET_CONNECT     @"GET"
#define PUT_CONNECT     @"PUT"
#define HEAD_CONNECT    @"HEAD"
#define DELETE_CONNECT  @"DELETE"
#define PATCH_CONNECT   @"PATCH"




@interface HttpClient : AFHTTPSessionManager

@property (nonatomic) BOOL networkEnable;
@property (nonatomic, strong) NSMutableArray *networkOperations;

+ (instancetype)sharedClient;

+ (NSError *)formatAFHTTPRequestOperation:(NSURLSessionTask *)operation error:(NSError *)error;
- (void)cancelAllSessionDataTask;

- (NSURLSessionDataTask*)Connect:(NSString*)CType
                             URL:(NSString*)URLString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * progress))progress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


- (NSURLSessionUploadTask*)UploadFileConnect:(NSString*)CType
                                         URL:(NSString*)URLString
                                        file:(id)imageOrFile
                                    progress:(void (^)(NSProgress * progress))progress
                                     success:(void (^)(NSURLResponse *responseObj, id responseObject))success
                                     failure:(void (^)(NSURLResponse *task, NSError *error))failure;



@end
