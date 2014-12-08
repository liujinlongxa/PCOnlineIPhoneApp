//
//  LJProductCompareVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductCompareVC.h"
#import "LJProductCompareItemView.h"
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "LJProductCompareManager.h"
#import "LJFullScreenBrandVC.h"

@interface LJProductCompareVC ()<LJProductCompareItemViewDelegate>

@property (nonatomic, weak) LJProductCompareItemView * leftItemView;
@property (nonatomic, weak) LJProductCompareItemView * rightItemView;
@property (nonatomic, weak) UIWebView * compareResult;

@end

@implementation LJProductCompareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat middleW = 40;
    CGFloat viewW = (kScrW - middleW) / 2;
    CGFloat viewH = 150;
    CGFloat padding = 10;
    
    LJProductCompareItemView * leftView = [LJProductCompareItemView productCompareItemViewWithFrame:CGRectMake(0, 0, viewW, viewH) andProduct:[LJProductCompareManager manager].leftProduct];
    leftView.delegate = self;
    [self.view addSubview:leftView];
    self.leftItemView = leftView;
    
    LJProductCompareItemView * rightView = [LJProductCompareItemView productCompareItemViewWithFrame:CGRectMake(viewW + middleW, 0, viewW, viewH) andProduct:[LJProductCompareManager manager].rightProduct];
    rightView.delegate = self;
    [self.view addSubview:rightView];
    self.rightItemView = rightView;
    
    UIImageView * vsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pconline_product_comparevs_bg"]];
    vsImage.center = CGPointMake(kScrW / 2, viewH / 2);
    [self.view addSubview:vsImage];
    
    UIWebView * resultWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, viewH + padding, kScrW, kScrH - viewH - kStatusBarH - kNavBarH)];
    [self.view addSubview:resultWebView];
    self.compareResult = resultWebView;
}

//- (void)setLeftProduct:(LJProduct *)leftProduct
//{
//    _leftProduct = leftProduct;
//    self.leftItemView.product = leftProduct;
//    [[LJProductCompareManager manager] addCompareProduct:leftProduct atPosition:LJProductComparePositionLeft];
//}

//- (void)setRightProduct:(LJProduct *)rightProduct
//{
//    _rightProduct = rightProduct;
//    self.rightItemView.product = rightProduct;
//    [[LJProductCompareManager manager] addCompareProduct:rightProduct atPosition:LJProductComparePositionRight];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadResultWeb];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //button
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeCompare:)];
    //title
    self.navigationItem.title = @"对比详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:NavBarTitleFont}];
}

//关闭产品对比
- (void)closeCompare:(id)sender
{
    [[LJProductCompareManager manager] closeCompare];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSURLRequest *)setupURLReq
{
    NSString * urlStr = [[LJProductCompareManager manager] compareUrlStr];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    return req;
}

- (void)loadResultWeb
{
    [self.compareResult loadRequest:[self setupURLReq]];
}

#pragma mark - item view代理方法，处理添加和删除
- (void)productCompareItemViewAddProductItem:(LJProductCompareItemView *)view
{
    LJFullScreenBrandVC * brandVC = [[LJFullScreenBrandVC alloc] init];
    brandVC.cotegoryTypeID = [LJProductCompareManager manager].productTypeIDStr;
    [self.navigationController pushViewController:brandVC animated:YES];
}

- (void)productCompareItemViewCloseProductItem:(LJProductCompareItemView *)view
{
    if (view == self.leftItemView) {
        [[LJProductCompareManager manager] removeCompareProductFromPositon:LJProductComparePositionLeft];
    }
    else
    {
        [[LJProductCompareManager manager] removeCompareProductFromPositon:LJProductComparePositionRight];
    }
    [self loadResultWeb];
}

@end
