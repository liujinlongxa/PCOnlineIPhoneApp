//
//  LJBBSSquareViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSquareViewController.h"
#import "LJAdsGroupView.h"
#import "LJNetWorking.h"
#import "LJHotTopicView.h"
//模型
#import "LJBBSAds.h"
#import "LJHotTopic.h"

#define kBBSAdsKey @"focus"
#define kHotTopicKey @"hot-topics"
#define kPadding 10

@interface LJBBSSquareViewController ()

//scrollView
@property (nonatomic, weak) UIScrollView * scrollView;

//数据
@property (nonatomic, strong) NSMutableArray * adsData;
@property (nonatomic, strong) NSMutableArray * hotTopicData;
@property (nonatomic, strong) NSMutableArray * hotForumsData;
//广告栏
@property (nonatomic, strong) LJAdsGroupView * adsView;
//按钮
@property (nonatomic, strong) UIView * btnView;
//每日热帖
@property (nonatomic, strong) UIView * hotTopicView;
@property (nonatomic, strong) UIScrollView * hotTopicScrollView;
@end

@implementation LJBBSSquareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化滚动视图
    [self setupScrollView];
    
    //初始化广告视图
    [self setupAdsView];
    
    //设置Buttons
    [self setupButtons];
    
    //初始化每日热帖
    [self setupHotTopic];
    
    self.scrollView.contentSize = CGSizeMake(0, 1000);
}

#pragma mark - 初始化
//设置滚动视图
- (void)setupScrollView
{
    //scrollview
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = [UIColor whiteColor];
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
- (void)setupButtons
{
    UIView * btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.adsView.frame), kScrW, 150)];
    [self.scrollView addSubview:btnView];
    self.btnView = btnView;
    
    //设置button
    [self setupButtonWithImage:@"fast_forum_shouji"];
    [self setupButtonWithImage:@"fast_forum_diy"];
    [self setupButtonWithImage:@"fast_forum_bijiben"];
    [self setupButtonWithImage:@"fast_forum_zuishuma"];
    [self setupButtonWithImage:@"fast_forum_ershou"];
    [self setupButtonWithImage:@"fast_forum_sheying"];
    
    CGFloat btnW = (CGRectGetWidth(btnView.frame) - 4 * kPadding) / 3;
    CGFloat btnH = (CGRectGetHeight(btnView.frame) - 3 * kPadding) / 2;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            CGFloat btnX = j * (btnW + kPadding) + kPadding;
            CGFloat btnY = i * (btnH + kPadding) + kPadding;
            [self.btnView.subviews[i * 3 + j] setFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        }
    }
    
}

- (UIButton *)setupButtonWithImage:(NSString *)imageName
{
    UIButton * btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.btnView addSubview:btn];
    return btn;
}

//初始化每日热帖
- (void)setupHotTopic
{
    UIView * hotTopciView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btnView.frame) + kPadding, kScrW, 300)];
    [self.scrollView addSubview:hotTopciView];
    self.hotTopicView = hotTopciView;
    
    //标签
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(kPadding * 2, kPadding, kScrW - 4 * kPadding, 40)];
    lab.text = @"每日热帖";
    [self.hotTopicView addSubview:lab];
    
    //热帖
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(kPadding, CGRectGetMaxY(lab.frame) + kPadding, kScrW - 2 * kPadding, CGRectGetHeight(self.hotTopicView.frame) - 3 * kPadding - CGRectGetHeight(lab.frame))];
    [self.hotTopicView addSubview:view];
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
    moreBtn.backgroundColor = [UIColor redColor];
    [view addSubview:moreBtn];
    //分割线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, moreBtn.frame.origin.y - 1, CGRectGetWidth(view.frame), 1)];
    line.backgroundColor = [UIColor greenColor];
    [view addSubview:line];
    //scrollview
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kPadding, kPadding, CGRectGetWidth(view.frame) - 2 * kPadding,  CGRectGetHeight(view.frame) - moreBtnH - 2 * kPadding)];
    [view addSubview:scrollView];
    self.hotTopicScrollView = scrollView;
    self.hotTopicScrollView.backgroundColor = [UIColor yellowColor];
    
    //加载数据
    [self loadHotTopicData];
}


#pragma mark - 加载数据
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
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * adsArr = [NSMutableArray array];
        for (NSDictionary * adsDict in dict[kBBSAdsKey]) {
            LJBBSAds * ads = [LJBBSAds BBSAdsWithDict:adsDict];
            [adsArr addObject:ads];
        }
        _adsData = adsArr;
        [self reloadAdsData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)reloadAdsData
{
    [self.adsView reloadViewWithAds:self.adsData];
}

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
    NSString * urlStr = kBBSHotTopicUrl;
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
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
        NSLog(@"%@", error);
    }];
}

- (void)reloadHotTopciData
{
    for (int i = 0; i < self.hotTopicData.count; i++) {
        LJHotTopic * topic = self.hotTopicData[i];
        LJHotTopicView * topicView = [[[UINib nibWithNibName:@"LJHotTopicView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        topicView.topic = topic;
        [self.hotTopicScrollView addSubview:topicView];
    }
    self.hotTopicScrollView.contentSize = CGSizeMake(self.hotTopicData.count * CGRectGetWidth(self.hotTopicScrollView.frame), 0);
}











@end
