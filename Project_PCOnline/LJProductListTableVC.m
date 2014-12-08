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

@interface LJProductListTableVC ()

@property (nonatomic, strong) NSMutableArray * productListData;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) LJProductSort curSortType;

//排序
@property (nonatomic, weak) LJProductSortView * sortView;
@property (nonatomic, weak) UIView * shadowView;
@property (nonatomic, weak) UIView * bigContentView;
@end

@implementation LJProductListTableVC

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
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

- (void)changeNavButton
{
    self.navigationItem.title = @"产品列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按热度" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClick:)];
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
        [self.bigContentView addSubview:_sortView];
    }
    return _sortView;
}

- (UIView *)shadowView
{
    if (!_shadowView) {
        //阴影
        UIView * shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.sortView.frame), kScrW, kScrH - CGRectGetHeight(self.sortView.frame))];
        NSLog(@"%@", NSStringFromCGRect(shadowView.frame));
        shadowView.backgroundColor = [UIColor blackColor];
        shadowView.hidden = YES;
        shadowView.alpha = 0;
        [self.bigContentView addSubview:shadowView];
        self.shadowView = shadowView;
        [shadowView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSortView:)]];
    }
    return _shadowView;
}

- (UIView *)bigContentView
{
    if (!_bigContentView) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarH + kStatusBarH, kScrW, kScrH)];
        view.opaque = YES;
        [self.view.window insertSubview:view belowSubview:self.navigationController.navigationBar];
        NSLog(@"%@", self.view.window.subviews);
        _bigContentView = view;
    }
    return _bigContentView;
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

#pragma mark - 加载数据
- (NSMutableArray *)productListData
{
    if (!_productListData) {
        _productListData = [NSMutableArray array];
        [self loadProductListData];
    }
    return _productListData;
}

- (void)loadProductListData
{
    NSString * productType = [NSString stringWithFormat:@"%d", self.brand.type.integerValue];
    NSString * urlStr = [NSString stringWithFormat:kProductListUrl, productType, self.curPage, self.curSortType, [self.brand.ID integerValue]];
    NSLog(@"prolist:%@", urlStr);
    NSLog(@"brand id:%@", self.brand.type);
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        
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
