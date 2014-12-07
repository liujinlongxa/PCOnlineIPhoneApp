//
//  LJBBSHotTopicTableVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSubForumListTVC.h"
#import "LJBBSSubForumCell.h"
#import "LJBBSSubForumTVC.h"

#define kSubForumListCellIdentifier @"SubForumListCell"

@interface LJBBSSubForumListTVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@end

@implementation LJBBSSubForumListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LightGrayBGColor;
    [self setupTableView];

}

#pragma mark - 初始化UI
- (void)setupTableView
{
    CGFloat padding = 10;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(padding, 2 * padding, kScrW - 2 * padding, kScrH - 2 * padding - kNavBarH * 2 - kStatusBarH) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LightGrayBGColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    //注册cell
    [self.tableView registerClass:[LJBBSSubForumCell class] forCellReuseIdentifier:kSubForumListCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LJBBSList * bbsList = [self.bbsList.children firstObject];
    return bbsList.children.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    LJBBSList * bbsList = [self.bbsList.children firstObject];
    CGFloat padding = 10;
    UILabel * headerLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScrW - 2 * padding, 30)];
    headerLab.text = bbsList.listItem.title;
    headerLab.backgroundColor = [UIColor lightGrayColor];
    headerLab.textColor = RGBColor(100, 100, 100);
    headerLab.textAlignment = NSTextAlignmentCenter;
    headerLab.layer.borderColor = [[UIColor grayColor] CGColor];
    headerLab.layer.borderWidth = 1;
    return headerLab;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    LJBBSList * bbsList = [self.bbsList.children firstObject];
    return bbsList.listItem.title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBBSSubForumCell * cell = [tableView dequeueReusableCellWithIdentifier:kSubForumListCellIdentifier];
    LJBBSList * bbsList = [self.bbsList.children firstObject];
    LJBBSList * subBBSList = bbsList.children[indexPath.row];
    cell.bbsItem = subBBSList.listItem;
    return cell;
}


#pragma mark - tableview 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(BBSSubForumListTVC:didSelecteBBSItem:)])
    {
        LJBBSList * bbsList = [self.bbsList.children firstObject];
        LJBBSList * subBBSList = bbsList.children[indexPath.row];
        [self.delegate BBSSubForumListTVC:self didSelecteBBSItem:subBBSList.listItem];
    }
}

@end
