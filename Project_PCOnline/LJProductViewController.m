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
//控制器
#import "LJSubProductCategoryTableVC.h"
#import "LJBrandTableVC.h"

#define kCategoryDataFileName @"PCOnlineProductDatas4inch.json"
#define kCategoryCellIdentifier @"CategoryCell"

#define kShowViewW 220 //showview的宽度
#define kTableViewOffset 90 //tableview偏移距离

@interface LJProductViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * categoryData;
@property (nonatomic, strong) NSMutableDictionary * categoryNameData;

@property (nonatomic, weak) UIView * showView;//显示品牌或子分类的区域

@property (nonatomic, assign, getter=isShow) BOOL show;

@property (nonatomic, strong) UIViewController * curSlideVC;


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
    
    //初始化showview
    [self setupShowView];
    
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
    self.tableView.rowHeight = 80;
    
}

- (void)setupShowView
{
    CGFloat viewW = kShowViewW;
    CGFloat viewH = CGRectGetHeight(self.view.frame);
    CGFloat viewX = kScrW;
    CGFloat viewY = 0;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    [self.view addSubview:view];
    self.showView = view;
    self.showView.backgroundColor = [UIColor blueColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.showView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.showView.layer.borderWidth = 1;
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
        NSLog(@"%@", error);
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
    cell.subTitleLab.alpha = self.isShow ? 0 : 1;
    return cell;
}

#pragma mark - 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //加载数据
    [self loadDataInSlideAtIndexPath:indexPath];
    
    //判断是否已经显示
    if(self.isShow) return;
    
    //设置动画
    [self setupAnimation];
}

- (void)loadDataInSlideAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductCategory * category = self.categoryData[indexPath.row];
    if (category.childs.count == 1) {//slide中显示具体品牌
        LJBrandTableVC * brandVC = [[LJBrandTableVC alloc] initWithStyle:UITableViewStyleGrouped];
        brandVC.subCategory = category.childs[0];
        self.curSlideVC = brandVC;
        [self.showView addSubview:brandVC.view];
    }
    else //显示子分类
    {
        LJSubProductCategoryTableVC * subCategoryVC = [[LJSubProductCategoryTableVC alloc] initWithStyle:UITableViewStylePlain];
        subCategoryVC.subCategories = category.childs;
        self.curSlideVC = subCategoryVC;
        [self.showView addSubview:subCategoryVC.view];
    }
}

//设置动画
- (void)setupAnimation
{
    //动画
    CGRect showViewF = self.showView.frame;
    showViewF.origin.x = kScrW - CGRectGetWidth(showViewF);
    CGRect tableViewF = self.tableView.frame;
    tableViewF.origin.x = -kTableViewOffset;
    NSArray * cells = self.tableView.visibleCells;
    [UIView animateWithDuration:1.0f animations:^{
        self.showView.frame = showViewF;
        self.tableView.frame = tableViewF;
        [cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [[obj subTitleLab] setAlpha:0];
        }];
    } completion:^(BOOL finished) {
        //改变导航栏按钮
        [self changeNavButton];
        self.show = YES;
    }];
}

- (void)changeNavButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClick:)];
}

- (void)backButtonClick:(id)sender
{
    //动画
    CGRect showViewF = self.showView.frame;
    showViewF.origin.x = kScrW;
    CGRect tableViewF = self.tableView.frame;
    tableViewF.origin.x = 0;
    NSArray * cells = self.tableView.visibleCells;
    [UIView animateWithDuration:1.0f animations:^{
        self.showView.frame = showViewF;
        self.tableView.frame = tableViewF;
        [cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [[obj subTitleLab] setAlpha:1];
        }];
    } completion:^(BOOL finished) {
        [self setupNavButton];
        self.show = NO;
    }];
}

- (void)filterButtonClick:(id)sender
{
}

@end
