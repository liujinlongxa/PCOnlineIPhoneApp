//
//  LJProductListTableVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductListTableVC.h"
#import "LJProduct.h"
#import "LJNetWorking.h"
#import "LJProductListCell.h"
#import "LJProductSortView.h"
#import "LJCommonHeader.h"
//控制器
#import "LJProductDetailScrollTabVC.h"
#import "LJProductDetailWebVC.h"
#import "LJProductInformationTVC.h"

#import "LJProductSortView.h"

#define kProductListCellIdentifier @"ProductListCell"

typedef enum : NSUInteger {
    LJProductSortByHot = 1,
    LJProductSortByPriceHigh = 3,
    LJProductSortByPriceLow,
    LJProductSortByDate
} LJProductSort;

@interface LJProductListTableVC ()<UITableViewDelegate, UITableViewDataSource, LJProductSortViewDelegate>

@property (nonatomic, strong) NSMutableArray * productListData;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) LJProductSort curSortType;
@property (nonatomic, weak) UITableView * tableView;

//排序
@property (nonatomic, weak) LJProductSortView * sortView;
@property (nonatomic, weak) UIView * shadowView;
@property (nonatomic, weak) UIView * bigContentView;
@end

@implementation LJProductListTableVC

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
    self.curPage = 1;
    self.curSortType = LJProductSortByHot;
    [self changeNavButton];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJProductListCell" bundle:nil] forCellReuseIdentifier:kProductListCellIdentifier];
    self.tableView.rowHeight = 100;
    [self changeNavButton];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kStatusBarH - kNavBarH) style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)changeNavButton
{
    self.navigationItem.title = @"产品列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按热度" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClick:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //button
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    //title
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:NavBarTitleFont}];
}

#pragma mark - 返回Button
- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 排序
- (LJProductSortView *)sortView
{
    if (!_sortView) {
        CGFloat viewH = 140;
        _sortView = [LJProductSortView productScoTViewWithFrame:CGRectMake(0, -viewH, kScrW, viewH) andButTitles:@[@"按热度", @"按价高", @"按价低", @"按日期"]];
        _sortView.hidden = YES;
        _sortView.delegate = self;
        [self.view addSubview:_sortView];
    }
    return _sortView;
}

- (UIView *)shadowView
{
    if (!_shadowView) {
        //阴影
        UIView * shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarH + kNavBarH, kScrW, kScrH)];
        NSLog(@"%@", NSStringFromCGRect(shadowView.frame));
        shadowView.backgroundColor = [UIColor blackColor];
        shadowView.hidden = YES;
        shadowView.alpha = 0;
        [self.view insertSubview:shadowView belowSubview:self.sortView];
        self.shadowView = shadowView;
        [shadowView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSortView:)]];
    }
    return _shadowView;
}

- (void)showSortView
{
    CGRect sortViewF = self.sortView.frame;
    sortViewF.origin.y = 0;
    self.sortView.hidden = NO;
    self.shadowView.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.sortView.frame = sortViewF;
        self.shadowView.alpha = 0.5;
    } completion:^(BOOL finished) {
        isShowSortView = YES;
    }];
    
}

- (void)hideSortView
{
    CGRect sortViewF = self.sortView.frame;
    sortViewF.origin.y = -CGRectGetHeight(sortViewF);
    [UIView animateWithDuration:0.3f animations:^{
        self.sortView.frame = sortViewF;
        self.shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        self.sortView.hidden = YES;
        self.shadowView.hidden = YES;
        isShowSortView = NO;
    }];
}
static BOOL isShowSortView = NO;
- (void)filterButtonClick:(id)sender
{
    
    if (isShowSortView) {
        [self hideSortView];
    }
    else
    {
        [self showSortView];
    }
}

- (void)hideSortView:(id)sender
{
    [self hideSortView];
}

//排序代理方法
- (void)productSortView:(LJProductSortView *)view didSelectIndex:(NSInteger)index
{
    LJProductSort type;
    switch (index)
    {
        case 0:
            type = LJProductSortByHot;
            [self.navigationItem.rightBarButtonItem setTitle:@"按热度"];
            break;
        case 1:
            type = LJProductSortByPriceHigh;
            [self.navigationItem.rightBarButtonItem setTitle:@"按价高"];
            break;
        case 2:
            type = LJProductSortByPriceLow;
            [self.navigationItem.rightBarButtonItem setTitle:@"按价低"];
            break;
        case 3:
            type = LJProductSortByDate;
            [self.navigationItem.rightBarButtonItem setTitle:@"按日期"];
            break;
        default:
            break;
    }
    if (self.curSortType != type) {
        self.curSortType = type;
        [self loadProductListData];
    }
    [self hideSortView];
}

#pragma mark - 加载数据
- (NSMutableArray *)productListData
{
    if (!_productListData) {
        _productListData = [NSMutableArray array];
        [self loadProductListData];
    }
    return _productListData;
}

- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    if (self.brand == nil) {
        NSString * queryJsonEncodeStr = [self.subCategory.queryJson stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlStr = [NSString stringWithFormat:kProductFilterGetResultDetailUrl, self.subCategory.sid.integerValue, queryJsonEncodeStr, self.curPage, self.curSortType];
    }
    else
    {
        NSString * productType = [NSString stringWithFormat:@"%d", self.brand.type.integerValue];
        urlStr = [NSString stringWithFormat:kProductListUrl, productType, self.curPage, self.curSortType, [self.brand.ID integerValue]];
    }
    return urlStr;
}

- (void)loadProductListData
{
    [LJNetWorking GET:[self setupUrlStr] parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * productDict in dict[@"data"]) {
            LJProduct * product = [LJProduct productWithDict:productDict];
            product.type = self.brand.type;
            [arr addObject:product];
        }
        self.productListData = arr;
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.productListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductListCell * cell = [tableView dequeueReusableCellWithIdentifier:kProductListCellIdentifier];
    LJProduct * product = self.productListData[indexPath.row];
    cell.product = product;
    return cell;
}

#pragma mark - 选择某个产品
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProduct * product = self.productListData[indexPath.row];
    
    LJProductDetailWebVC * productSummaryVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypeSummary];
    LJProductDetailWebVC * productDetailVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypeDetail];
    LJProductDetailWebVC * productPriceVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypePrice];
    LJProductInformationTVC * productInformationTVC = [[LJProductInformationTVC alloc] init];
    LJProductDetailWebVC * productCommentVC = [[LJProductDetailWebVC alloc] initWithType:LJProductWebVCTypeComment];
    
    LJProductDetailScrollTabVC * productScrollTabVC = [LJProductDetailScrollTabVC productDetailScrollTabVCWithControllers:@[productSummaryVC, productDetailVC, productPriceVC, productInformationTVC, productCommentVC] andTitles:@[@"概述", @"详情", @"报价", @"资讯", @"点评"]];
    productScrollTabVC.product = product;
    //设置代理
    productInformationTVC.delegate = productScrollTabVC;
    [self.navigationController pushViewController:productScrollTabVC animated:YES];
    

}

@end
