//
//  LJBBSListViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSListViewController.h"
#import "LJNetWorking.h"
#import "LJBBSListItem.h"
#import "LJBBSListCell.h"

@interface LJBBSListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * bbsListData;


@end

@implementation LJBBSListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LJBBSListCell" bundle:nil] forCellReuseIdentifier:@"BBSListCell"];
}

- (void)viewDidLayoutSubviews
{
    UIEdgeInsets edge = self.tableView.contentInset;
    edge.bottom = kNavBarH * 2 + kTabBarH + kStatusBarH;
    self.tableView.contentInset = edge;
}

#pragma mark - 加载数据
- (NSArray *)bbsListData
{
    if (!_bbsListData) {
        [self loadData];
    }
    return _bbsListData;
}

- (void)loadData
{
    NSString * urlStr = kBBSListUrl;
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * bbsListDict in dict[@"children"]) {
            LJBBSList * list = [LJBBSList bbsListWithDict:bbsListDict];
            [arr addObject:list];
        }
        _bbsListData = [arr copy];
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bbsListData.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBBSList * list = self.bbsListData[indexPath.row];
    LJBBSListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BBSListCell"];
    cell.bbsList = list;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - 选中一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(BBSListViewController:didSelectedBBS:)]) {
        LJBBSList * list = self.bbsListData[indexPath.row];
        [self.delegate BBSListViewController:self didSelectedBBS:list];
    }
}


@end
