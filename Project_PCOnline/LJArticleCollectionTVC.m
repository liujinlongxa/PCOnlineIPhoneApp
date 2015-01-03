//
//  LJArticleCollectionTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJArticleCollectionTVC.h"
#import "LJCollectionBGView.h"
#import "LJCommonHeader.h"
#import "LJArticleDao.h"
#import "MJRefresh/MJRefresh.h"

#define kLJArticleCollectionTableCellIdentifier @"LJArticleCollectionTableCell"

@interface LJArticleCollectionTVC ()

/**
 *  没有收藏时显示的背景View
 */
@property (nonatomic, weak) LJCollectionBGView * bgView;

/**
 *  收藏的文章
 */
@property (nonatomic, strong) NSArray * articleCollectionData;

@end

@implementation LJArticleCollectionTVC

@synthesize articleCollectionData = _articleCollectionData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置没有收藏时的背景
    [self setupBackgroup];
    
    //添加下拉刷新
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.articleCollectionData = [LJArticleDao selectAllArticleFromDB];
    }];
}

#pragma mark - init UI
- (void)setupBackgroup
{
    //bg
    LJCollectionBGView * bgView = [[LJCollectionBGView alloc] initWithFrame:self.view.bounds];
    bgView.bgType = LJCollectionBGViewTypeArticle;
    [self.view addSubview:bgView];
    self.bgView = bgView;
}

/**
 *  设置显示或隐藏背景
 */
- (void)hideOrShowBg
{
    if (_articleCollectionData.count == 0)
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
- (NSArray *)articleCollectionData
{
    if (!_articleCollectionData)
    {
        _articleCollectionData = [LJArticleDao selectAllArticleFromDB];
        [self hideOrShowBg];
    }
    return _articleCollectionData;
}

- (void)setArticleCollectionData:(NSArray *)articleCollectionData
{
    _articleCollectionData = articleCollectionData;
    [self.tableView reloadData];
    
    //如果正在下拉刷新，停止刷新
    if ([self.tableView isHeaderRefreshing]) [self.tableView headerEndRefreshing];
    
    //设置背景
    [self hideOrShowBg];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleCollectionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJArticleCollectionTableCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLJArticleCollectionTableCellIdentifier];
    }
    
    LJArticleDaoModel * item = self.articleCollectionData[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJArticleDaoModel * article = self.articleCollectionData[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(articleCollectionTVC:didSelectArticle:)])
    {
        [self.delegate articleCollectionTVC:self didSelectArticle:article];
    }
}

#pragma mark - table view editing
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle != UITableViewCellEditingStyleDelete) return;
    
    LJArticleDaoModel * model = self.articleCollectionData[indexPath.row];
    [LJArticleDao removeArticleFromDB:model];
    self.articleCollectionData = [LJArticleDao selectAllArticleFromDB];
}

@end
