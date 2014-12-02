//
//  LJNewsDetailController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsDetailController.h"
#import "UIImage+MyImage.h"
@interface LJNewsDetailController ()

@property (nonatomic, weak) UIWebView * webView;

@end

@implementation LJNewsDetailController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化webView
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.webView = webView;
    
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary"] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    
    
}

- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //加载网页
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:kNewsDetailUrl, self.ID]];
    NSLog(@"%@", url.absoluteString);
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

@end
