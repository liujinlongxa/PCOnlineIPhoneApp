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
#import "LJSelectButton.h"
//模型
#import "LJSubject.h"
#import "LJNews.h"
#import "LJAds.h"
//tableview
#import "LJTopNewsTableView.h"
#import "LJLiveTableView.h"
#import "LJPriceTableView.h"
#import "LJNormalTableView.h"
#import "LJBaseCustomTableView.h"





@interface LJNewsViewController ()< LJSubjectViewDelegate, LJCustomTableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, strong) LJSubject * curSubject;
@property (nonatomic, strong) NSArray * sujects;

@property (nonatomic, weak) LJSubjectView * subjectView;
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
    self.subjectView = subjectView;
    subjectView.delegate = self;
    self.sujects = [LJCommonData shareCommonData].SubjectsData;
    subjectView.subjects = self.sujects;
    
    //初始化滚动视图
    [self setupScrollView];
    
    //设置TableView
    [self setupTableView];
    
    //默认选中头条
    LJBaseCustomTableView * table = self.scrollView.subviews[0];
    [table beginRefresh];
    
    //注册广告点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adsClikc:) name:LJAdsViewTapNotify object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//初始化滚动视图
- (void)setupScrollView
{
    //设置scrollview
    CGFloat scrollX = 0;
    CGFloat scrollY = CGRectGetMaxY(self.subjectView.frame);
    CGFloat scrollH = kScrH - 2 * kNavBarH - kStatusBarH - kTabBarH;
    CGFloat scrollW = kScrW;
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollX, scrollY, scrollW, scrollH)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
}

//初始化表格视图
- (void)setupTableView
{
    
    NSDictionary * subjectsTableView = @{@"头条":@"LJTopNewsTableView",@"行情":@"LJPriceTableView"};
                            //@"直播":@"LJLiveTableView",
                            
    CGFloat tabH = CGRectGetHeight(self.scrollView.frame);
    CGFloat tabW = CGRectGetWidth(self.scrollView.frame);
    for (int i = 0; i < self.sujects.count; i++) {
        LJBaseCustomTableView * table = nil;
        LJSubject * subject = self.sujects[i];
        NSString * tableViewStr = subjectsTableView[subject.title];
        if (tableViewStr == nil) {
            table= [[LJNormalTableView alloc] init];
        }
        else
        {
            table = [[NSClassFromString(tableViewStr) alloc] init];
        }
        ((LJNormalTableView *)table).subject = subject;
        table.frame = CGRectMake(i * tabW, 0, tabW, tabH);
        table.customDelegate = self;
        [self.scrollView addSubview:table];
    }
    self.scrollView.contentSize = CGSizeMake(self.sujects.count * tabW, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    //设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 选择频道
- (void)subjectView:(LJSubjectView *)subjectView didSelectButton:(LJSelectButton *)sender
{
    self.scrollView.contentOffset = CGPointMake(sender.tag * CGRectGetWidth(self.scrollView.frame), 0);
    LJBaseCustomTableView * table = self.scrollView.subviews[sender.tag];
    [table beginRefresh];
    
}

#pragma mark - 选择某条新闻代理方法
- (void)customTableView:(LJBaseCustomTableView *)tableView didSelectCellWithObject:(id)object
{
    if ([object isKindOfClass:[LJNews class]]) {
        LJNews * news = (LJNews *)object;
        LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
        detailVC.ID = news.ID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - 滚动视图代理方法
//滚动到一个新的视图调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kScrW;
    LJBaseCustomTableView * table = self.scrollView.subviews[index];
    [table beginRefresh];
    self.subjectView.selectIndex = index;
}

#pragma mark - 广告点击
- (void)adsClikc:(NSNotification *)notify
{
    id ad = notify.userInfo[LJAdsViewTapNotifyAdsKey];
    if ([ad isKindOfClass:[LJAds class]]) {
        LJAds * newsAd = (LJAds *)ad;
        LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
        detailVC.ID = newsAd.ID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

@end
