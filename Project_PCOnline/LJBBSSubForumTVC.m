//
//  LJBBSSubForumTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSubForumTVC.h"
#import "LJTopic.h"
#import "LJTopicFrame.h"
#import "LJHotTopicCell.h"
#import "LJCommonHeader.h"
#import "LJUrlHeader.h"
#import "LJNetWorkingTool.h"
#import "UIImage+MyImage.h"
#import "LJBBSTopicDetailWebVC.h"
#import "LJPullingBar.h"
#import "LJCollectionButton.h"
#import "MJRefresh/MJRefresh.h"
#import "LJBBSListItemDao.h"

static NSString * const LJTopicOrderByLastReply = @"replyat";
static NSString * const LJTopicOrderByPostTime = @"postat";

@interface LJBBSSubForumTVC ()<UITableViewDataSource, UITableViewDelegate, LJPullingBarDelegate>

@property (nonatomic, weak) UITableView * tableView;
/**
 *  帖子数据
 */
@property (nonatomic, strong) NSMutableArray * topicFramesData;
/**
 *  排序方法
 */
@property (nonatomic, copy) NSString * curOrderBy;
/**
 *  pull bar (最新回复，最近发表，精华帖）
 */
@property (nonatomic, weak) LJPullingBar * pullBar;
/**
 *  导航栏文字
 */
@property (nonatomic, weak) UILabel * backLab;
/**
 *  当前分页数
 */
@property (nonatomic, assign) NSInteger curPage;
/**
 *  是否需要刷新
 */
@property (nonatomic, assign, getter=isRefresh) BOOL refresh;
@end

@implementation LJBBSSubForumTVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tablview
    [self setupTableView];
    
    //当前排序方法
    self.curOrderBy = LJTopicOrderByLastReply;
    //当前页数
    self.curPage = 1;
    [self setupPullingBar];
}

- (void)setupPullingBar
{
    LJPullingBar * pullBar = [[LJPullingBar alloc] initPullingBarWithFrame:CGRectMake(0, 0, kScrW, 30) andTitles:@[@"最新回复", @"最近发表", @"精华帖"]];
    [self.view addSubview:pullBar];
    self.pullBar = pullBar;
    self.pullBar.delegate = self;
}

#pragma mark - 初始化UI
//初始化tableView
- (void)setupTableView
{
    CGFloat offset = 10;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, offset, kScrW, kScrH - offset - kNavBarH - kStatusBarH) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LightGrayBGColor;
    [self.tableView registerClass:[LJHotTopicCell class] forCellReuseIdentifier:LJTopicCellIdentifier];
    
    //添加上拉刷新和下拉加载更多
    [self.tableView addHeaderWithCallback:^{
        self.curPage = 1;
        [self loadTopicFrameData];
    }];
    [self.tableView addFooterWithCallback:^{
        self.curPage++;
        [self loadTopicFrameData];
    }];
    
    self.refresh = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     *  设置导航栏
     */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    //间距
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -20;
    
    //left items
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    UILabel * backLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    backLab.text = self.bbsItem.title;
    backLab.font = NavBarTitleFont;
    self.backLab = backLab;
    UIBarButtonItem * backLabItem = [[UIBarButtonItem alloc] initWithCustomView:backLab];
    self.navigationItem.leftBarButtonItems = @[space, backItem, space, space, backLabItem];
    
    //right items
    
    //收藏
    LJCollectionButton * btn = [[LJCollectionButton alloc] init];
    NSCParameterAssert(self.bbsItem);
    //在数据库中查询是否存在
    [btn setSelected:[LJBBSListItemDao selectWithExistItem:self.bbsItem] withAnimation:NO];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * collectItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //回复
    UIBarButtonItem * sendItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_topic_list_send_topic"] style:UIBarButtonItemStylePlain target:self action:@selector(sendBtnClick:)];
    self.navigationItem.rightBarButtonItems = @[sendItem, space, collectItem];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    //begin refresh
    if (self.isRefresh) {
        [self.tableView headerBeginRefreshing];
        self.refresh = NO;
    }
    
}

#pragma mark - tableview 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicFramesData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:LJTopicCellIdentifier];
    LJTopicFrame * topicFrame = self.topicFramesData[indexPath.row];
    cell.topicFrame = topicFrame;
    return cell;
}

#pragma mark - 加载数据
- (NSMutableArray *)topicFramesData
{
    if (!_topicFramesData)
    {
        _topicFramesData = [NSMutableArray array];
    }
    return _topicFramesData;
}

- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    NSInteger forumID = self.bbsItem.ID.integerValue;
    //精华帖
    if (self.curOrderBy == nil) {
        if (forumID < 0)
        {
            urlStr = [NSString stringWithFormat:kZuiEssenceTopicListUrl, -forumID, self.curPage];
        }
        else
        {
            urlStr = [NSString stringWithFormat:kEssenceTopicListUrl, forumID, self.curPage];
        }
    }
    else
    {
        if (forumID < 0)
        {
            urlStr = [NSString stringWithFormat:kZuiSunForumTopicListUrl, -forumID, self.curPage, self.curOrderBy];
        }
        else
        {
            urlStr = [NSString stringWithFormat:kSubForumTopicListUrl, forumID, self.curPage, self.curOrderBy];
        }
    }

    return urlStr;
}

- (void)loadTopicFrameData
{
    NSString * urlStr = [self setupUrlStr];
    [LJNetWorkingTool GET:urlStr parameters:self success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //设置论坛属性
        self.backLab.text = dict[@"forum"][@"name"];
        
        //如果数据持久化模型中title为空，则设置title
        if (!self.bbsItem.title)
        {
            self.bbsItem.title = dict[@"forum"][@"name"];
        }
        
        NSMutableArray * topicArr = [NSMutableArray array];
        for (NSDictionary * topicDict in dict[@"topicList"]) {
            LJTopic * topic = [LJTopic topciWithDict:topicDict];
            LJTopicFrame * topicFrame = [LJTopicFrame topicFrameWithTopic:topic];
            [topicArr addObject:topicFrame];
        }
        
        if (self.curPage == 1)
        {
            self.topicFramesData = topicArr;
        }
        else
        {
            //加载更多
            [self.topicFramesData addObjectsFromArray:topicArr];
        }
        
        [self.tableView reloadData];
        
        //end refresh
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }];
}

#pragma mark - tableview代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJTopicFrame * topicFrame = self.topicFramesData[indexPath.row];
    return topicFrame.cellHeigh;
}

#pragma mark - 导航栏按钮事件
- (void)collectBtnClick:(LJCollectionButton *)sender
{
    //没有网络时，点击收藏无效, 可以取消收藏，当不能添加收藏
    if (!sender.isSelected && ![LJNetWorkingTool shareNetworkTool].isCanReachInternet)
    {
        NetworkErrorNotify(self);
        return;
    }
    
    if (sender.isSelected)
    {
        //从数据库中删除
        [LJBBSListItemDao removeBBSListItemFromDB:self.bbsItem];
    }
    else
    {
        //添加到数据库
        [LJBBSListItemDao addBBSListItemToDB:self.bbsItem];
    }
    [sender setSelected:!sender.isSelected withAnimation:YES];
}

- (void)sendBtnClick:(id)sender
{
    
}

- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击某个帖子
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJTopicFrame * topicFrame = self.topicFramesData[indexPath.row];
    LJBBSTopicDetailWebVC * webVC = [[LJBBSTopicDetailWebVC alloc] init];
    webVC.topic = topicFrame.topic;
    webVC.bbsItem = self.bbsItem;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - pulling bar 代理方法
- (void)pullingBar:(LJPullingBar *)bar didSelectBtnAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.curOrderBy = LJTopicOrderByLastReply;
            break;
        case 1:
            self.curOrderBy = LJTopicOrderByPostTime;
            break;
        case 2:
            self.curOrderBy = nil;
            break;
        default:
            break;
    }
    [self.tableView headerBeginRefreshing];
}

@end
