//
//  LJNetWorking.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNetWorking.h"
#import "Reachability.h"
#import "LJCommonHeader.h"
#import "MBProgressHUD+LJProgressHUD.h"

static LJNetWorking * instance;

@interface LJNetWorking ()

@property (nonatomic, assign, getter=isCanReachInternet) BOOL canReachInternet;
@property (nonatomic, strong) Reachability * networkReachability;
@end

@implementation LJNetWorking


#pragma mark - moniter network
+ (instancetype)shareNetwork
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LJNetWorking alloc] init];
    });
    return instance;
}

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

- (void)networkStatusChange:(NSNotification *)notify
{
    Reachability * reach = notify.object;
    NSParameterAssert([reach isKindOfClass:[Reachability class]]);
    [self updateNetworkStatus:reach];
}

- (void)updateNetworkStatus:(Reachability *)reach
{
    NetworkStatus status = reach.currentReachabilityStatus;
    if (status == NotReachable)
    {
        LJLog(@"Change network status not reaceh : %d", status);
        self.canReachInternet = NO;
    }
    else
    {
        LJLog(@"Change network status reaceh : %d", status);
        self.canReachInternet = YES;
    }
}

#pragma mark - url cache
- (void)cleanCache
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (NSUInteger)currnetCacheSize
{
    return [[NSURLCache sharedURLCache] currentDiskUsage];
}

#pragma mark - http method GET,POST
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSHTTPURLResponse *, id))success failure:(void (^)(NSHTTPURLResponse *, NSError *))failure andView:(UIView *)view
{
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    //没有联网的情况下使用缓存
    if (!instance.isCanReachInternet)
    {
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
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    //没有联网的情况下使用缓存
    if (!instance.isCanReachInternet)
    {
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
