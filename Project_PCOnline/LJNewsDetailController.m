//
//  LJNewsDetailController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsDetailController.h"
#import "UIImage+MyImage.h"
#import "LJCommentTableVC.h"

@interface LJNewsDetailController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView * webView;

@end

@implementation LJNewsDetailController
@synthesize curPage = _curPage;

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
}

- (void)setID:(NSString *)ID
{
    _ID = ID;
    NSString * urlStr = [NSString stringWithFormat:kNewsDetailUrl, self.ID, self.curPage + 1];
    self.urlStr = urlStr;
}

- (void)setCurPage:(NSInteger)curPage
{
    _curPage = curPage;
    NSString * urlStr = [NSString stringWithFormat:kNewsDetailUrl, self.ID, self.curPage + 1];
    self.urlStr = urlStr;
}

- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    //设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    NSString * commentCount = self.news != nil ? [NSString stringWithFormat:@"%d评论", self.news.cmtCount.integerValue] : @"评论";
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:BlueTextColor} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:commentCount style:UIBarButtonItemStylePlain target:self action:@selector(commentBtnClick:)];
}

- (void)commentBtnClick:(id)sender
{
    LJCommentTableVC * commentTVC = [[LJCommentTableVC alloc] init];
    [self.navigationController pushViewController:commentTVC animated:YES];
}



@end
