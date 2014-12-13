//
//  LJFullScreenWebViewerVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJFullScreenWebViewerVC.h"
#import "LJCommonHeader.h"
#import "UIImage+MyImage.h"
@interface LJFullScreenWebViewerVC ()

@property (nonatomic, weak) UIWebView * webView;
@property (nonatomic, weak) UIToolbar * toolBar;

@property (nonatomic, strong) UIBarButtonItem * goBack;
@property (nonatomic, strong) UIBarButtonItem * goFoward;
@end

@implementation LJFullScreenWebViewerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupWebView];
    [self setupToolBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    assert(self.urlStr != nil);
    NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:req];
}

#pragma mark - init UI
- (void)setupWebView
{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kStatusBarH, kScrW, kScrH - kStatusBarH - kTabBarH)];
    [self.view addSubview:webView];
    self.webView  = webView;
}

- (void)setupToolBar
{
    UIToolbar * tooBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScrH - kTabBarH, kScrW, kTabBarH)];
    [self.view addSubview:tooBar];
    self.toolBar = tooBar;
    
    //butttons
    //go back
    UIBarButtonItem * goBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"common_fullscreen_back"] style:UIBarButtonItemStylePlain target:self.webView action:@selector(goBackWebPage)];
    UIBarButtonItem * goForward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"common_fullscreen_forward"] style:UIBarButtonItemStylePlain target:self.webView action:@selector(goFowardWebPage)];
    self.goBack = goBack;
    self.goFoward = goForward;
    
    UIBarButtonItem * refresh = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"common_fullscreen_refresh"] style:UIBarButtonItemStylePlain target:self.webView action:@selector(reload)];
    UIBarButtonItem * close = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"common_fullscreen_close"] style:UIBarButtonItemStylePlain target:self action:@selector(closeFullScreenWeb)];
    UIBarButtonItem * blank = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolBar.items = @[goBack, goForward, blank, refresh, blank, close];
}

- (void)closeFullScreenWeb
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goBackWebPage
{
    [self.webView goBack];
    [self setupBackAndForward];
}

- (void)goFowardWebPage
{
    [self.webView goForward];
    [self setupBackAndForward];
}

- (void)setupBackAndForward
{
    self.goBack.enabled = self.webView.canGoBack;
    self.goFoward.enabled = self.webView.canGoForward;
}

@end
