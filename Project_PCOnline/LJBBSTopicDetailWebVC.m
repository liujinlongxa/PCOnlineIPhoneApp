//
//  LJBBSTopicDetailWebVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSTopicDetailWebVC.h"
#import "UIImage+MyImage.h"

@interface LJBBSTopicDetailWebVC ()

@property (nonatomic, weak) UIWebView * webView;

@end

@implementation LJBBSTopicDetailWebVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    
}

- (void)setupWebView
{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.webView = webView;
    
    NSString * urlStr = nil;
    if ([self.bbsList.listItem.title isEqualToString:@"最数码论坛"]) {
        urlStr = [NSString stringWithFormat:kZuiBBSTopicDetailUrl, self.topic.topicId.integerValue];
    }
    else
    {
        urlStr = [NSString stringWithFormat:kBBSTopicDetailUrl, self.topic.topicId.integerValue];
    }
    NSLog(@"web:%@", urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setupNavBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setupNavBar
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithNameNoRender:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    //分享
    UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_article_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClick:)];
    //收藏
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn setImage:[UIImage imageWithNameNoRender:@"btn_common_toolbar_collect"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithNameNoRender:@"btn_common_toolbar_collected"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * collectItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[shareItem, collectItem];
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBtnClick:(id)sender
{
    
}

- (void)collectBtnClick:(id)sender
{
    
}

@end
