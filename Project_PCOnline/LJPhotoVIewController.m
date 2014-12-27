//
//  LJPhotoVIewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPhotoVIewController.h"
#import "LJPhoto.h"
#import "LJPhotoCell.h"
#import "LJPhotoGroup.h"
#import "LJNetWorking.h"
#import "LJDetailPhotoViewController.h"
#import "MJRefresh/MJRefresh.h"

#define kPhotoIdentifier @"kPhotoIdentifier"
#define kPhotoUrlID @"41"
#define kGroupPerPage 20

@interface LJPhotoVIewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * photoGroupData;

/**
 *  当前分页
 */
@property (nonatomic, assign) NSInteger curPage;

/**
 *  当前是否已经刷新
 */
@property (nonatomic, assign, getter=isRefresh) BOOL refresh;

@end

@implementation LJPhotoVIewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title  = @"图赏";
    self.refresh = NO;
    //初始化tableView
    [self setupTableview];
}

#pragma mark - 初始化
- (void)setupTableview
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LJPhotoCell" bundle:nil] forCellReuseIdentifier:kPhotoIdentifier];
    self.tableView.rowHeight = 180;
    UIEdgeInsets edge = self.tableView.contentInset;
    edge.bottom = kTabBarH + kNavBarH + kStatusBarH;
    self.tableView.contentInset = edge;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    //添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        self.curPage = 1;
        [self loadPhotoGroupData];
    }];
    //添加上拉加载更多
    [self.tableView addFooterWithCallback:^{
        self.curPage++;
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //开始刷新
    if (!self.isRefresh)
    {
        [self.tableView headerBeginRefreshing];
        self.refresh = YES;
    }
}

#pragma mark - 加载数据
- (NSMutableArray *)photoGroupData
{
    if (!_photoGroupData) {
        _photoGroupData = [NSMutableArray array];
        [self loadPhotoGroupData];
    }
    return _photoGroupData;
}

- (void)loadPhotoGroupData
{
    NSString * urlStr = [NSString stringWithFormat:kPhotoUrl, kPhotoUrlID];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        for (NSDictionary * groupDict in dict[@"groups"]) {
            LJPhotoGroup * group = [LJPhotoGroup photoGroupWithDict:groupDict];
            [self.photoGroupData addObject:group];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MIN(self.photoGroupData.count, self.curPage * kGroupPerPage);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJPhotoCell * cell = [tableView dequeueReusableCellWithIdentifier:kPhotoIdentifier];
    LJPhotoGroup * group = self.photoGroupData[indexPath.row];
    cell.photoGroup = group;
    return cell;
}

#pragma mark - 选中一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];//取消选中
    LJPhotoGroup * group = self.photoGroupData[indexPath.row];
    LJDetailPhotoViewController * detailPhotoVC = [[LJDetailPhotoViewController alloc] init];
    detailPhotoVC.group = group;
    [self.navigationController pushViewController:detailPhotoVC animated:YES];
}


@end
