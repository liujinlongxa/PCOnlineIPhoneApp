//
//  LJProductViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductViewController.h"
#import "LJProductSubCategory.h"
#import "LJProductCategory.h"
#import "LJNetWorking.h"
#import "LJProductCategoryCell.h"

#define kCategoryDataFileName @"PCOnlineProductDatas4inch.json"
#define kCategoryCellIdentifier @"CategoryCell"

@interface LJProductViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * categoryData;
@property (nonatomic, strong) NSMutableDictionary * categoryNameData;

@end

@implementation LJProductViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title  = @"找产品";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化tableview
    [self setupTableview];
    
    //加载数据
    [self loadCategoryNameData];
    
}

#pragma mark - 初始化控件
- (void)setupTableview
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LJProductCategoryCell" bundle:nil] forCellReuseIdentifier:kCategoryCellIdentifier];
    UIEdgeInsets edge = self.tableView.contentInset;
    edge.bottom = kTabBarH + kNavBarH + kStatusBarH;
    self.tableView.contentInset = edge;
    
}

#pragma mark - 加载数据
- (NSMutableDictionary *)categoryNameData
{
    if (!_categoryNameData) {
        _categoryNameData = [NSMutableDictionary dictionary];
    }
    return _categoryNameData;
}

- (void)loadCategoryNameData
{
    [LJNetWorking GET:kProductCategoryNameUrl parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        self.categoryNameData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self loadCategoryData];
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

- (NSMutableArray *)categoryData
{
    if (!_categoryData) {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (void)loadCategoryData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:kCategoryDataFileName ofType:nil];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary * categoryDict in dict[@"homeDirectory"]) {
        LJProductCategory * category = [LJProductCategory productCategoryWithDict:categoryDict];
        category.subCategoryName = self.categoryNameData[category.title];
        [self.categoryData addObject:category];
    }
}


#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:kCategoryCellIdentifier];
    LJProductCategory * category = self.categoryData[indexPath.row];
    cell.category = category;
    return cell;
}
@end
