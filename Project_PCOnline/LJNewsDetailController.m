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
#import "LJNetWorkingTool.h"
#import "LJArticleDao.h"
#import "LJCollectionButton.h"

@interface LJNewsDetailController ()<UIWebViewDelegate>

//@property (nonatomic, weak) UIWebView * webView;

/**
 *  品论数据
 */
@property (nonatomic, strong) LJCommentInfo * info;

/**
 *  导航栏上的评论Button
 */
@property (nonatomic, weak) UIBarButtonItem * commentBtn;

/**
 *  文章信息持久化对象模型
 */
@property (nonatomic, strong) LJArticleDaoModel * articleDao;

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
    //设置评论Bar上的按钮类型为收藏
    self.commentBar.commentBarBtnType = LJCommentBarButtonTypeCollection;
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
    
    [self setupCommentBarMidButtonStatus];
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
    
    //设置数据持久化模型
    self.articleDao.articleId = @(ID.integerValue);
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
    
    //设置数据持久化模型
    self.articleDao.title = news.title;
}

- (void)setAds:(LJAds *)ads
{
    _ads = ads;
    self.ID = ads.ID;
    
    //设置数据持久化模型
    self.articleDao.title = ads.title;
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
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dict[@"error"] isEqualToString:@"topic not found"])
        {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"抢沙发" style:UIBarButtonItemStylePlain target:self action:nil];
        }
        else
        {
            self.info = [LJCommentInfo commentInfoWithDict:dict];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d评论", self.info.total.integerValue] style:UIBarButtonItemStylePlain target:self action:@selector(commentBtnClick:)];
        }
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
    }];
}

#pragma mark - 收藏
/**
 *  重写收藏按钮点击事件
 */
- (void)commentBar:(LJCommentBar *)bar didSelectMidButton:(UIButton *)collectionBtn
{
    if (collectionBtn.isSelected)
    {
        [LJArticleDao removeArticleFromDB:self.articleDao];
    }
    else
    {
        [LJArticleDao addArticleToDB:self.articleDao];
    }
    
    [super commentBar:bar didSelectMidButton:collectionBtn];
}


#pragma mark - 设置数据持久化对象模型articleDao

- (LJArticleDaoModel *)articleDao
{
    if (!_articleDao)
    {
        _articleDao = [[LJArticleDaoModel alloc] init];
    }
    return _articleDao;
}

- (void)setResultItem:(LJNewsSearchResultItem *)resultItem
{
    _resultItem = resultItem;
    
    //设置数据持久化模型
    self.articleDao.articleId = @(resultItem.ID.integerValue);
    self.articleDao.title = resultItem.title;
}

- (void)setProInfo:(LJProductInformation *)proInfo
{
    _proInfo = proInfo;
    
    //设置数据持久化模型
    self.articleDao.articleId = @(proInfo.ID.integerValue);
    self.articleDao.title = proInfo.title;
}

/**
 *  设置commentBar上的收藏按钮的状态
 */
- (void)setupCommentBarMidButtonStatus
{
    if ([self.commentBar.middleButton isKindOfClass:[LJCollectionButton class]])
    {
        LJCollectionButton * collBtn = (LJCollectionButton *)self.commentBar.middleButton;
        [collBtn setSelected:[LJArticleDao selectWithExistItem:self.articleDao] withAnimation:NO];
    }
}

@end
