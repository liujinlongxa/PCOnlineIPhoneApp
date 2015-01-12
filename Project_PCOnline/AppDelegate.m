//
//  AppDelegate.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

//这是master分支

#import "AppDelegate.h"
#import "PPRevealSideViewController.h"
#import "LJTabBarController.h"
#import "LJUserCenterViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "LJNetWorkingTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    LJTabBarController * tabVC = [[LJTabBarController alloc] init];
    
    PPRevealSideViewController * revealVC = [[PPRevealSideViewController alloc] initWithRootViewController:tabVC];
    self.window.rootViewController = revealVC;
    
    //更改状态栏式样
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    //开始监听网络状态
    [[LJNetWorkingTool shareNetworkTool] startMonitorNetwork];
    
    //开始监听网络连接错误
    [[LJNetWorkingTool shareNetworkTool] startObserverNetworkError];
    
    //share sdk
    [ShareSDK registerApp:@"4cc5b89481e3"];
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"946021150"
                               appSecret:@"17cd7a606c8a55dadd9715ffd6a55c95"
                             redirectUri:@"http://www.baidu.com"];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - shark SDK

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


@end
