//
//  LJBBSFastForumTVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSFastForumTVC.h"
#import "UIImage+MyImage.h"
#import "LJFastForumHeaderView.h"
#import "LJNetWorkingTool.h"
#import "LJHotTopic.h"
#import "LJHotTopicFrame.h"
#import "LJHotTopicCell.h"
#import "LJBBSTopicDetailWebVC.h"
#import "LJBBSSubForumTVC.h"
#import "MJRefresh/MJRefresh.h"

#define kTopicPerPage 20

@interface LJBBSFastForumTVC ()<LJFastForumHeaderViewDelegate, UINavigationControllerDelegate>

/**
 *  热门帖子数据
 */
@property (nonatomic, strong) NSMutableArray * topicsData;

/**
 *  当前页
 */
@property (nonatomic, assign) NSInteger curPage;

/**
 *  是否需要刷新，第一次进入时需要刷新
 */
@property (nonatomic, assign, getter=isRefresh) BOOL refresh;

@end

@implementation LJBBSFastForumTVC

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage = 1;
    self.refresh = YES;
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = LightGrayBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置下拉刷新和上拉加载更多
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.curPage = 1;
        [weakSelf loadTopicsData];
    }];
    [self.tableView addFooterWithCallback:^{
        weakSelf.curPage++;
        [weakSelf.tableView reloadData];
    }];
    
    //注册cell
    [self.tableView registerClass:[LJHotTopicCell class] forCellReuseIdentifier:LJTopicCellIdentifier];
}

- (void)setFastForumList:(LJBBSList *)fastForumList
{
    _fastForumList = fastForumList;
    //设置headerview
    LJFastForumHeaderView * header = [LJFastForumHeaderView fastForumHeaderViewWithBBSList:self.fastForumList];
    self.tableView.tableHeaderView = header;
    header.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.fastForumList.listItem.title;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName:NavBarTitleFont}];
    
    //刷新数据
    if (self.isRefresh)
    {
        [self.tableView headerBeginRefreshing];
        self.refresh = NO;
    }
}

- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return MIN(kTopicPerPage * self.curPage, self.topicsData.count);
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:LJTopicCellIdentifier];
    LJHotTopicFrame * topicFrame = self.topicsData[indexPath.row];
    cell.topicFrame = topicFrame;
    return cell;
}

#pragma mark - 加载数据
- (NSMutableArray *)topicsData
{
    if (!_topicsData)
    {
        _topicsData = [NSMutableArray array];
        [self loadTopicsData];
    }
    return _topicsData;
}

- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    if (self.fastForumList.listItem.ID.integerValue < 0)
    {
        urlStr = [NSString stringWithFormat:kZuiFastForumDetaiUrl, self.fastForumList.subItemIDStr];
    }
    else
    {
        urlStr = [NSString stringWithFormat:kFastForumDetailUrl, self.fastForumList.subItemIDStr];
    }
    return urlStr;
}

- (void)loadTopicsData
{
    NSString * urlStr = [self setupUrlStr];
    LJLog(@"url:%@", urlStr);
    [LJNetWorkingTool GET:urlStr parameters:self success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * topicArr = [NSMutableArray array];
        for (NSDictionary * topicDict in dict[@"hot-topics"]) {
            LJHotTopic * topic = [LJHotTopic hotTopicWithDict:topicDict];
            LJHotTopicFrame * topicFrame = [LJHotTopicFrame hotTopicFrameWithTopic:topic];
            [topicArr addObject:topicFrame];
        }
        self.topicsData = topicArr;
        
        //重新加载数据
        [self.tableView reloadData];
        
        //停止刷新
        [self.tableView headerEndRefreshing];
        
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopicFrame * topicFrame = self.topicsData[indexPath.row];
    return topicFrame.cellHeigh;
}

#pragma 选中一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopicFrame * topicFrame = self.topicsData[indexPath.row];
    LJBBSTopicDetailWebVC * detailVC = [[LJBBSTopicDetailWebVC alloc] init];
    assert([topicFrame.topic isKindOfClass:[LJHotTopic class]]);
    detailVC.topic = (LJHotTopic *)topicFrame.topic;
    detailVC.bbsItem = self.fastForumList.listItem;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 选中header 上的button，headerview的代理方法
- (void)fastForumHeaderView:(LJFastForumHeaderView *)header didSelectForumItem:(LJBBSListItem *)item
{
    LJBBSSubForumTVC * subForumTVC = [[LJBBSSubForumTVC alloc] init];
    subForumTVC.bbsItem = item;
    [self.navigationController pushViewController:subForumTVC animated:YES];
}

@end
