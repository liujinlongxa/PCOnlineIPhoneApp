//
//  LJNetWorking.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface LJNetWorkingTool : NSObject

/**
 *  GET请求
 *
 *  @param URLString  url地址
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)URLString
            parameters:(id)parameters
            success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
            failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

/**
 *  Post请求
 *
 *  @param URLString  url地址
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)URLString
            parameters:(id)parameters
            success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
            failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

/**
 *  返回NetworkTool单例对象
 */
+ (instancetype)shareNetworkTool;

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
 */
- (float)currnetCacheSize;

/**
 *  开始监听网络连接错误
 */
- (void)startObserverNetworkError;

/**
 *  是否可以访问网络
 */
@property (nonatomic, assign, getter=isCanReachInternet) BOOL canReachInternet;
@end
