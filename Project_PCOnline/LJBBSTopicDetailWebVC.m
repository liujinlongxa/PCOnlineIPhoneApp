//
//  LJBBSTopicDetailWebVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSTopicDetailWebVC.h"
#import "UIImage+MyImage.h"
#import "LJCommonHeader.h"
#import "LJTopicSearchResultItem.h"
#import "LJNetWorking.h"

@interface LJBBSTopicDetailWebVC ()<UIWebViewDelegate>
@property (nonatomic, copy) NSString * baseUrl;
@end

@implementation LJBBSTopicDetailWebVC
@synthesize curPage = _curPage;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initBBSTopicDetailWebVCWithBaseUrlStr:(NSString *)urlStr andTopicId:(NSNumber *)topicId
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.topicId = topicId;
        self.baseUrl = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlStr = [self setupUrlStr];
}

//设置URl
- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    
    if (self.baseUrl != nil) {
        //点击广告时
        urlStr = [NSString stringWithFormat:self.baseUrl, self.topicId.integerValue, self.curPage + 1];
    }
    else if(self.bbsItem != nil && self.topic != nil)
    {
        if (self.bbsItem.ID.integerValue < 0) {
            urlStr = [NSString stringWithFormat:kZuiBBSTopicDetailUrl, self.topic.topicId.integerValue, self.curPage + 1];
        }
        else
        {
            urlStr = [NSString stringWithFormat:kBBSTopicDetailUrl, self.topic.topicId.integerValue, self.curPage + 1];
        }
    }
    else
    {
        if (self.searchResutItem.forumId.integerValue < 0) {
            urlStr = [NSString stringWithFormat:kZuiBBSTopicDetailUrl, self.searchResutItem.topicId.integerValue, self.curPage + 1];
        }
        else
        {
            urlStr = [NSString stringWithFormat:kBBSTopicDetailUrl, self.searchResutItem.topicId.integerValue, self.curPage + 1];
        }
    }
    assert(urlStr != nil);
    return urlStr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setupNavBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setCurPage:(NSInteger)curPage
{
    _curPage = curPage;
    self.urlStr = [self setupUrlStr];
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
