//
//  LJBBSViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSViewController.h"
#import "LJBBSButtonView.h"
#import "LJSelectButton.h"
#import "LJBBSListViewController.h"
#import "LJBBSSquareViewController.h"
#import "LJBBSRecentViewController.h"
#import "LJBBSAds.h"
//Detail List
#import "LJBBSListDetailController.h"
#import "LJBBSHotTopicTableVC.h"
#import "LJBBSSubForumListTVC.h"
#import "LJBBSTopicDetailWebVC.h"
#import "LJBBSFastForumTVC.h"
#import "LJBBSSubForumTVC.h"

@interface LJBBSViewController ()<LJBBSButtonViewDelegate, LJBBSListViewControllerDelegate, LJBBSSquareViewControllerDelegate>

@property (nonatomic, assign) LJSelectButton * curSelectedButton;

//控制器
@property (nonatomic, strong) LJBBSSquareViewController * squareVC;
@property (nonatomic, strong) LJBBSListViewController * listVC;
@property (nonatomic, strong) LJBBSRecentViewController * recentVC;

@property (nonatomic, strong) LJScrollTabViewController * scrollTabViewController;

//显示区域
@property (nonatomic, weak) UIView * showView;
@end

@implementation LJBBSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"论坛";
    
  //设置显示区域
    UIView * showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kNavBarH - kTabBarH - kStatusBarH)];
    [self.view addSubview:showView];
    self.showView = showView;
    
    //设置控制器
    [self setupControllers];
    
    //注册广告接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adsClick:) name:LJAdsViewTapNotify object:nil];
}

- (void)dealloc
{
    //删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupControllers
{
    //论坛列表
    self.listVC = [[LJBBSListViewController alloc] init];
    self.listVC.delegate = self;
    //最新浏览
    self.recentVC = [[LJBBSRecentViewController alloc] init];
    //论坛广场
    self.squareVC = [[LJBBSSquareViewController alloc] init];
    self.squareVC.delegate = self;
    self.scrollTabViewController = [LJScrollTabViewController scrollTabViewControllerWithController:@[self.squareVC, self.listVC, self.recentVC] andTitles:@[@"论坛广场", @"论坛列表", @"最近浏览"]];
    [self.showView addSubview:self.scrollTabViewController.view];
}

#pragma mark - 论坛列表选中一行代理方法
- (void)BBSListViewController:(LJBBSListViewController *)controller didSelectedBBS:(LJBBSList *)bbsList
{
    if ([bbsList.listItem.title isEqualToString:@"家电论坛"]) {
        LJBBSSubForumTVC * subForumTVC = [[LJBBSSubForumTVC alloc] init];
        subForumTVC.bbsItem = bbsList.listItem;
        [self.navigationController pushViewController:subForumTVC animated:YES];
    }
    else
    {
        LJBBSHotTopicTableVC * hotPostsTCV = [[LJBBSHotTopicTableVC alloc] init];
        LJBBSSubForumListTVC * subForumTVC = [[LJBBSSubForumListTVC alloc] init];
        //创建scrollTabVC
        LJBBSListDetailController * detailVC = [LJBBSListDetailController BBSListDetailControllerWithControllers:@[hotPostsTCV, subForumTVC] andTitles:@[@"热门帖子", @"板块列表"]];
        detailVC.bbsList = bbsList;
        //设置代理
        hotPostsTCV.delegate = detailVC;
        subForumTVC.delegate = detailVC;
        [self.navigationController pushViewController:detailVC animated:YES];

    }
}

#pragma mark - 广告点击
- (void)adsClick:(NSNotification *)notify
{
    id ads = notify.userInfo[LJAdsViewTapNotifyAdsKey];
    if ([ads isKindOfClass:[LJBBSAds class]]) {
        LJBBSAds * bbsAds = (LJBBSAds *)ads;
        LJBBSTopicDetailWebVC * topicDetailWeb = [[LJBBSTopicDetailWebVC alloc] initBBSTopicDetailWebVCWithBaseUrlStr:bbsAds.url andTopicId:@(bbsAds.topicId.integerValue)];
        topicDetailWeb.bbsAds = bbsAds;
        [self.navigationController pushViewController:topicDetailWeb animated:YES];
    }
}

#pragma mark - 点击热帖
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectHotTopic:(LJBaseTopic *)topic
{
    LJBBSTopicDetailWebVC * webVC = [[LJBBSTopicDetailWebVC alloc] initBBSTopicDetailWebVCWithBaseUrlStr:kBBSTopicDetailUrl andTopicId:topic.topicId];
    webVC.topic = topic;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 点击热门板块
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectHotForum:(LJHotForum *)hotForum
{
    LJBBSSubForumTVC * subForumTVC = [[LJBBSSubForumTVC alloc] init];
    subForumTVC.bbsItem = hotForum.bbsItem;
    [self.navigationController pushViewController:subForumTVC animated:YES];
}

#pragma mark - 点击fast forum
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectFastForum:(LJBBSList *)bbsList
{
    LJBBSFastForumTVC * fastForumTVC = [[LJBBSFastForumTVC alloc] initWithStyle:UITableViewStylePlain];
    fastForumTVC.fastForumList = bbsList;
    [self.navigationController pushViewController:fastForumTVC animated:YES];
}

#pragma 点击更多热帖Button
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectMoreHotTopic:(NSString *)urlStr
{
    LJBBSHotTopicTableVC * hotTopicTVC = [[LJBBSHotTopicTableVC alloc] init];
    hotTopicTVC.urlStr = urlStr;//加载更多
    [self.navigationController pushViewController:hotTopicTVC animated:YES];
}

@end
