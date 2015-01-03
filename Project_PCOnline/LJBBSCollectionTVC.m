//
//  LJBBSCollectionTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJBBSCollectionTVC.h"
#import "LJCollectionBGView.h"
#import "LJBBSListItemDao.h"
#import "MJRefresh/MJRefresh.h"

#define kLJBBSCollectionTableCellIdentifier @"LJBBSCollectionTableCell"

@interface LJBBSCollectionTVC ()
/**
 *  没有收藏时显示的背景View
 */
@property (nonatomic, weak) LJCollectionBGView * bgView;

/**
 *  收藏的论坛
 */
@property (nonatomic, strong) NSArray * bbsCollectionData;

@end

@implementation LJBBSCollectionTVC

@synthesize bbsCollectionData = _bbsCollectionData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置没有收藏时的背景
    [self setupBackgroup];
    
    //添加下拉刷新
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.bbsCollectionData = [LJBBSListItemDao selectAllBBSListItemFromDB];
    }];
}

#pragma mark - init UI
- (void)setupBackgroup
{
    //bg
    LJCollectionBGView * bgView = [[LJCollectionBGView alloc] initWithFrame:self.view.bounds];
    bgView.hidden = YES;
    bgView.bgType = LJCollectionBGViewTypeBBS;
    [self.view addSubview:bgView];
    self.bgView = bgView;
}

/**
 *  设置显示或隐藏背景
 */
- (void)hideOrShowBg
{
    if (_bbsCollectionData.count == 0)
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
- (NSArray *)bbsCollectionData
{
    if (!_bbsCollectionData)
    {
        _bbsCollectionData = [LJBBSListItemDao selectAllBBSListItemFromDB];
        [self hideOrShowBg];
    }
    return _bbsCollectionData;
}

- (void)setBbsCollectionData:(NSArray *)bbsCollectionData
{
    _bbsCollectionData = bbsCollectionData;
    [self.tableView reloadData];
    
    //如果正在下拉刷新，则停止刷新
    if([self.tableView isHeaderRefreshing]) [self.tableView headerEndRefreshing];
    
    //隐藏/显示背景
    [self hideOrShowBg];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bbsCollectionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJBBSCollectionTableCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLJBBSCollectionTableCellIdentifier];
    }
    
    LJBBSListItem * item = self.bbsCollectionData[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

#pragma  mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBBSListItem * item = self.bbsCollectionData[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(bbsCollectionTVC:didSelectBBS:)])
    {
        [self.delegate bbsCollectionTVC:self didSelectBBS:item];
    }
}

#pragma mark - table view editing
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle != UITableViewCellEditingStyleDelete) return;
    
    LJBBSListItem * item = self.bbsCollectionData[indexPath.row];
    [LJBBSListItemDao removeBBSListItemFromDB:item];
    self.bbsCollectionData = [LJBBSListItemDao selectAllBBSListItemFromDB];
}

@end
