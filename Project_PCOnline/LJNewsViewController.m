//
//  LJNewsViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsViewController.h"
#import "UIImage+MyImage.h"
#import "LJSubjectView.h"

@interface LJNewsViewController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) UITableView * tableView;

@end

@implementation LJNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithNameNoRender:@"pconline_top_title"]];
    
    //添加栏目条
    LJSubjectView * subjectView = [LJSubjectView subjectView];
    NSLog(@"%@", NSStringFromCGRect(subjectView.frame));
    [self.view addSubview:subjectView];
    
    //添加tableview
    CGFloat tableX = 0;
    CGFloat tableY = CGRectGetMaxY(subjectView.frame);
    CGFloat tableH = kScrH - 2 * kNavBarH - kStatusBarH - kTabBarH;
    CGFloat tableW = kScrW;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = tableView;
}




@end
