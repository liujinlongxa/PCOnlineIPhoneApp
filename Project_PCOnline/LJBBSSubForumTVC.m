//
//  LJBBSSubForumTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSubForumTVC.h"

@interface LJBBSSubForumTVC ()

@property (nonatomic, weak) UITableView * tableView;

@end

@implementation LJBBSSubForumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tablview
    [self setupTableView];
}

#pragma mark - 初始化UI
//初始化tableView
- (void)setupTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

@end
