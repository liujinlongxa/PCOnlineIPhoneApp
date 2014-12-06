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
#import "LJNetWorking.h"
#import "UIImage+MyImage.h"
#import "LJBBSTopicDetailWebVC.h"

static NSString * const LJTopicOrderByLastReply = @"replyat";
static NSString * const LJTopicOrderByPostTime = @"postat";

@interface LJBBSSubForumTVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * topicFramesData;
@property (nonatomic, copy) NSString * curOrderBy;

@end

@implementation LJBBSSubForumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tablview
    [self setupTableView];
    
    self.curOrderBy = LJTopicOrderByLastReply;

}

#pragma mark - 初始化UI
//初始化tableView
- (void)setupTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LJHotTopicCell class] forCellReuseIdentifier:LJTopicCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.bbsItem.title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    UIBarButtonItem * collectItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_toolbar_collect"] style:UIBarButtonItemStylePlain target:self action:@selector(collectBtnClick:)];
    UIBarButtonItem * sendItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_topic_list_send_topic"] style:UIBarButtonItemStylePlain target:self action:@selector(sendBtnClick:)];
    self.navigationItem.rightBarButtonItems = @[sendItem, collectItem];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
        [self loadTopicFrameData];
    }
    return _topicFramesData;
}

- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    if (self.bbsItem.ID.integerValue < 0)
    {
        urlStr = [NSString stringWithFormat:kZuiSunForumTopicListUrl, -self.bbsItem.ID.integerValue, self.curOrderBy];
    }
    else
    {
        urlStr = [NSString stringWithFormat:kSubForumTopicListUrl, self.bbsItem.ID.integerValue, self.curOrderBy];
    }
    return urlStr;
}

- (void)loadTopicFrameData
{
    NSString * urlStr = [self setupUrlStr];
    LJLog(@"url:%@", urlStr);
    [LJNetWorking GET:urlStr parameters:self success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * topicArr = [NSMutableArray array];
        for (NSDictionary * topicDict in dict[@"topicList"]) {
            LJTopic * topic = [LJTopic topciWithDict:topicDict];
            LJTopicFrame * topicFrame = [LJTopicFrame topicFrameWithTopic:topic];
            [topicArr addObject:topicFrame];
        }
        self.topicFramesData = topicArr;
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - tableview代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJTopicFrame * topicFrame = self.topicFramesData[indexPath.row];
    return topicFrame.cellHeigh;
}

#pragma mark - 导航栏按钮事件
- (void)collectBtnClick:(id)sender
{
    
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

@end
