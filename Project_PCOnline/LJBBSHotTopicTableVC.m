//
//  LJBBSHotForumsTableVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSHotTopicTableVC.h"
#import "LJHotTopicCell.h"
#import "LJNetWorking.h"
#import "LJBBSTopicDetailWebVC.h"

#define kHotTopicKey @"hot-topics"
#define kHotTopicImageCellIdentifier @"HotTopicImageCell"
#define kHotTopicNoImageCellIdentifier @"HotTopicNoImageCell"
@interface LJBBSHotTopicTableVC ()

@property (nonatomic, strong) NSMutableArray * hotTopicsData;

@end

@implementation LJBBSHotTopicTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJHotTopicImageCell" bundle:nil] forCellReuseIdentifier:kHotTopicImageCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJHotTopicNoImageCell" bundle:nil] forCellReuseIdentifier:kHotTopicNoImageCellIdentifier];
    
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
    [self loadHotTopicsData];
    
}

- (void)loadHotTopicsData
{
    NSString * urlStr = [self setupUrlStr];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * hotTopicArr = [NSMutableArray array];
        for (NSDictionary * topicDict in dict[kHotTopicKey]) {
            LJHotTopic * topic = [LJHotTopic hotTopicWithDict:topicDict];
            [hotTopicArr addObject:topic];
        }
        self.hotTopicsData = hotTopicArr;
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    if ([self.bbsList.listItem.title isEqualToString:@"最数码论坛"]) {
        urlStr = kNewestBBSDetailUrl;
    }
    else
    {
        urlStr = [NSString stringWithFormat:kBBSDetailUrl, [self.bbsList.listItem.ID integerValue]];
    }
    return urlStr;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotTopicsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopic * topic = self.hotTopicsData[indexPath.row];
    LJHotTopicCell * cell = nil;
    if (topic.isShowImage) {
        cell = [tableView dequeueReusableCellWithIdentifier:kHotTopicImageCellIdentifier];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:kHotTopicNoImageCellIdentifier];
    }
    cell.hotTopic = topic;
    return cell;
}

#pragma mark - tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJHotTopic * topic = self.hotTopicsData[indexPath.row];
    if (topic.isShowImage) {
        return 210;
    }
    else
    {
        return 150;
    }
}

#pragma mark - 选中一个帖子
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(BBSTopicTableVC:didSelectTopic:inBBSList:)]) {
        LJHotTopic * topic = self.hotTopicsData[indexPath.row];
        [self.delegate BBSTopicTableVC:self didSelectTopic:topic inBBSList:self.bbsList];
    }
}

@end
