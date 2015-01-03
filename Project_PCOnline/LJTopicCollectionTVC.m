//
//  LJTopicCollectionTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJTopicCollectionTVC.h"
#import "LJCollectionBGView.h"
#import "MJRefresh.h"

#define kLJTopicCollectionTableCellIdentifier @"LJTopicCollectionTableCell"

@interface LJTopicCollectionTVC ()
/**
 *  没有收藏时显示的背景View
 */
@property (nonatomic, weak) LJCollectionBGView * bgView;

/**
 *  收藏的帖子
 */
@property (nonatomic, strong) NSArray * topicCollectionData;

@end

@implementation LJTopicCollectionTVC

@synthesize topicCollectionData = _topicCollectionData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置没有收藏时的背景
    [self setupBackgroup];
    
    //添加下拉刷新
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.topicCollectionData = [LJTopicDao selectAllTopicItemFromDB];
    }];
}

#pragma mark - init UI
- (void)setupBackgroup
{
    //bg
    LJCollectionBGView * bgView = [[LJCollectionBGView alloc] initWithFrame:self.view.bounds];
    bgView.bgType = LJCollectionBGViewTypeTopic;
    [self.view addSubview:bgView];
    self.bgView = bgView;
}

/**
 *  设置显示或隐藏背景
 */
- (void)hideOrShowBg
{
    if (_topicCollectionData.count == 0)
    {
        self.bgView.hidden = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.bgView.hidden = YES;
    }
}


#pragma mark - setup data
- (NSArray *)topicCollectionData
{
    if (!_topicCollectionData)
    {
        _topicCollectionData = [LJTopicDao selectAllTopicItemFromDB];
        [self hideOrShowBg];
    }
    return _topicCollectionData;
}

- (void)setTopicCollectionData:(NSArray *)topicCollectionData
{
    _topicCollectionData = topicCollectionData;
    [self.tableView reloadData];
    
    //如果正在下拉刷新，则停止刷新
    if([self.tableView isHeaderRefreshing]) [self.tableView headerEndRefreshing];
    
    //显示/吟唱背景
    [self hideOrShowBg];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicCollectionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJTopicCollectionTableCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLJTopicCollectionTableCellIdentifier];
    }
    
    LJTopicDaoModel * item = self.topicCollectionData[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJTopicDaoModel * topic = self.topicCollectionData[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(topicCollectionTVC:didSelectTopic:)])
    {
        [self.delegate topicCollectionTVC:self didSelectTopic:topic];
    }
}

#pragma mark - table view editing
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle != UITableViewCellEditingStyleDelete) return;
    
    LJTopicDaoModel * item = self.topicCollectionData[indexPath.row];
    [LJTopicDao removeTopicItemFromDB:item];
    self.topicCollectionData = [LJTopicDao selectAllTopicItemFromDB];
}

@end
