//
//  LJUserSettingViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJUserSettingViewController.h"
#import "PPRevealSideViewController.h"

@interface LJUserSettingViewController ()

@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation LJUserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加背景图片
//    self.view.backgroundColor = [UIColor redColor];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"bg_user_center"];
    [self.view addSubview:self.imageView];
//
    self.revealSideViewController.fakeiOS7StatusBarColor = [UIColor clearColor];
}

//- (void)viewDidLayoutSubviews
//{
//    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

@end
