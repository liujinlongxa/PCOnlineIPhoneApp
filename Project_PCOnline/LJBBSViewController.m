//
//  LJBBSViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSViewController.h"
#import "LJBBSButtonView.h"
#import "LJSelectButton.h"
#import "LJBBSListViewController.h"
#import "LJBBSSquareViewController.h"
#import "LJBBSRecentViewController.h"
#import "LJScrollTabViewController.h"

@interface LJBBSViewController ()<LJBBSButtonViewDelegate>

@property (nonatomic, assign) LJSelectButton * curSelectedButton;

//控制器
@property (nonatomic, strong) LJBBSSquareViewController * squareVC;
@property (nonatomic, strong) LJBBSListViewController * listVC;
@property (nonatomic, strong) LJBBSRecentViewController * recentVC;

@property (nonatomic, strong) LJScrollTabViewController * scrollTabViewController;

//显示区域
@property (nonatomic, weak) UIView * showView;
@end

@implementation LJBBSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"论坛";
    
    //设置按钮
//    NSArray * btnTitleArr = @[@"论坛广场", @"论坛列表", @"最近浏览"];
//    LJBBSButtonView * btnView = [LJBBSButtonView bbsButtonViewWithFrame:CGRectMake(0, 0, kScrW, kNavBarH) andTitles:btnTitleArr];
//    btnView.delegate = self;
//    self.curSelectedButton = [btnView.subviews firstObject];
//    self.curSelectedButton.selected = YES;
//    [self.view addSubview:btnView];
//    
//    //设置显示区域
    UIView * showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kNavBarH - kTabBarH - kStatusBarH)];
    [self.view addSubview:showView];
    self.showView = showView;
    self.showView.backgroundColor = [UIColor yellowColor];
    
    //设置控制器
    [self setupControllers];
}

- (void)setupControllers
{
    //论坛列表
    self.listVC = [[LJBBSListViewController alloc] init];
    //最新浏览
    self.recentVC = [[LJBBSRecentViewController alloc] init];
    //论坛广场
    self.squareVC = [[LJBBSSquareViewController alloc] init];
    self.scrollTabViewController = [LJScrollTabViewController scrollTabViewControllerWithController:@[self.squareVC, self.listVC, self.recentVC] andTitles:@[@"论坛广场", @"论坛列表", @"最近浏览"]];
//    //默认显示论坛广场
//    [self.showView addSubview:self.squareVC.view];
    [self.showView addSubview:self.scrollTabViewController.view];
}

- (void)viewDidLayoutSubviews
{
    NSLog(@"%@", self.showView.subviews);
}

- (void)BBSButtonView:(LJBBSButtonView *)view didClickButton:(LJSelectButton *)button
{
//    self.curSelectedButton.selected = NO;
//    button.selected = YES;
//    self.curSelectedButton = button;
//    
//    [self.showView.subviews[0] removeFromSuperview];
//    if (button.tag == 0) {
//        [self.showView addSubview:self.squareVC.view];
//    }
//    else if(button.tag == 1)
//    {
//        [self.showView addSubview:self.listVC.view];
//    }
//    else
//    {
//        [self.showView addSubview:self.recentVC.view];
//    }
    
}

@end
