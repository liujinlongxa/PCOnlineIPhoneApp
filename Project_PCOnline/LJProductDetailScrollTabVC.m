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


@interface LJProductDetailScrollTabVC ()<LJProductInformationTVCDelegate>

@end

@implementation LJProductDetailScrollTabVC


+ (instancetype)productDetailScrollTabVCWithControllers:(NSArray *)controllers andTitles:(NSArray *)titles
{
    LJProductDetailScrollTabVC * scrollTVC = [self scrollTabViewControllerWithController:controllers andTitles:titles];
    return scrollTVC;
}

- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    //返回button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(navBackBtnClick:)];
    //title
    self.navigationItem.title = @"产品详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName:NavBarTitleFont}];
    //right button
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:BlueTextColor} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"对比" style:UIBarButtonItemStylePlain target:self action:@selector(productCompare:)];
}

- (void)setProduct:(LJProduct *)product
{
    _product = product;
    [self.lj_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController * controller = (UIViewController *)obj;
        [controller setValue:product forKey:@"product"];
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
