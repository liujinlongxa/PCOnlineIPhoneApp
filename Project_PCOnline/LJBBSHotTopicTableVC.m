//
//  LJBBSHotForumsTableVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSHotTopicTableVC.h"
#import "LJHotTopicCell.h"
#import "LJNetWorkingTool.h"
#import "LJBBSTopicDetailWebVC.h"
#import "LJBBSTopicDetailWebVC.h"
#import "MJRefresh/MJRefresh.h"
//模型
#import "LJHotTopicFrame.h"
#import "UIImage+MyImage.h"

#define kHotTopicKey @"hot-topics"
#define kTopicPerPage 20
@interface LJBBSHotTopicTableVC ()
/**
 *  热门帖子数据
 */
@property (nonatomic, strong) NSMutableArray * hotTopicsData;
/**
 *  当前分页
 */
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation LJBBSHotTopicTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupTableView];
    
}

- (void)setupTableView
{
    //设置tableview 偏移
    NSInteger offset = self.urlStr == nil ? kNavBarH + 40 : 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, offset, 0);
    self.tableView.backgroundColor = LightGrayBGColor;
    
    //添加上拉刷新和下拉加载更多
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.curPage = 1;
        [weakSelf loadHotTopicsData];
    }];
    [self.tableView addFooterWithCallback:^{
        weakSelf.curPage++;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView footerEndRefreshing];
    }];
    
    [self.tableView registerClass:[LJHotTopicCell class] forCellReuseIdentifier:LJTopicCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.title = self.bbsList != nil ? self.bbsList.listItem.title : @"每日热帖";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:NavBarTitleFont}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

//导航栏返回
- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载数据
- (NSMutableArray *)hotTopicsData
{
    if (!_hotTopicsData) {
        _hotTopicsData = [NSMutableArray array];
    }
    return _hotTopicsData;
}

- (void)setBbsList:(LJBBSList *)bbsList
{
    _bbsList = bbsList;
    //开始刷新数据
    [self.tableView headerBeginRefreshing];
}

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    //开始刷新数据
    [self.tableView headerBeginRefreshing];
}

- (void)loadHotTopicsData
{
    NSString * urlStr = [self setupUrlStr];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * hotTopicArr = [NSMutableArray array];
        for (NSDictionary * topicDict in dict[kHotTopicKey]) {
            LJHotTopic * topic = [LJHotTopic hotTopicWithDict:topicDict];
            LJHotTopicFrame * topicFrame = [LJHotTopicFrame hotTopicFrameWithTopic:topic];
            [hotTopicArr addObject:topicFrame];
        }
        self.hotTopicsData = hotTopicArr;
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}
/**
 *  设置Url
 *
 *  @return 返回设置好的Url
 */
- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    if (self.bbsList == nil)
    {
        //点击论坛广场的更多热帖button
        urlStr = self.urlStr;
    }
    else if (self.bbsList.listItem.ID.integerValue < 0) {
        urlStr = kZuiBBSDetailUrl; //最数码论坛
    }
    else
    {
        urlStr = [NSString stringWithFormat:kBBSDetailUrl, [self.bbsList.listItem.ID integerValue]];
    }
    return urlStr;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MIN(kTopicPerPage * self.curPage, self.hotTopicsData.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopicFrame * topicFrame = self.hotTopicsData[indexPath.row];
    LJHotTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:LJTopicCellIdentifier];
    cell.topicFrame = topicFrame;
    return cell;
}


#pragma mark - tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopicFrame * topicFrame = self.hotTopicsData[indexPath.row];
    return topicFrame.cellHeigh;
}

#pragma mark - 选中一个帖子
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopicFrame * topicFrame = self.hotTopicsData[indexPath.row];
    if (self.bbsList == nil)
    {
        //论坛广场点击更多热帖Button，直接使用导航控制器进行跳转
        LJBBSTopicDetailWebVC * webVC = [[LJBBSTopicDetailWebVC alloc] init];
        webVC.topic = topicFrame.topic;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else
    {
        //论坛列表使用代理，代理到父控制器进行跳转
        if ([self.delegate respondsToSelector:@selector(BBSTopicTableVC:didSelectTopic:inBBSList:)]) {
            [self.delegate BBSTopicTableVC:self didSelectTopic:topicFrame.topic inBBSList:self.bbsList];
        }
    }
}

@end
