//
//  LJNewsViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsViewController.h"
#import "UIImage+MyImage.h"
#import "LJSubjectView.h"
#import "LJCommonData.h"
#import "LJNetWorking.h"
#import "LJNewsNormalCell.h"
#import "MJRefresh.h"
#import "LJNewsDetailController.h"
//模型
#import "LJSubject.h"
#import "LJNews.h"
#import "LJAds.h"

//重用标识
#define kNormalCellIdentifier @"NormalCell"

#define kNewsKey @"articleList" //新闻key
#define kAdsKey @"focus"  //广告key

@interface LJNewsViewController ()<UITableViewDelegate, UITableViewDataSource, LJSubjectViewDelegate>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * newsData;
@property (nonatomic, strong) NSMutableArray * AdsData;

@property (nonatomic, strong) LJSubject * curSubject;
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation LJNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithNameNoRender:@"pconline_top_title"]];
    
    //添加栏目条
    LJSubjectView * subjectView = [LJSubjectView subjectView];
    [self.view addSubview:subjectView];
    subjectView.delegate = self;
    subjectView.subjects = [LJCommonData shareCommonData].SubjectsData;
    
    //添加tableview
    CGFloat tableX = 0;
    CGFloat tableY = CGRectGetMaxY(subjectView.frame);
    CGFloat tableH = kScrH - 2 * kNavBarH - kStatusBarH - kTabBarH;
    CGFloat tableW = kScrW;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //设置导航栏
    
    //设置默认显示头条
    self.curSubject = [[LJCommonData shareCommonData].SubjectsData firstObject];
    //设置默认页号
    self.curPage = 1;
    //设置cell高度
    self.tableView.rowHeight = 80;
    //注册tableview
    [self.tableView registerNib:[UINib nibWithNibName:@"LJNewsNormalCell" bundle:nil] forCellReuseIdentifier:kNormalCellIdentifier];
    //设置刷新
    [self setupRefresh];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pconline_navbar"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 设置刷新
- (void)setupRefresh
{
    [self.tableView addHeaderWithCallback:^{
        self.curPage = 1;
        [self loadData];
    }];
    [self.tableView addFooterWithCallback:^{
        self.curPage++;
        [self loadData];
    }];
}

#pragma mark - 加载数据
- (NSArray *)newsData
{
    if (!_newsData) {
        [self loadData];
    }
    return _newsData;
}

- (void)loadData
{
    NSString * urlStr = [NSString stringWithFormat:kNewsUrl, self.curSubject.index, self.curPage];
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
        //解析ads
        for (NSDictionary * adsDict in dict[kAdsKey]) {
            LJAds * ad = [LJAds adsWithDict:adsDict];
            [adsArr addObject:ad];
        }
        if (self.curPage == 1) {
            _newsData = newsArr;
        }
        else
        {
            //加载更多
            [_newsData addObjectsFromArray:newsArr];
        }
        _AdsData = adsArr;
        [self.tableView reloadData];//刷新
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - 设置TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
    detailVC.ID = news.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 选择频道
- (void)subjectView:(LJSubjectView *)subjectView didSelectSubject:(LJSubject *)subject
{
    self.curSubject = subject;
    [self loadData];
}



@end
