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

+ (void)GET:(NSString *)URLString
    parameters:(id)parameters
    success:(void (^)(NSHTTPURLResponse *, id))success
    failure:(void (^)(NSHTTPURLResponse *, NSError *))failure
    andView:(UIView *)view;

//- (AFHTTPRequestOperation *)POST:(NSString *)URLString
//    parameters:(id)parameters
//    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (instancetype)shareNetwork;

/**
 *  开始检测网络状态
 */
- (void)startMonitorNetwork;

/**
 *  清空缓存
 */
- (void)cleanCache;
/**
 *  获取当前缓存
 *
 *  @return <#return value description#>
 */
- (NSUInteger)currnetCacheSize;

@end
