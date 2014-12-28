//
//  LJBBSSquareViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSquareViewController.h"
#import "LJAdsGroupView.h"
#import "LJNetWorkingTool.h"
#import "LJHotTopicView.h"
#import "LJHotForumsView.h"
#import "LJInfiniteScrollView.h"
#import "LJBBSHotTopicTableVC.h"
#import "MJRefresh/MJRefresh.h"
//View
#import "LJFastForumButton.h"
#import "LJFastSubForumButton.h"
//模型
#import "LJBBSAds.h"
#import "LJBBSListItem.h"

#define kFastForumDataFileName @"pconline_v4_square_fast_forum4inch.json"

#define kBBSAdsKey @"focus"
#define kHotTopicKey @"hot-topics"
#define kHotForumKey @"forums"
#define kPadding 10

@interface LJBBSSquareViewController ()<UIScrollViewDelegate, LJHotForumsViewDelegate>

//scrollView
@property (nonatomic, weak) UIScrollView * scrollView;

//数据
@property (nonatomic, strong) NSMutableArray * adsData;
@property (nonatomic, strong) NSMutableArray * hotTopicData;
@property (nonatomic, strong) NSMutableArray * hotForumsData;
@property (nonatomic, strong) NSMutableArray * fastForumsData;
//广告栏
@property (nonatomic, strong) LJAdsGroupView * adsView;
//按钮
@property (nonatomic, strong) UIView * btnView;
//每日热帖
@property (nonatomic, strong) UIView * hotTopicView;
@property (nonatomic, strong) LJInfiniteScrollView * hotTopicScrollView;
//热门板块
@property (nonatomic, strong) LJHotForumsView * hotForumView;

//刷新
@property (nonatomic, assign, getter=isRefresh) BOOL refresh;
@end

@implementation LJBBSSquareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化滚动视图
    [self setupScrollView];
    
    //初始化广告视图
    [self setupAdsView];
    
    //设置Buttons
    [self setupFastForumView];
    
    //初始化每日热帖
    [self setupHotTopic];
    
    //初始化热门板块
    [self setupHotForums];
    
    self.scrollView.contentSize = CGSizeMake(0, 1000);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.hotTopicScrollView startInfiniteScrollView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.hotTopicScrollView stopScroll];
}

#pragma mark - 初始化UI
//设置滚动视图
- (void)setupScrollView
{
    //scrollview
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = RGBColor(230, 230, 230);
    [self.scrollView addHeaderWithCallback:^{
        [self loadAdsData];
        [self loadHotTopicData];
        [self loadHotForumsData];
        
    }];
}

- (void)endRefresh
{
    if (self.hotTopicData &&
        self.hotForumsData &&
        self.adsData)
    {
        [self.scrollView headerEndRefreshing];
    }
}

//设置广告
- (void)setupAdsView
{
    CGFloat adsX = 10;
    CGFloat adsW = kScrW - adsX * 2;
    CGFloat adsY = 10;
    CGFloat adsH = 100;
    LJAdsGroupView * adsView = [LJAdsGroupView adViewWithAds:self.adsData andFrame:CGRectMake(adsX, adsY, adsW, adsH)];
    adsView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:adsView];
    self.adsView = adsView;
}

//初始化Buttons
- (void)setupFastForumView
{
    UIView * btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.adsView.frame), kScrW, 150)];
    [self.scrollView addSubview:btnView];
    self.btnView = btnView;
    
    CGFloat btnW = (CGRectGetWidth(btnView.frame) - 4 * kPadding) / 3;
    CGFloat btnH = (CGRectGetHeight(btnView.frame) - 3 * kPadding) / 2;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            
            LJBBSList * bbsList = self.fastForumsData[i * 2 + j];
            
            //创建Button
            NSString * imageName = bbsList.listItem.imageUrl;
            imageName = [imageName substringFromIndex:[imageName rangeOfString:@"/"].location + 1];
            LJFastForumButton * btn = [LJFastForumButton fastForumButtonWithImage:imageName];
            btn.fastForumList = self.fastForumsData[i * 2 + j];
            [btn addTarget:self action:@selector(fastForumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat btnX = j * (btnW + kPadding) + kPadding;
            CGFloat btnY = i * (btnH + kPadding) + kPadding;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [self.btnView addSubview:btn];
        }
    }
}

//初始化每日热帖
- (void)setupHotTopic
{
    UIView * hotTopciView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btnView.frame) + kPadding, kScrW, 250)];
    [self.scrollView addSubview:hotTopciView];
    self.hotTopicView = hotTopciView;
    
    //标签
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(kPadding * 2, kPadding, kScrW - 4 * kPadding, 40)];
    lab.text = @"每日热帖";
    lab.textColor = [UIColor grayColor];
    [self.hotTopicView addSubview:lab];
    
    //热帖
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(kPadding, CGRectGetMaxY(lab.frame) + kPadding, kScrW - 2 * kPadding, CGRectGetHeight(self.hotTopicView.frame) - 3 * kPadding - CGRectGetHeight(lab.frame))];
    [self.hotTopicView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    //设置边框
    view.layer.borderColor = [[UIColor grayColor] CGColor];
    view.layer.borderWidth = 1;
    //更多button
    CGFloat moreBtnH = 40;
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    moreBtn.frame =CGRectMake(0, CGRectGetHeight(view.frame) - moreBtnH, CGRectGetWidth(view.frame), moreBtnH);
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreBtn setTitle:@"查看更多热帖" forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreHotTopicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:moreBtn];
    //分割线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, moreBtn.frame.origin.y + 1, CGRectGetWidth(view.frame), 1)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    //scrollview
    LJInfiniteScrollView * scrollView = [[LJInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame),  CGRectGetHeight(view.frame) - moreBtnH)];
    [view addSubview:scrollView];
    self.hotTopicScrollView = scrollView;
    self.hotTopicScrollView.pagingEnabled = YES;
    self.hotTopicScrollView.showsHorizontalScrollIndicator = NO;
    self.hotTopicScrollView.delegate = self;
    
    //加载数据
    [self loadHotTopicData];
}

//初始化热门板块
- (void)setupHotForums
{
    LJHotForumsView * hotForumView = [[LJHotForumsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hotTopicView.frame) + kPadding, kScrW, 0)];
    [self.scrollView addSubview:hotForumView];
    self.hotForumView = hotForumView;
    self.hotForumView.delegate = self;
    [self loadHotForumsData];
}


#pragma mark - 加载数据
//fast forum数据
- (NSMutableArray *)fastForumsData
{
    if (!_fastForumsData) {
        _fastForumsData = [NSMutableArray array];
        [self loadFastForumData];
    }
    return _fastForumsData;
}

- (void)loadFastForumData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:kFastForumDataFileName ofType:nil];
    NSData * jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * bbsListDict in dict[@"children"]) {
        LJBBSList * bbsList = [LJBBSList bbsListWithDict:bbsListDict];
        [arr addObject:bbsList];
    }
    self.fastForumsData = arr;
}

//广告数据
- (NSMutableArray *)adsData
{
    if (!_adsData) {
        _adsData = [NSMutableArray array];
        [self loadAdsData];
    }
    return _adsData;
}

- (void)loadAdsData
{
    NSString * urlStr = kBBSAdsUrl;
    _adsData = nil;
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * adsArr = [NSMutableArray array];
        for (NSDictionary * adsDict in dict[kBBSAdsKey]) {
            LJBBSAds * ads = [LJBBSAds BBSAdsWithDict:adsDict];
            if (ads)
            {
                [adsArr addObject:ads];
            }
        }
        _adsData = adsArr;
        [self reloadAdsData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        [self.scrollView headerEndRefreshing];
        NetworkErrorNotify(self);
    }];
}

- (void)reloadAdsData
{
    [self.adsView reloadViewWithAds:self.adsData];
    [self endRefresh];
}

//每日热帖数据
- (NSMutableArray *)hotTopicData
{
    if (!_hotTopicData) {
        _hotTopicData = [NSMutableArray array];
        [self loadHotTopicData];
    }
    return _hotTopicData;
}

- (void)loadHotTopicData
{
    _hotTopicData = nil;
    NSString * urlStr = [NSString stringWithFormat:kBBSHotTopicUrl, 1];//数量一个
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * hotTopicArr = [NSMutableArray array];
        for (NSDictionary * topicDict in dict[kHotTopicKey]) {
            LJHotTopic * topic = [LJHotTopic hotTopicWithDict:topicDict];
            [hotTopicArr addObject:topic];
        }
        _hotTopicData = hotTopicArr;
        [self reloadHotTopciData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        [self.scrollView headerEndRefreshing];
        NetworkErrorNotify(self);
    }];
}

- (void)reloadHotTopciData
{
    if (self.hotTopicData.count <= 0) return;
    for (int i = 0; i < self.hotTopicData.count + 2; i++) {
        //设置无限循环的数据
        LJHotTopic * topic = nil;
        if (i == 0) {
            topic = self.hotTopicData[self.hotTopicData.count - 1];
        }
        else if(i == self.hotTopicData.count + 1)
        {
            topic = self.hotTopicData[0];
        }
        else
        {
            topic = self.hotTopicData[i - 1];
        }
        
        //创建滚动区域的view
        LJHotTopicView * topicView = [[[UINib nibWithNibName:@"LJHotTopicView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        topicView.topic = topic;
        CGRect frame = topicView.frame;
        frame.origin.x = i * CGRectGetWidth(topicView.frame);
        topicView.frame = frame;
        [self.hotTopicScrollView addSubview:topicView];
        //添加手势
        topicView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotTopciViewClick:)];
        [topicView addGestureRecognizer:tap];
    }
    self.hotTopicScrollView.contentSize = CGSizeMake((self.hotTopicData.count + 2) * CGRectGetWidth(self.hotTopicScrollView.frame), 0);
    [self.hotTopicScrollView startInfiniteScrollView];
    [self endRefresh];//停止刷新
}

//热门板块数据
- (NSMutableArray *)hotForumsData
{
    if (!_hotForumsData) {
        [self loadHotForumsData];
    }
    return _hotForumsData;
}

#pragma mark - 重新加载数据
- (void)loadHotForumsData
{
    _hotForumsData = nil;
    NSString * urlStr = kBBSHotForumsUrl;
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * hotForumArr = [NSMutableArray array];
        for (NSDictionary * forumDict in dict[kHotForumKey]) {
            LJHotForum * forum = [LJHotForum hotForumWithDict:forumDict];
            [hotForumArr addObject:forum];
        }
        _hotForumsData = hotForumArr;
        [self reloadForumData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        [self.scrollView headerEndRefreshing];
        NetworkErrorNotify(self);
    }];
}

- (void)reloadForumData
{
    self.hotForumView.forumsData = self.hotForumsData;
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.hotForumView.frame) + kTabBarH + kNavBarH * 2 + kStatusBarH);
    [self endRefresh];//停止刷新
}

#pragma mark - 滚动视图代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= scrollView.contentSize.width - CGRectGetWidth(scrollView.frame)) {
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame), 0);
    }
}

#pragma mark - 点击加载新界面
//点击每日热帖
- (void)hotTopciViewClick:(UITapGestureRecognizer *)sender
{
    LJHotTopicView * view = (LJHotTopicView *)sender.view;
    if ([self.delegate respondsToSelector:@selector(BBSSquareViewController:didSelectHotTopic:)]) {
        [self.delegate BBSSquareViewController:self didSelectHotTopic:view.topic];
    }
}

//点击热门板块
- (void)hotForumView:(LJHotForumsView *)view didSelectHotForum:(LJHotForum *)hotForum
{
    if ([self.delegate respondsToSelector:@selector(BBSSquareViewController:didSelectHotForum:)])
    {
        [self.delegate BBSSquareViewController:self didSelectHotForum:hotForum];
    }
}

//fast forum点击
- (void)fastForumBtnClick:(LJFastForumButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(BBSSquareViewController:didSelectFastForum:)]) {
        [self.delegate BBSSquareViewController:self didSelectFastForum:sender.fastForumList];
    }
}

//更多热帖button点击
- (void)moreHotTopicBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(BBSSquareViewController:didSelectMoreHotTopic:)])
    {
        [self.delegate BBSSquareViewController:self didSelectMoreHotTopic:[NSString stringWithFormat:kBBSHotTopicUrl, 100]];
    }
}

@end
