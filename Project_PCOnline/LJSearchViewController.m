//
//  LJSearchViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSearchViewController.h"
#import "LJSearchBar.h"
#import "LJCommonHeader.h"
#import "LJSearchBarSelectButtonsView.h"



@interface LJSearchViewController ()<LJSearchBarDelegate>

@property (nonatomic, weak) LJSearchBar * searchBar;
@property (nonatomic, weak) LJSearchBarSelectButtonsView * btnView;
@property (nonatomic, assign) NSInteger curSelectIndex;

@property (nonatomic, strong) NSArray * titlesArr;
@end



@implementation LJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlesArr = @[@"资讯", @"论坛", @"帖子", @"产品"];
    self.view.backgroundColor = LightGrayBGColor;
    //search bar
    LJSearchBar * bar = [[LJSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andTitles:self.titlesArr];
    [self.view addSubview:bar];
    bar.delegate = self;
    self.searchBar = bar;
    
    //btn view
    LJSearchBarSelectButtonsView * btnView = [[LJSearchBarSelectButtonsView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andTitiles:self.titlesArr andActionBlock:^(NSInteger index) {
        [self.searchBar.selectButton setTitle:self.titlesArr[index] forState:UIControlStateNormal];
        self.curSelectIndex = index;
        self.btnView.hidden = YES;
    }];
    btnView.hidden = YES;
    [self.view addSubview:btnView];
    self.btnView = btnView;
}

- (void)viewWillLayoutSubviews
{
    CGFloat padding = 10;
    self.btnView.frame = CGRectMake(2 * padding + self.searchBar.frame.origin.x, padding + self.searchBar.frame.origin.y, CGRectGetWidth(self.searchBar.selectButton.frame), CGRectGetHeight(self.searchBar.selectButton.frame) * self.titlesArr.count);
}

#pragma mark - search bar 代理方法
- (void)searchBar:(LJSearchBar *)bar didClickSearchBtn:(UIButton *)button
{
    NSLog(@"%d", self.curSelectIndex);
}

- (void)searchBar:(LJSearchBar *)bar didClickSelectBtn:(UIButton *)button
{
    self.btnView.hidden = NO;
}

@end
