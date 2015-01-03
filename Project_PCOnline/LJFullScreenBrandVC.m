//
//  LJFullScreenBrandVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJFullScreenBrandVC.h"
#import "LJBrandGroup.h"
#import "LJBrand.h"
#import "LJNetWorkingTool.h"
#import "LJCommonHeader.h"
#import "LJUrlHeader.h"
#import "LJFullScreenBrandCell.h"
#import "LJProductListTableVC.h"
#import "LJProductCompareManager.h"
#import "LJProductFilterListTVC.h"
#define kFullScreenBrandCellIdentifier @"FullScreenBrandCell"

@interface LJFullScreenBrandVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * brandData;
@property (nonatomic, weak) UITableView * tableView;
@end

@implementation LJFullScreenBrandVC

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
    self.view.backgroundColor = LightGrayBGColor;
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavbar];
}


#pragma 初始化UI
- (void)setupTableView
{
    CGFloat padding = 10;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(padding, padding * 2, kScrW - 2 * padding, kScrH - 2 * padding - kStatusBarH - kNavBarH) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = LightGrayBGColor;
    [self.tableView registerClass:[LJFullScreenBrandCell class] forCellReuseIdentifier:kFullScreenBrandCellIdentifier];
    //设置header view
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 40)];
    headerLabel.text = @"所有品牌";
    headerLabel.textColor = [UIColor grayColor];
    self.tableView.tableHeaderView = headerLabel;
}

- (void)setNavbar
{
    self.navigationItem.title = @"品牌列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClick:)];
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)filterButtonClick:(id)sender
{
    LJProductFilterListTVC * filterTVC = [[LJProductFilterListTVC alloc] initWithStyle:UITableViewStylePlain];
    filterTVC.subCategory = self.subCategory;
    [self.navigationController pushViewController:filterTVC animated:YES];
}

#pragma mark - 加载数据
- (NSMutableArray *)brandData
{
    if (!_brandData) {
        _brandData = [NSMutableArray array];
        [self loadBrandData];
    }
    return _brandData;
}

- (void)setSubCategory:(LJProductSubCategory *)subCategory
{
    _subCategory = subCategory;
    self.cotegoryTypeID = subCategory.sid;
}

- (void)loadBrandData
{
    NSString * urlStr = [NSString stringWithFormat:kBrandListUrl, self.cotegoryTypeID];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        //正在进行产品比较，需要加载推荐品牌
        if ([LJProductCompareManager manager].isComparing) {
            LJBrandGroup * recommendBrand = [LJBrandGroup brandGroupWithDict:dict[@"partition"][@"recommondBrands"]];
            recommendBrand.type = dict[@"type"];
            if (recommendBrand.brands.count > 0) {
                [self.brandData addObject:recommendBrand];
            }
        }
        
        //解析数据
        for (NSDictionary * brandDict in dict[@"partition"][@"totalBrands"][@"sections"]) {
            LJBrandGroup * group = [LJBrandGroup brandGroupWithDict:brandDict];
            group.type = dict[@"type"];
            [self.brandData addObject:group];
        }
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.brandData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LJBrandGroup * group = self.brandData[section];
    return ceil(group.brands.count / 2.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBrandGroup * group = self.brandData[indexPath.section];
    LJBrand * leftBrand = group.brands[indexPath.row * 2];
    LJBrand * rightBrand = nil;
    if (indexPath.row * 2 + 1 < group.brands.count) {
        rightBrand = group.brands[indexPath.row * 2 + 1];
    }
    
    LJFullScreenBrandCell * cell = [tableView dequeueReusableCellWithIdentifier:kFullScreenBrandCellIdentifier];
    cell.leftBrand = leftBrand;
    cell.rightBrand = rightBrand;
    [cell setSelectBrandBlock:^(LJBrand *brand) {
        LJProductListTableVC * productTVC = [[LJProductListTableVC alloc] init];
        productTVC.brand = brand;
        [self.navigationController pushViewController:productTVC animated:YES];
    }];
    return cell;
}

@end
