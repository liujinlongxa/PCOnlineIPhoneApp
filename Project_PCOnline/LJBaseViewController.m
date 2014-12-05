//
//  LJBaseViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseViewController.h"
#import "UIImage+MyImage.h"
#import "LJUserSettingViewController.h"
#import "PPRevealSideViewController.h"

@implementation LJBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavButton];
}

- (void)userCenterClick
{
    LJUserSettingViewController * settingVC = [[LJUserSettingViewController alloc] init];
    
    [self.revealSideViewController pushViewController:settingVC onDirection:PPRevealSideDirectionRight animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:23]}];
    [self setupNavButton];
}

- (void)setupNavButton
{
    //设置导航栏
    //设置左右Button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_search"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_to_user_center"] style:UIBarButtonItemStylePlain target:self action:@selector(userCenterClick)];
}

@end
