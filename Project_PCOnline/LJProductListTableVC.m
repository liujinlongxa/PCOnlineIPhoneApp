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
@end

@implementation LJProductListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage = 1;
    self.curSortType = LJProductSortByHot;
    [self changeNavButton];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJProductListCell" bundle:nil] forCellReuseIdentifier:kProductListCellIdentifier];
    [self changeNavButton];
}

- (void)changeNavButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按热度" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClick:)];
}

#pragma mark - 返回Button
- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 排序
- (void)filterButtonClick:(id)sender
{
    
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
    NSString * productType = [[LJCommonData shareCommonData] loadObjcForKey:kProductTypeKey];
    NSString * urlStr = [NSString stringWithFormat:kProductListUrl, productType, self.curPage, self.curSortType, [self.brand.ID integerValue]];
    NSLog(@"%@", urlStr);
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * productDict in dict[@"data"]) {
            LJProduct * product = [LJProduct productWithDict:productDict];
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

@end
