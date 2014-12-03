//
//  LJNormalTableView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNormalTableView.h"
#import "MJRefresh.h"
#import "LJNetWorking.h"
#import "LJNews.h"
#import "LJNewsNormalCell.h"
#import "LJAds.h"


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

- (void)loadNewsData
{
    NSString * urlStr = [NSString stringWithFormat:kNewsUrl, self.subject.index, self.curPage];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
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
        }
        else
        {
            //加载更多
            [_newsData addObjectsFromArray:newsArr];
        }
        //加载广告数据
        for (NSDictionary * adsDict in dict[kAdsKey]) {
            LJAds * ad = [LJAds adsWithDict:adsDict];
            [adsArr addObject:ad];
        }
        self.adsData = adsArr;
        
        [self reloadData];//刷新
        [self reloadHeaderView];
        [self footerEndRefreshing];
        [self headerEndRefreshing];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
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
