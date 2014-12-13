//
//  LJSpecialViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSpecialViewController.h"
#import "AppDelegate.h"

@interface LJSpecialViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView * webView;

@end

@implementation LJSpecialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title  = @"专栏";
    
    //初始化webView
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.delegate = self;
    
    //加载网页
    NSURL * url = [NSURL URLWithString:kSpecialUrl];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    //设置状态栏背景
    UIView * statueBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kStatusBarH)];
    statueBarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:statueBarView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request);
    return YES;
}

@end
