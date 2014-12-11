//
//  LJMoreNewsSearchResultTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJMoreNewsSearchResultTVC.h"
#import "LJNewsSearchResltCell.h"
#import "LJNewsDetailController.h"
#import "LJNewsSearchResultItem.h"

#define kNewsSearchResultCellIdentifier @"NewsSearchResltCell"

@interface LJMoreNewsSearchResultTVC ()

@end

@implementation LJMoreNewsSearchResultTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LJNewsSearchResltCell" bundle:nil] forCellReuseIdentifier:kNewsSearchResultCellIdentifier];
    self.tableView.rowHeight = 80;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    LJNewsSearchResultItem * item = [self.searchResultData firstObject];
    self.navigationItem.title = item.type;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:NavBarTitleFont}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJNewsSearchResultItem * item = self.searchResultData[indexPath.row];
    LJNewsSearchResltCell * cell = [tableView dequeueReusableCellWithIdentifier:kNewsSearchResultCellIdentifier];
    cell.newsItem = item;
    return cell;
}

#pragma mark - table view 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJNewsSearchResultItem * item = self.searchResultData[indexPath.row];
    LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
    detailVC.ID = item.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
