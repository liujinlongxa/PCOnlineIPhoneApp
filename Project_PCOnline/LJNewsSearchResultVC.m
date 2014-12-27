//
//  LJNewsSearchResultVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsSearchResultVC.h"
#import "LJNetWorkingTool.h"
#import "LJNewsSearchResultItem.h"
#import "LJNewsSearchGroupView.h"
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "MBProgressHUD+LJProgressHUD.h"

#define kBtnViewItemCount 3

static NSString * const NewsArticle = @"新闻文章";
static NSString * const CepingArticle = @"评测文章";
static NSString * const DaogouArticle = @"导购文章";
static NSString * const YingyongArticle = @"应用文章";

@interface LJNewsSearchResultVC ()

@property (nonatomic, strong) NSMutableArray * newsArticleData;
@property (nonatomic, strong) NSMutableArray * pingceArticleData;
@property (nonatomic, strong) NSMutableArray * daogouArticleData;
@property (nonatomic, strong) NSMutableArray * yingyongArticleData;

@property (nonatomic, weak) UIScrollView * scrollView;

@end

@implementation LJNewsSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化滚动视图
    [self setupScrollView];
}

#pragma mark - init UI
- (void)setupScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kNavBarH - kStatusBarH - 50)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupGroupView
{
    if (self.newsArticleData == nil ||
        self.pingceArticleData == nil ||
        self.daogouArticleData == nil ||
        self.yingyongArticleData == nil)
    {
        return;
    }
    
    if (self.newsArticleData.count == 0 &&
        self.pingceArticleData.count == 0 &&
        self.daogouArticleData.count == 0 &&
        self.yingyongArticleData.count == 0)
    {
        [MBProgressHUD showNotificationMessage:@"未找到相关资讯" InView:self.view];
        return;
    }
    
    CGFloat padding = 10;
    CGFloat groupViewH = 290;
    //新闻
    LJNewsSearchGroupView * newsGroup = [[LJNewsSearchGroupView alloc] initWithFrame:CGRectMake(padding, padding, kScrW - 2 * padding, groupViewH) andClickActionBlock:^(NSInteger clickIndex) {
        if (clickIndex == kBtnViewItemCount)
        {
            [self setupDelegateWithObject:self.newsArticleData];
        }
        else
        {
            [self setupDelegateWithObject:self.newsArticleData[clickIndex]];
        }
    }];
    newsGroup.newsItems = self.newsArticleData;
    [self.scrollView addSubview:newsGroup];
    
    //测评
    LJNewsSearchGroupView * cepingGroup = [[LJNewsSearchGroupView alloc] initWithFrame:CGRectMake(padding, padding + (padding * 2 + groupViewH), kScrW - 2 * padding, groupViewH) andClickActionBlock:^(NSInteger clickIndex) {
        if (clickIndex == kBtnViewItemCount)
        {
            [self setupDelegateWithObject:self.pingceArticleData];
        }
        else
        {
            [self setupDelegateWithObject:self.pingceArticleData[clickIndex]];
        }
    }];
    cepingGroup.newsItems = self.pingceArticleData;
    [self.scrollView addSubview:cepingGroup];
    
    //导购
    LJNewsSearchGroupView * daogouGroup = [[LJNewsSearchGroupView alloc] initWithFrame:CGRectMake(padding, padding +(padding * 2 + groupViewH) * 2, kScrW - 2 * padding, groupViewH) andClickActionBlock:^(NSInteger clickIndex) {
        if (clickIndex == kBtnViewItemCount)
        {
            [self setupDelegateWithObject:self.daogouArticleData];
        }
        else
        {
            [self setupDelegateWithObject:self.daogouArticleData[clickIndex]];
        }
    }];
    daogouGroup.newsItems = self.daogouArticleData;
    [self.scrollView addSubview:daogouGroup];
    
    //应用
    LJNewsSearchGroupView * yingyongGroup = [[LJNewsSearchGroupView alloc] initWithFrame:CGRectMake(padding, padding +(padding * 2 + groupViewH) * 3, kScrW - 2 * padding, groupViewH) andClickActionBlock:^(NSInteger clickIndex) {
        if (clickIndex == kBtnViewItemCount)
        {
            [self setupDelegateWithObject:self.yingyongArticleData];
        }
        else
        {
            [self setupDelegateWithObject:self.yingyongArticleData[clickIndex]];
        }
    }];
    yingyongGroup.newsItems = self.yingyongArticleData;
    [self.scrollView addSubview:yingyongGroup];
    
    self.scrollView.contentSize = CGSizeMake(0,CGRectGetMaxY(yingyongGroup.frame) + padding);
    
}

- (void)setupDelegateWithObject:(id)obj
{
    if ([self.delegate respondsToSelector:@selector(newsSearchResultVC:didSelectWithObject:)])
    {
        [self.delegate newsSearchResultVC:self didSelectWithObject:obj];
    }
}

#pragma mark - load data

- (void)setKeyWord:(NSString *)keyWord
{
    _keyWord = [keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self loadArticleData];
}

- (void)loadArticleData
{
    [self loadNewsArticleData];
    [self loadCepingArticleData];
    [self loadDaogouArticleData];
    [self loadYingyongArticleData];
}

- (void)loadNewsArticleData
{
    NSString * urlStr = [NSString stringWithFormat:kNewsSearchUrl, self.keyWord, [NewsArticle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * articleDict in dict[@"articleList"]) {
            LJNewsSearchResultItem * item = [LJNewsSearchResultItem newsSearchResultItemWithDict:articleDict];
            [arr addObject:item];
            item.type = NewsArticle;
        }
        self.newsArticleData = arr;
        [self setupGroupView];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadCepingArticleData
{
    NSString * urlStr = [NSString stringWithFormat:kNewsSearchUrl, self.keyWord, [CepingArticle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * articleDict in dict[@"articleList"]) {
            LJNewsSearchResultItem * item = [LJNewsSearchResultItem newsSearchResultItemWithDict:articleDict];
            [arr addObject:item];
            item.type = CepingArticle;
        }
        self.pingceArticleData = arr;
        [self setupGroupView];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)loadDaogouArticleData
{
    NSString * urlStr = [NSString stringWithFormat:kNewsSearchUrl, self.keyWord, [DaogouArticle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * articleDict in dict[@"articleList"]) {
            LJNewsSearchResultItem * item = [LJNewsSearchResultItem newsSearchResultItemWithDict:articleDict];
            [arr addObject:item];
            item.type = DaogouArticle;
        }
        self.daogouArticleData = arr;
        [self setupGroupView];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)loadYingyongArticleData
{
    NSString * urlStr = [NSString stringWithFormat:kNewsSearchUrl, self.keyWord, [YingyongArticle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * articleDict in dict[@"articleList"]) {
            LJNewsSearchResultItem * item = [LJNewsSearchResultItem newsSearchResultItemWithDict:articleDict];
            [arr addObject:item];
            item.type = YingyongArticle;
        }
        self.yingyongArticleData = arr;
        [self setupGroupView];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
