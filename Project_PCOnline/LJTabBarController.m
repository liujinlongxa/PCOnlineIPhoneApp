//
//  LJTabController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJTabBarController.h"
#import "LJTabBar.h"

//控制器
#import "LJNavController.h"
#import "LJNewsViewController.h"
#import "LJBBSViewController.h"
#import "LJProductViewController.h"
#import "LJPhotoVIewController.h"
#import "LJSpecialViewController.h"

@interface LJTabBarController ()<LJTabBarDelegate>

@end

@implementation LJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置控制器
    [self setupControllers];
    
    //设置自定义tabbar
    LJTabBar * myTabBar = [[LJTabBar alloc] initWithFrame:CGRectMake(0, 0, kScrW, kTabBarH)];
    myTabBar.delegate = self;
    [self.tabBar addSubview:myTabBar];
    
    self.tabBar.translucent = NO;//设置不透明
    
}

- (void)setupControllers
{
    //资讯
    LJNewsViewController * newsVC = [[LJNewsViewController alloc] init];
    LJNavController * newsNav = [[LJNavController alloc] initWithRootViewController:newsVC];
    
    //论坛
    LJBBSViewController * bbsVC = [[LJBBSViewController alloc] init];
    LJNavController * bbsNav = [[LJNavController alloc] initWithRootViewController:bbsVC];
    
    //产品
    LJProductViewController * productVC = [[LJProductViewController alloc] init];
    LJNavController * productNav = [[LJNavController alloc] initWithRootViewController:productVC];
    
    //图片
    LJPhotoVIewController * photoVC = [[LJPhotoVIewController alloc] init];
    LJNavController * photoNav = [[LJNavController alloc] initWithRootViewController:photoVC];
    
    //专栏
    LJSpecialViewController * specialVC = [[LJSpecialViewController alloc] init];
    LJNavController * specialNav = [[LJNavController alloc] initWithRootViewController:specialVC];
    
    self.viewControllers = @[newsNav, bbsNav, productNav, photoNav, specialNav];
}

//选中button回调
- (void)tabBar:(LJTabBar *)tabBar didselectButton:(LJTabButton *)button
{
    self.selectedIndex = button.tag;
}

@end
