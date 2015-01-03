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
#import "LJNetWorkingTool.h"
#import "LJHotTopic.h"
#import "LJCollectionButton.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD+LJProgressHUD.h"
#import "LJTopicDao.h"

@interface LJBBSTopicDetailWebVC ()<UIWebViewDelegate>

/**
 *  Url
 */
@property (nonatomic, copy) NSString * baseUrl;

/**
 *  数据持久化模型
 */
@property (nonatomic, strong) LJTopicDaoModel * topicDao;
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
        //数据持久化
        self.topicDao.topicId = topicId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置评论Bar上的按钮类型为刷新
    self.commentBar.commentBarBtnType = LJCommentBarButtonTypeRefresh;
    
    self.urlStr = [self setupUrlStr];
}

/**
 *  设置Url
 *
 *  @return 返回设置好的Url
 */
- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    
    if (self.baseUrl != nil) {
        //点击广告时
        urlStr = [NSString stringWithFormat:self.baseUrl, self.topicId.integerValue, self.curPage + 1];
        self.topicDao.baseUrl = self.baseUrl;
    }
    else if(self.bbsItem != nil && self.topic != nil)
    {
        //正常点击某个帖子
        if (self.bbsItem.ID.integerValue < 0) {
            urlStr = [NSString stringWithFormat:kZuiBBSTopicDetailUrl, self.topic.topicId.integerValue, self.curPage + 1];
            self.topicDao.baseUrl = kZuiBBSTopicDetailUrl;
        }
        else
        {
            urlStr = [NSString stringWithFormat:kBBSTopicDetailUrl, self.topic.topicId.integerValue, self.curPage + 1];
            self.topicDao.baseUrl = kBBSTopicDetailUrl;
        }
    }
    else if(self.searchResutItem != nil)
    {
        //点击搜索结果
        if (self.searchResutItem.forumId.integerValue < 0) {
            urlStr = [NSString stringWithFormat:kZuiBBSTopicDetailUrl, self.searchResutItem.topicId.integerValue, self.curPage + 1];
            self.topicDao.baseUrl = kZuiBBSTopicDetailUrl;
        }
        else
        {
            urlStr = [NSString stringWithFormat:kBBSTopicDetailUrl, self.searchResutItem.topicId.integerValue, self.curPage + 1];
            self.topicDao.baseUrl = kBBSTopicDetailUrl;
        }
    }
    else if(self.topic != nil)
    {
        //点击热帖
        if ([self.topic isKindOfClass:[LJHotTopic class]])
        {
            LJHotTopic * hotTopic = (LJHotTopic *)self.topic;
            if ([hotTopic.userUrl rangeOfString:kZuiBBSFlag].location != NSNotFound)
            {
                urlStr = [NSString stringWithFormat:kZuiBBSTopicDetailUrl, self.topic.topicId.integerValue, self.curPage + 1];
                self.topicDao.baseUrl = kZuiBBSTopicDetailUrl;
            }
            else
            {
                urlStr = [NSString stringWithFormat:kBBSTopicDetailUrl, self.topic.topicId.integerValue, self.curPage + 1];
                self.topicDao.baseUrl = kBBSTopicDetailUrl;
            }
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    //如果持久化模型中的title为空，则从pageInfo中取得Title
    if (!self.topicDao.title)
    {
        self.topicDao.title = self.pageInfo.title;
    }
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
    LJCollectionButton * btn = [[LJCollectionButton alloc] init];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn setSelected:[LJTopicDao selectWithExistItem:self.topicDao] withAnimation:NO];
    [btn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * collectItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[shareItem, collectItem];
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 分享

/**
 *  点击分享button，触发事件
 */
- (void)shareBtnClick:(id)sender
{
    NSString * content = nil;
    if (self.topic != nil) {
        content = self.topic.title;
    }
    else if(self.bbsItem != nil)
    {
        content = self.bbsItem.title;
    }
    else
    {
        content = self.searchResutItem.title;
    }
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:nil
                                                image:nil
                                                title:nil
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //显示编辑框
    [ShareSDK showShareViewWithType:ShareTypeSinaWeibo
                  container:nil
                    content:publishContent
              statusBarTips:YES
                authOptions:nil
               shareOptions:nil
                     result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                         
                         if (state == SSPublishContentStateSuccess)
                         {
                             [MBProgressHUD showNotificationMessage:@"分享成功" InView:self.view];
                         }
                         else if (state == SSPublishContentStateFail)
                         {
                             NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                         }
                         else
                         {
                             NSLog(@"other");
                         }
                     }];
}

#pragma mark - 收藏

/**
 *  点击收藏按钮，触发事件
 */
- (void)collectBtnClick:(LJCollectionButton *)sender
{
    //没有网络时，点击收藏无效
    if (!sender.isSelected && ![LJNetWorkingTool shareNetworkTool].isCanReachInternet)
    {
        NetworkErrorNotify(self);
        return;
    }
    
    if (sender.isSelected)
    {
        //从数据库中删除
        [LJTopicDao removeTopicItemFromDB:self.topicDao];
    }
    else
    {
        //添加到数据库中
        [LJTopicDao addTopicItemToDB:self.topicDao];
    }
    [sender setSelected:!sender.isSelected withAnimation:YES];
}

#pragma mark - 设置数据持久化模型topicDao

- (LJTopicDaoModel *)topicDao
{
    if (!_topicDao)
    {
        _topicDao = [[LJTopicDaoModel alloc] init];
    }
    return _topicDao;
}

- (void)setTopic:(LJBaseTopic *)topic
{
    _topic = topic;

    self.topicDao.topicId = topic.topicId;
    self.topicDao.title = topic.title;
}

- (void)setSearchResutItem:(LJTopicSearchResultItem *)searchResutItem
{
    _searchResutItem = searchResutItem;
    
    self.topicDao.topicId = searchResutItem.topicId;
    self.topicDao.title = searchResutItem.title;
}

- (void)setBbsAds:(LJBBSAds *)bbsAds
{
    _bbsAds = bbsAds;
    
    self.topicDao.topicId = @(bbsAds.topicId.integerValue);
    self.topicDao.title = bbsAds.title;
}

@end
