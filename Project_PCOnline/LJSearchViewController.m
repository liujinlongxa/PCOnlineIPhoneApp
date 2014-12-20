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
#import "LJBBSListItem.h"
#import "LJTopicSearchResultItem.h"
#import "LJNewsSearchResultItem.h"

//控制器
#import "LJProductSearchResultVC.h"
#import "LJTopicSearchResultVC.h"
#import "LJBBSSearchResultVC.h"
#import "LJNewsSearchResultVC.h"
#import "LJBBSSubForumTVC.h"
#import "LJProductDetailScrollTabVC.h"
#import "LJBBSTopicDetailWebVC.h"
#import "LJNewsDetailController.h"
#import "LJMoreNewsSearchResultTVC.h"

@interface LJSearchViewController ()<LJSearchBarDelegate, LJNewsSearchResultVCDelegate>

@property (nonatomic, weak) LJSearchBar * searchBar;
@property (nonatomic, weak) LJSearchBarSelectButtonsView * btnView;
@property (nonatomic, assign) NSInteger curSelectIndex;
@property (nonatomic, strong) NSArray * titlesArr;

//显示结果区域
@property (nonatomic, weak) UIView * showResultView;

//当前控制器
@property (nonatomic, strong) UIViewController * curShowController;

@end



@implementation LJSearchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlesArr = @[@"资讯", @"论坛", @"帖子", @"产品"];
    self.view.backgroundColor = LightGrayBGColor;
    
    [self setupSearchBar];
    [self setupShowResultView];
    [self setupBtnView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"搜索";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:NavBarTitleFont}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - init UI
- (void)setupSearchBar
{
    //search bar
    LJSearchBar * bar = [[LJSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andTitles:self.titlesArr];
    [self.view addSubview:bar];
    bar.delegate = self;
    self.searchBar = bar;
    
//    //添加手势，隐藏键盘
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)]];
}

//- (void)hideKeyboard:(UITapGestureRecognizer *)tap
//{
//    
//    else
//    {
//
//    }
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.searchBar.textField.isFirstResponder)
    {
        [self.searchBar.textField resignFirstResponder];
    }
    else
    {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)setupBtnView //下拉菜单
{
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

- (void)setupShowResultView
{
    UIView * view = [[UIView alloc] init];
    [self.view addSubview:view];
    self.showResultView  = view;
}

- (void)viewWillLayoutSubviews
{
    CGFloat padding = 10;
    self.btnView.frame = CGRectMake(2 * padding + self.searchBar.frame.origin.x, padding + self.searchBar.frame.origin.y, CGRectGetWidth(self.searchBar.selectButton.frame), CGRectGetHeight(self.searchBar.selectButton.frame) * self.titlesArr.count);
    
    self.showResultView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), kScrW, kScrH - CGRectGetHeight(self.searchBar.frame));
}

#pragma mark - search bar 代理方法
- (void)searchBar:(LJSearchBar *)bar didClickSearchBtn:(UIButton *)button
{
    switch (self.curSelectIndex) {
        case 0:
        {
            LJNewsSearchResultVC * resultVC = [[LJNewsSearchResultVC alloc] init];
            [[self.showResultView.subviews firstObject] removeFromSuperview];
            [self.showResultView addSubview:resultVC.view];
            self.curShowController = resultVC;
            resultVC.keyWord = self.searchBar.textField.text;
            resultVC.delegate = self;
            break;
        }
        case 1:
        {
            LJBBSSearchResultVC * resultVC = [[LJBBSSearchResultVC alloc] initWithSelectActionBlock:^(LJBBSListItem *item) {
                LJBBSSubForumTVC * subFormTVC = [[LJBBSSubForumTVC alloc] init];
                subFormTVC.bbsItem = item;
                [self.navigationController pushViewController:subFormTVC animated:YES];
            }];
            [[self.showResultView.subviews firstObject] removeFromSuperview];
            [self.showResultView addSubview:resultVC.view];
            self.curShowController = resultVC;
            resultVC.keyWord = self.searchBar.textField.text;
            break;
        }
        case 2:
        {
            LJTopicSearchResultVC * resultVC = [[LJTopicSearchResultVC alloc] initWithSelectActionBlock:^(LJTopicSearchResultItem *item) {
                LJBBSTopicDetailWebVC * topicWebVC = [[LJBBSTopicDetailWebVC alloc] init];
                topicWebVC.searchResutItem = item;
                [self.navigationController pushViewController:topicWebVC animated:YES];
            }];
            [[self.showResultView.subviews firstObject] removeFromSuperview];
            [self.showResultView addSubview:resultVC.view];
            self.curShowController = resultVC;
            resultVC.keyWord = self.searchBar.textField.text;
            break;
        }
        case 3:
        {
            LJProductSearchResultVC * resultVC = [[LJProductSearchResultVC alloc] initWithSelectActionBlock:^(LJProductSearchResultItem *item) {
                LJProductDetailScrollTabVC * productDetailSTVC = [LJProductDetailScrollTabVC productDetailScrollTabVCWithDefautControllers];
                productDetailSTVC.item = item;
                [self.navigationController pushViewController:productDetailSTVC animated:YES];
            }];
            [[self.showResultView.subviews firstObject] removeFromSuperview];
            [self.showResultView addSubview:resultVC.view];
            self.curShowController = resultVC;
            resultVC.keyWord = self.searchBar.textField.text;
            break;
        }
        default:
            break;
    }
}

- (void)searchBar:(LJSearchBar *)bar didClickSelectBtn:(UIButton *)button
{
    self.btnView.hidden = NO;
}

#pragma mark - newsSearch 代理方法
- (void)newsSearchResultVC:(LJNewsSearchResultVC *)controller didSelectWithObject:(id)obj
{
    if ([obj isKindOfClass:[NSArray class]])
    {
        LJMoreNewsSearchResultTVC * moreResultTVC = [[LJMoreNewsSearchResultTVC alloc] init];
        moreResultTVC.searchResultData = obj;
        [self.navigationController pushViewController:moreResultTVC animated:YES];
    }
    else
    {
        LJNewsSearchResultItem * item = (LJNewsSearchResultItem *)obj;
        LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
        detailVC.ID = item.ID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

@end
