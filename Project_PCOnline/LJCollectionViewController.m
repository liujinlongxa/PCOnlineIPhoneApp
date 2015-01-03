//
//  LJCollectionViewController.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJCollectionViewController.h"
#import "PPRevealSideviewController/PPRevealSideViewController.h"
#import "LJCommonHeader.h"

//vc
#import "LJNewsDetailController.h"
#import "LJBBSTopicDetailWebVC.h"
#import "LJBBSSubForumTVC.h"

@interface LJCollectionViewController ()

@end

@implementation LJCollectionViewController

+ (instancetype)collectionViewControllerWithControllers:(NSArray *)controllers andTitles:(NSArray *)titles
{
    LJCollectionViewController * vc = [super scrollTabViewControllerWithController:controllers andTitles:titles];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //setting nav bar
    self.navigationController.navigationBarHidden = NO;
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:NavBarTitleFont} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.title = @"个人收藏";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //status bar
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //设置侧滑栏隐藏
    [self.revealSideViewController changeOffset:0 forDirection:PPRevealSideDirectionRight animated:YES];
    self.revealSideViewController.options &= !PPRevealSideOptionsShowShadows;
}

/**
 *  点击导航栏返回按钮
 */
- (void)backButtonClick:(__unused id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 代理方法

/**
 *  点击收藏的文章代理方法
 */
- (void)articleCollectionTVC:(LJArticleCollectionTVC *)articleCollTVC didSelectArticle:(LJArticleDaoModel *)article
{
    LJNewsDetailController * newsVC = [[LJNewsDetailController alloc] init];
    newsVC.ID = [NSString stringWithFormat:@"%d", article.articleId.integerValue];
    [self.navigationController pushViewController:newsVC animated:YES];
}

/**
 *  点击收藏的帖子代理方法
 */
- (void)topicCollectionTVC:(LJTopicCollectionTVC *)topicCollTVC didSelectTopic:(LJTopicDaoModel *)topic
{
    LJBBSTopicDetailWebVC * topicDetailTVC = [[LJBBSTopicDetailWebVC alloc] initBBSTopicDetailWebVCWithBaseUrlStr:topic.baseUrl andTopicId:topic.topicId];
    [self.navigationController pushViewController:topicDetailTVC animated:YES];
}

/**
 *  点击收藏的论坛代理方法
 */
- (void)bbsCollectionTVC:(LJBBSCollectionTVC *)bbsCollTVC didSelectBBS:(LJBBSListItem *)bbsItem
{
    LJBBSSubForumTVC * subForumTVC = [[LJBBSSubForumTVC alloc] init];
    subForumTVC.bbsItem = bbsItem;
    [self.navigationController pushViewController:subForumTVC animated:YES];
}

#pragma mark - 编辑
/**
 *  点击编辑/完成按钮，进入编辑/正常状态
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    //每个子控制器都进入编辑状态
    [self.lj_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSParameterAssert([obj isKindOfClass:[UIViewController class]]);
        [obj setEditing:editing animated:YES];
    }];
}

@end
