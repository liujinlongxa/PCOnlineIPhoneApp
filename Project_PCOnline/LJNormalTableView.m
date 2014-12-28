//
//  LJNormalTableView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNormalTableView.h"
#import "MJRefresh.h"
#import "LJNetWorkingTool.h"
#import "LJNews.h"
#import "LJNewsNormalCell.h"
#import "LJAds.h"
#import "LJCommonData.h"


#define kNewsKey @"articleList" //新闻key
#define kAdsKey @"focus"  //广告key
//重用标识
#define kNormalCellIdentifier @"NormalCell"


@interface LJNormalTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * newsData;


@end

@implementation LJNormalTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.rowHeight = 80;
        
        //注册cell
        [self registerNib:[UINib nibWithNibName:@"LJNewsNormalCell" bundle:nil] forCellReuseIdentifier:kNormalCellIdentifier];
    }
    return self;
}

#pragma mark - 加载数据
- (void)setSubject:(LJSubject *)subject
{
    _subject = subject;
}

- (NSArray *)newsData
{
    if (!_newsData) {
        _newsData = [NSMutableArray array];
    }
    return _newsData;
}

- (NSString *)setupUrlStr
{
    NSString * ursStr = nil;
    if ([self.subject.title isEqualToString:@"行情"]) {
        ursStr = [NSString stringWithFormat:kNewsUrl, [LJCommonData shareCommonData].curArea.index, self.curPage];
    }
    else
    {
        ursStr = [NSString stringWithFormat:kNewsUrl, self.subject.index, self.curPage];
    }
    return ursStr;
}

- (void)loadNewsData
{
    [LJNetWorkingTool GET:[self setupUrlStr] parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * newsArr = [NSMutableArray array];
        NSMutableArray * adsArr = [NSMutableArray array];
        //解析news
        for (NSDictionary * newsDict in dict[kNewsKey]) {
            LJNews * news = [LJNews newsWithDict:newsDict];
            [newsArr addObject:news];
        }
        if (self.curPage == 1) {
            _newsData = newsArr;
            //加载广告数据
            for (NSDictionary * adsDict in dict[kAdsKey]) {
                LJAds * ad = [LJAds adsWithDict:adsDict];
                [adsArr addObject:ad];
            }
            self.adsData = adsArr;
        }
        else
        {
            //加载更多
            [_newsData addObjectsFromArray:newsArr];
        }
        
        [self reloadData];//刷新数据
        [self reloadHeaderView];
        //停止下拉刷新和上拉加载更多
        [self footerEndRefreshing];
        [self headerEndRefreshing];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
        //停止刷新
        [self footerEndRefreshing];
        [self headerEndRefreshing];
    }];
}

- (void)reloadHeaderView
{
    //子类实现
}

#pragma mark - 设置TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%d", self.newsData.count);
    return self.newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJNews * news = self.newsData[indexPath.row];
    
    LJNewsNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellIdentifier];
    cell.news = news;
    return cell;
}

//选中某条新闻
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJNews * news = self.newsData[indexPath.row];
    if ([self.customDelegate respondsToSelector:@selector(customTableView:didSelectCellWithObject:)]) {
        [self.customDelegate customTableView:self didSelectCellWithObject:news];
    }
}

#pragma mark - 显示数据
- (void)showData
{
    [self loadNewsData];
}

@end
