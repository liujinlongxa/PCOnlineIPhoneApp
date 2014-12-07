//
//  LJBBSListDetailController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSListDetailController.h"
#import "LJBBSTopicDetailWebVC.h"
#import "LJBBSSubForumTVC.h"

@interface LJBBSListDetailController ()

@end

@implementation LJBBSListDetailController

+ (instancetype)BBSListDetailControllerWithControllers:(NSArray *)controllers andTitles:(NSArray *)titles
{
    LJBBSListDetailController * controller = [LJBBSListDetailController scrollTabViewControllerWithController:controllers andTitles:titles];
    controller.hidesBottomBarWhenPushed = YES;
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavBar
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupNavBar];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBbsList:(LJBBSList *)bbsList
{
    _bbsList = bbsList;
    self.navigationItem.title = bbsList.listItem.title;
    [self.lj_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setBbsList:self.bbsList];
    }];
}

#pragma mark - HotTopicTableVC代理方法，选中某个帖子
- (void)BBSTopicTableVC:(LJBBSHotTopicTableVC *)vc didSelectTopic:(LJBaseTopic *)topic inBBSList:(LJBBSList *)bbsList
{
    LJBBSTopicDetailWebVC * topicWebVC = [[LJBBSTopicDetailWebVC alloc] init];
    topicWebVC.topic = topic;
    topicWebVC.bbsItem = bbsList.listItem;
    [self.navigationController pushViewController:topicWebVC animated:YES];
}

#pragma mark - 选中子板块代理方法
- (void)BBSSubForumListTVC:(LJBBSSubForumListTVC *)controller didSelecteBBSItem:(LJBBSListItem *)bbsItem
{
    LJBBSSubForumTVC * subForumTVC = [[LJBBSSubForumTVC alloc] init];
    subForumTVC.bbsItem = bbsItem;
    [self.navigationController pushViewController:subForumTVC animated:YES];
}

@end
