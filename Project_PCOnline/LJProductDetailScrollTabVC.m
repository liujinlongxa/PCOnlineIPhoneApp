//
//  LJProductDetailScrollTabVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductDetailScrollTabVC.h"
#import "LJNewsDetailController.h"
#import "UIImage+MyImage.h"
#import "LJProductCompareVC.h"
#import "LJProductCompareManager.h"
#import "LJProductSearchResultItem.h"
#import "LJBBSListItem.h"
#import "LJBBSSubForumTVC.h"
#import "LJCommonData.h"
//标准子控制器

#import "LJFullScreenWebViewerVC.h"

@interface LJProductDetailScrollTabVC ()<LJProductInformationTVCDelegate, LJProductDetailWebVCCDelegate>

@end

@implementation LJProductDetailScrollTabVC

+ (instancetype)productDetailScrollTabVCWithDefautControllers
{
    LJProductDetailWebVC * productSummaryVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypeSummary];
    LJProductDetailWebVC * productDetailVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypeDetail];
    LJProductDetailWebVC * productPriceVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypePrice];
    LJProductInformationTVC * productInformationTVC = [[LJProductInformationTVC alloc] init];
    LJProductDetailWebVC * productCommentVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypeComment];
    
    LJProductDetailScrollTabVC * scrollTVC = [[super class] scrollTabViewControllerWithController:@[productSummaryVC, productDetailVC, productPriceVC, productInformationTVC, productCommentVC] andTitles:@[@"概述", @"详情", @"报价", @"资讯", @"点评"]];
    productInformationTVC.delegate = scrollTVC;
    productSummaryVC.delegate = scrollTVC;
    productDetailVC.delegate = scrollTVC;
    productCommentVC.delegate = scrollTVC;
    productPriceVC.delegate = scrollTVC;
    return scrollTVC;
}

+ (instancetype)productDetailScrollTabVCWithControllers:(NSArray *)controllers andTitles:(NSArray *)titles
{
    LJProductDetailScrollTabVC * scrollTVC = [self scrollTabViewControllerWithController:controllers andTitles:titles];
    return scrollTVC;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    //返回button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(navBackBtnClick:)];
    //title
    self.navigationItem.title = @"产品详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName:NavBarTitleFont}];
    //right button
    if (self.product != nil) {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:BlueTextColor} forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"对比" style:UIBarButtonItemStylePlain target:self action:@selector(productCompare:)];
    }
}

- (void)setProduct:(LJProduct *)product
{
    _product = product;
    [self.lj_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController * controller = (UIViewController *)obj;
        [controller setValue:product forKey:@"product"];
    }];
}

- (void)setItem:(LJProductSearchResultItem *)item
{
    _item = item;
    [self.lj_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setProductID:item.ID];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 选择资讯代理方法
- (void)productInformationTVC:(LJProductInformationTVC *)infoTVC didSelectInfo:(LJProductInformation *)info
{
    LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
    detailVC.ID = info.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 点击webview的代理方法
- (void)productDetailWebVC:(LJProductDetailWebVC *)webVC didClickBuyProductLink:(NSString *)urlStr
{
    LJFullScreenWebViewerVC * fuWebVC = [[LJFullScreenWebViewerVC alloc] init];
    fuWebVC.urlStr = urlStr;
    
    [self presentViewController:fuWebVC animated:YES completion:nil];
}

- (void)productDetailWebVC:(LJProductDetailWebVC *)webVC didClickForumLink:(NSString *)urlStr
{
    NSRange urlStrRange = [urlStr rangeOfString:LJWebViewClickToForum];
    assert(urlStrRange.location != NSNotFound);
    NSString * ID = [urlStr substringFromIndex:urlStrRange.location + urlStrRange.length];
    assert(ID != nil);
    
    
    LJBBSSubForumTVC * forumTVC = [[LJBBSSubForumTVC alloc] init];
    LJBBSListItem * item = [[LJCommonData shareCommonData] findBBSItemByID:@(ID.integerValue) inBBSLists:nil];
    forumTVC.bbsItem = item;
    [self.navigationController pushViewController:forumTVC animated:YES];
}

- (void)productDetailWebVC:(LJProductDetailWebVC *)webVC didClickProductPhotoLink:(NSString *)urlStr
{
    
}

#pragma mark - 导航栏按钮点击
- (void)navBackBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)productCompare:(id)sender
{
    LJProductCompareVC * compareVC = [[LJProductCompareVC alloc] init];
    if ([LJProductCompareManager manager].isComparing) {
        [[LJProductCompareManager manager] addCompareProduct:self.product];
    }
    else
    {
        [[LJProductCompareManager manager] addCompareProduct:self.product atPosition:LJProductComparePositionLeft];
    }
    [LJProductCompareManager manager].productTypeIDStr = [NSString stringWithFormat:@"%d", self.product.type.integerValue];
    [self.navigationController pushViewController:compareVC animated:YES];
}

@end
