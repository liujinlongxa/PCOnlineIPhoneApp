//
//  LJNetWorking.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNetWorkingTool.h"
#import "Reachability.h"
#import "LJCommonHeader.h"
#import "MBProgressHUD+LJProgressHUD.h"
#import "AppDelegate.h"

static LJNetWorkingTool * instance;

@interface LJNetWorkingTool ()

/**
 *  是否可以访问网络
 */
@property (nonatomic, assign, getter=isCanReachInternet) BOOL canReachInternet;

/**
 *  用于检测网络状态的第三方框架
 */
@property (nonatomic, strong) Reachability * networkReachability;
@end

@implementation LJNetWorkingTool


#pragma mark - moniter network
/**
 *  单例对象
 */
+ (instancetype)shareNetworkTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LJNetWorkingTool alloc] init];
    });
    return instance;
}

/**
 *  开始监听网络状态
 */
- (void)startMonitorNetwork
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange:) name:kReachabilityChangedNotification object:nil];
    
    self.networkReachability = [Reachability reachabilityForInternetConnection];
    if (self.networkReachability.currentReachabilityStatus == NotReachable)
    {
        LJLog(@"Change network status not reaceh");
        self.canReachInternet = NO;
    }
    else
    {
        LJLog(@"Change network status reaceh");
        self.canReachInternet = YES;
    }
    
    //开始监听
    [self.networkReachability startNotifier];
    
}

/**
 *  网络状态发生变化回调
 *
 *  @param notify 通知对象
 */
- (void)networkStatusChange:(NSNotification *)notify
{
    Reachability * reach = notify.object;
    NSParameterAssert([reach isKindOfClass:[Reachability class]]);
    [self updateNetworkStatus:reach];
}

/**
 *  更新网络状态
 *
 *  @param reach 新的网络状态
 */
- (void)updateNetworkStatus:(Reachability *)reach
{
    NetworkStatus status = reach.currentReachabilityStatus;
    if (status == NotReachable)
    {
        LJLog(@"Change network status not reaceh : %d", status);
        AppDelegate * dele = [UIApplication sharedApplication].delegate;
        [MBProgressHUD showNotificationMessage:@"网络连接已断开" InView:dele.window];
        self.canReachInternet = NO;
    }
    else
    {
        LJLog(@"Change network status reaceh : %d", status);
        self.canReachInternet = YES;
    }
}

#pragma mark - url cache
/**
 *  清空缓存
 */
- (void)cleanCache
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

/**
 *  获取当前缓存大小
 *
 *  @return 当前缓存大小（byte）
 */
- (NSUInteger)currnetCacheSize
{
    return [[NSURLCache sharedURLCache] currentDiskUsage];
}

#pragma mark - http method GET,POST
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSHTTPURLResponse *, id))success failure:(void (^)(NSHTTPURLResponse *, NSError *))failure andView:(UIView *)view
{
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * req = nil;
    
    //没有联网的情况下使用缓存
    if (!instance.isCanReachInternet)
    {
        req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:10.0f];
        NSCachedURLResponse * cacheResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:req];
        if (cacheResponse != nil) {
            //有缓存，加载缓存数据
            success((NSHTTPURLResponse *)cacheResponse.response, cacheResponse.data);
        }
        else
        {
            //没有联网，也没有缓存
            failure(nil, nil);
            [MBProgressHUD hideAllHUDsForView:view animated:YES];
            [MBProgressHUD showNotificationMessage:@"加载失败,请检查网络连接" InView:view];
        }
        return;
    }

    req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            failure((NSHTTPURLResponse *)response, connectionError);
        }
        else
        {
            success((NSHTTPURLResponse *)response, data);
        }
    }];
}


+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSHTTPURLResponse *, id))success failure:(void (^)(NSHTTPURLResponse *, NSError *))failure
{
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * req = nil;
    
    //没有联网的情况下使用缓存
    if (!instance.isCanReachInternet)
    {
        req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:10.0f];
        NSCachedURLResponse * cacheResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:req];
        if (cacheResponse != nil) {
            //有缓存，加载缓存数据
            success((NSHTTPURLResponse *)cacheResponse.response, cacheResponse.data);
        }
        else
        {
            //没有联网，也没有缓存
            failure(nil, nil);
        }
        return;
    }
    
    req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            failure((NSHTTPURLResponse *)response, connectionError);
        }
        else
        {
            success((NSHTTPURLResponse *)response, data);
        }
    }];
    
    
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSHTTPURLResponse *, id))success failure:(void (^)(NSHTTPURLResponse *, NSError *))failure
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation.response, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation.response, error);
    }];
}

@end
