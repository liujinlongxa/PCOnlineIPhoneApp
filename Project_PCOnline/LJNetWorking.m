//
//  LJNetWorking.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNetWorking.h"
#import "Reachability.h"


static LJNetWorking * instance;

@interface LJNetWorking ()

@property (nonatomic, assign, getter=isCanReachInternet) BOOL canReachInternet;
@property (nonatomic, strong) Reachability * networkReachability;
@end

@implementation LJNetWorking


#pragma mark - moniter network
- (instancetype)shareNetwork
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
        self.canReachInternet = NO;
    }
    else
    {
        self.canReachInternet = YES;
    }
}

#pragma mark - http method GET,POST
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSHTTPURLResponse *, id))success failure:(void (^)(NSHTTPURLResponse *, NSError *))failure
{
    
    NSURLCache * urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1 * 2048 * 2048];
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    //没有联网的情况下使用缓存
    if (!instance.isCanReachInternet)
    {
        NSCachedURLResponse * cacheResponse = [urlCache cachedResponseForRequest:req];
        if (cacheResponse != nil) {
            success((NSHTTPURLResponse *)cacheResponse.response, cacheResponse.data);
            return;
        }
        else
        {
            //没有联网，也没有缓存
            failure(nil, nil);
        }
    }

    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        success((NSHTTPURLResponse *)response, data);
    }];
    
    
    
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(operation.response, responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(operation.response, error);
//    }];
    
    
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
