//
//  LJNetWorking.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface LJNetWorking : NSObject

+ (void)GET:(NSString *)URLString
            parameters:(id)parameters
            success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
            failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

+ (void)POST:(NSString *)URLString
            parameters:(id)parameters
            success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
            failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

//- (AFHTTPRequestOperation *)POST:(NSString *)URLString
//    parameters:(id)parameters
//    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (instancetype)shareNetwork;

//监测网络状态
- (void)startMonitorNetwork;
@end
