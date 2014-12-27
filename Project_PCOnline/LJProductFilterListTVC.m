//
//  LJProductFilterListTVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductFilterListTVC.h"
#import "LJProductFilterItemGroup.h"
#import "LJProductFilterGroupCell.h"
#import "LJUrlHeader.h"
#import "LJNetWorkingTool.h"
#import "LJCommonHeader.h"
#import "LJProductFilterSelectItemListTVC.h"
#import "LJQueryJson.h"
#import "LJProductListTableVC.h"
#import "LJNetWorkingTool.h"
#import "MBProgressHUD.h"

#define kProductFilterGroupCellIdentifier @"ProductFilterGroupCell"
@interface LJProductFilterListTVC ()

@property (nonatomic, strong) NSMutableArray * filterItemGroupData;
@property (nonatomic, strong) UILabel * tableViewHeader;
@property (nonatomic, assign) NSInteger searchResultCount;
@property (nonatomic, assign, getter=isHaveSelectFilterItem) BOOL haveSelectFilterItem;
@end

@implementation LJProductFilterListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[LJProductFilterGroupCell class] forCellReuseIdentifier:kProductFilterGroupCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavBar];
    [self loadSerchResultCount];
}

- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backNavBtnClick:)];
    self.navigationItem.title = @"选机";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(searchProduct:)];
}

- (void)backNavBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isHaveSelectFilterItem
{
    if(self.subCategory.filterGroups == nil) return NO;
    for (LJProductFilterItemGroup * group in self.subCategory.filterGroups) {
        if(group.selectCount > 0) return YES;
    }
    return NO;
}

#pragma mark - 查询产品
- (void)searchProduct:(id)sender
{
    if (!self.isHaveSelectFilterItem) {
        return;
    }
    
    LJProductListTableVC * productListTVC = [[LJProductListTableVC alloc] init];
    productListTVC.subCategory = self.subCategory;
    [self.navigationController pushViewController:productListTVC animated:YES];
}

#pragma mark - 加载数据

- (NSMutableArray *)filterItemGroupData
{
    if (!_filterItemGroupData) {
        _filterItemGroupData = [NSMutableArray array];
        [self loadFilterItemGroupData];
    }
    return _filterItemGroupData;
}

- (void)loadFilterItemGroupData
{
    NSString * urlStr = [NSString stringWithFormat:kProductFilterItemListUrl, self.subCategory.sid.integerValue];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * groupDict in dict[@"criterion"]) {
            LJProductFilterItemGroup * group = [LJProductFilterItemGroup productFilterItemGroupWithDict:groupDict];
            [arr addObject:group];
        }
        self.filterItemGroupData = arr;
        self.subCategory.filterGroups = arr;
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - tableview 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filterItemGroupData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductFilterGroupCell * cell = [tableView dequeueReusableCellWithIdentifier:kProductFilterGroupCellIdentifier];
    LJProductFilterItemGroup * group = self.filterItemGroupData[indexPath.row];
    cell.group = group;
    return cell;
}

#pragma mark - tablview 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScrW, 60)];
    lab.backgroundColor = [UIColor lightGrayColor];
    lab.textColor = [UIColor darkGrayColor];
    if (!self.isHaveSelectFilterItem) {
        lab.text = @"  请选择筛选条件";
    }
    else
    {
        lab.text = [NSString stringWithFormat:@"  共有%d个结果符合条件", self.searchResultCount];
    }
    self.tableViewHeader = lab;
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    return 40;
}

#pragma mark - 选中一行 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductFilterItemGroup * group = self.filterItemGroupData[indexPath.row];
    LJProductFilterSelectItemListTVC * itemListTVC = [[LJProductFilterSelectItemListTVC alloc] initWithStyle:UITableViewStylePlain];
    itemListTVC.group = group;
    [self.navigationController pushViewController:itemListTVC animated:YES];
}

#pragma mark - 加载结果个数数据
- (void)loadSerchResultCount
{
    if(self.subCategory.filterGroups == nil) return;
    NSString * queryJsonEncodeStr = [self.subCategory.queryJson stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * urlStr = [NSString stringWithFormat:kProductFilterGetResultCountUrl, self.subCategory.sid.integerValue, queryJsonEncodeStr];
    
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSInteger count = [dict[@"total"] integerValue];
        self.searchResultCount = count;
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
    }];
}

@end
