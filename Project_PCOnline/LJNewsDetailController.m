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
#import "LJCommentInfo.h"
#import "LJNetWorking.h"
@interface LJNewsDetailController ()<UIWebViewDelegate>

//@property (nonatomic, weak) UIWebView * webView;
@property (nonatomic, strong) LJCommentInfo * info;
@property (nonatomic, weak) UIBarButtonItem * commentBtn;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithNameNoRender:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:BlueTextColor} forState:UIControlStateNormal];
    
    //设置导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    //设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    [self loadCommentInfo];
}

#pragma mark - set url string
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

- (void)setNews:(LJNews *)news
{
    _news = news;
    self.ID = news.ID;
}

- (void)setAds:(LJAds *)ads
{
    _ads = ads;
    self.ID = ads.ID;
}

#pragma mark - nav bar button click
- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commentBtnClick:(id)sender
{
    LJCommentTableVC * commentTVC = [[LJCommentTableVC alloc] init];
    if (self.news)
    {
        commentTVC.ID = self.news.ID;
    }
    else
    {
        commentTVC.ID = self.ads.ID;
    }
    
    commentTVC.showHeader = YES;
    commentTVC.commentInfo = self.info;
    commentTVC.pageInfo = self.pageInfo;
    [self.navigationController pushViewController:commentTVC animated:YES];
}

#pragma mark - load comment info
- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    if (self.news)
    {
        urlStr  =[NSString stringWithFormat:kCommentInfoUrl, self.news.url];
    }
    else if(self.ads)
    {
        urlStr = [NSString stringWithFormat:kCommentInfoUrl, self.ads.url];
    }
    else
    {
        urlStr = [NSString stringWithFormat:kCommentInfoUrl, self.pageInfo.url];
    }
    return urlStr;
}

- (void)loadCommentInfo
{
    NSString * urlStr  = [self setupUrlStr];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dict[@"error"] isEqualToString:@"topic not found"])
        {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"抢沙发" style:UIBarButtonItemStylePlain target:self action:@selector(commentBtnClick:)];
        }
        else
        {
            self.info = [LJCommentInfo commentInfoWithDict:dict];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d评论", self.info.total.integerValue] style:UIBarButtonItemStylePlain target:self action:@selector(commentBtnClick:)];
        }
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}










@end
