//
//  SCBModel.h
//  zlds
//
//  Created by GuoChengHao on 14-7-4.
//  Copyright (c) 2014年 qt. All rights reserved.
//

#import "JSONModel.h"


@interface  HttpConnectAPI : JSONModel



+ (void)APIGET:(NSString *)URLString parameters:(id)parameters success:(void (^)(HttpConnectAPI *model))success failure:(void (^)(NSError *error))failure;

+ (void)APIPOST:(NSString *)URLString parameters:(id)parameters success:(void (^)(HttpConnectAPI *model))success failure:(void (^)(NSError *error))failure;

@end
