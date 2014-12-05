//
//  ScrollTabViewController.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJScrollTabViewController.h"
#import "LJScrollTabButtonsView.h"

@interface LJScrollTabViewController ()<UIScrollViewDelegate, LJScrollTabButtonsViewDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) LJScrollTabButtonsView * buttonsView;
//同名属性，取消readonly
@property (nonatomic, strong) NSArray * lj_viewControllers;
@property (nonatomic, strong) NSArray * lj_tabTitles;
@end

@implementation LJScrollTabViewController

+ (instancetype)scrollTabViewControllerWithController:(NSArray *)controllers andTitles:(NSArray *)titles
{
    LJScrollTabViewController * scrollTabVC = [[self alloc] init];
    scrollTabVC.lj_viewControllers = controllers;
    scrollTabVC.lj_tabTitles = titles;
    [scrollTabVC setupTabBarView];
    [scrollTabVC setupScrollView];
    [scrollTabVC setupControllers];
    return scrollTabVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupTabBarView
{
    //获取名称集合
    LJScrollTabButtonsView * buttonsView = [LJScrollTabButtonsView scrollTabButtonsViewWithTitles:self.lj_tabTitles];
    [self.view addSubview:buttonsView];
    self.buttonsView = buttonsView;
    self.buttonsView.delegate = self;
    self.buttonsView.backgroundColor = [UIColor whiteColor];
}

- (void)setupScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buttonsView.frame), kScrW, kScrH - CGRectGetHeight(self.buttonsView.frame))];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
}

- (void)setupControllers
{
    for (int i = 0; i < self.lj_viewControllers.count; i++) {
        UIViewController * vc = self.lj_viewControllers[i];
        CGRect viewF = vc.view.frame;
        viewF.origin.x = i * CGRectGetWidth(self.scrollView.frame);
        viewF.origin.y = 0;
        vc.view.frame = viewF;
        [self.scrollView addSubview:vc.view];
    }
    self.scrollView.contentSize = CGSizeMake(self.lj_viewControllers.count * CGRectGetWidth(self.scrollView.frame), 0);
}

#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame);
    [self.buttonsView selectButtonAtIndex:index];
}

- (void)scrollTabButtonsView:(LJScrollTabButtonsView *)view didSelectIndex:(NSInteger)index
{
    self.scrollView.contentOffset = CGPointMake(index * CGRectGetWidth(self.scrollView.frame), 0);
}

@end
