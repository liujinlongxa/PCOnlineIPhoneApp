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
#import "SDWebImageManager.h"

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

/**
 *  缓存路径
 */
@property (nonatomic, copy) NSString * cachePath;

/**
 *  上一次发送错误的对象
 */
@property (nonatomic, strong) id lastErrorObj;
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
        self.canReachInternet = NO;
    }
    else
    {
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
        AppDelegate * dele = [UIApplication sharedApplication].delegate;
        [MBProgressHUD showNotificationMessage:@"网络连接已断开" InView:dele.window];
        self.canReachInternet = NO;
    }
    else
    {
        self.canReachInternet = YES;
    }
}

#pragma mark - network error notification
/**
 *  开始监听网络连接错误
 */
- (void)startObserverNetworkError
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkError:) name:kNetworkErrorNotification object:nil];
}

/**
 *  处理网络连接错误的通知
 */
- (void)handleNetworkError:(NSNotification *)notify
{
    self.lastErrorObj = notify.object;
    //延迟0.5s显示提示，否则可能会显示不正常
    [self performSelector:@selector(showHUD) withObject:nil afterDelay:0.5];
}

/**
 *  显示HUD
 */
- (void)showHUD
{
    AppDelegate * dele = [UIApplication sharedApplication].delegate;
    [MBProgressHUD hideAllHUDsForView:dele.window animated:YES];
    [MBProgressHUD showNotificationMessage:@"网络异常" InView:dele.window];
}

#pragma mark - url cache

/**
 *  缓存路径
 */
- (NSString *)cachePath
{
    if (!_cachePath) {
        //获取缓存路径
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        _cachePath = [path stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
    }
    return _cachePath;
}

/**
 *  清空缓存
 */
- (void)cleanCache
{
    //删除网络请求缓存数据
//    [[NSFileManager defaultManager] removeItemAtPath:self.cachePath error:nil];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    //删除图片缓存数据
    [[SDWebImageManager sharedManager].imageCache clearDisk];
}

/**
 *  获取当前缓存大小
 *
 *  @return 当前缓存大小（byte）
 */
- (float)currnetCacheSize
{
    //获取SDWebImage缓存大小
    SDImageCache * cache = [SDWebImageManager sharedManager].imageCache;
    NSUInteger imageSize = [cache getSize] / 1024.0 / 1024.0;
    
    //判断缓存路径是否存在，存在则缓存路径整个文件夹的大小，否则返回0
    return [self folderSizeAtPath:self.cachePath] + imageSize;
}
                
/**
 *  返回单个文件的大小
 *
 *  @param filePath 单个文件路径
 *
 *  @return 单个文件的路径
 */
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/**
 *  遍历文件夹获得文件夹大小，返回多少M
 *
 *  @param folderPath 路径
 *
 *  @return 文件夹大小
 */
- (float) folderSizeAtPath:(NSString *)folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

#pragma mark - http method GET,POST
/**
 *  http GET Method
 *
 *  @param URLString  url
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
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
            failure((NSHTTPURLResponse *)cacheResponse.response, nil);
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

/**
 *  http POST Method
 *
 *  @param URLString  url
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
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
