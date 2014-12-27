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
#import "LJNetWorkingTool.h"
#import "LJProductCategoryCell.h"
#import "LJProductSortView.h"
//控制器
#import "LJSubProductCategoryTableVC.h"
#import "LJBrandTableVC.h"
#import "LJProductListTableVC.h"
#import "LJFullScreenBrandVC.h"
#import "LJProductFilterListTVC.h"

#define kCategoryDataFileName @"PCOnlineProductDatas4inch.json"
#define kCategoryCellIdentifier @"CategoryCell"

#define kShowViewW 220 //showview的宽度
#define kTableViewOffset 90 //tableview偏移距离

@interface LJProductViewController ()<UITableViewDelegate, UITableViewDataSource, LJBrandTableVCDelegate, LJSubProductCategoryTableVCDelegate>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * categoryData;
@property (nonatomic, strong) NSMutableDictionary * categoryNameData;

@property (nonatomic, weak) UIView * showView;//显示品牌或子分类的区域

@property (nonatomic, assign, getter=isShow) BOOL show;

@property (nonatomic, strong) UIViewController * curSlideVC;

@property (nonatomic, assign, getter=isSubCategory) BOOL subCategory;
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
    
    //设置手势
    [self setupGesture];
    
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

- (void)setSubCategory:(BOOL)subCategory
{
    _subCategory = subCategory;
    if (subCategory) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClick:)];
    }
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
    [LJNetWorkingTool GET:kProductCategoryNameUrl parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
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
        brandVC.delegate = self;
        self.curSlideVC = brandVC;
        [self.showView addSubview:brandVC.view];
        //重新显示导航栏右侧按钮
        self.subCategory = NO;
    }
    else //显示子分类
    {
        LJSubProductCategoryTableVC * subCategoryVC = [[LJSubProductCategoryTableVC alloc] initWithStyle:UITableViewStylePlain];
        subCategoryVC.subCategories = category.childs;
        subCategoryVC.delegate = self;
        self.curSlideVC = subCategoryVC;
        [self.showView addSubview:subCategoryVC.view];
        //隐藏导航栏右按钮
//        self.navigationItem.rightBarButtonItem = nil;
        self.subCategory = YES;
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
    [UIView animateWithDuration:0.5f animations:^{
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isShow)
    {
        [self changeNavButton];
    }
}

- (void)changeNavButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    
    if (!self.isSubCategory) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonClick:)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)backButtonClick:(id)sender
{
    //动画
    CGRect showViewF = self.showView.frame;
    showViewF.origin.x = kScrW;
    CGRect tableViewF = self.tableView.frame;
    tableViewF.origin.x = 0;
    NSArray * cells = self.tableView.visibleCells;
    [UIView animateWithDuration:0.5f animations:^{
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

#pragma mark - 选择某品牌的代理方法
- (void)brandTableVC:(LJBrandTableVC *)tableVC didSelectBrand:(LJBrand *)brand
{
    LJProductListTableVC * productListVC = [[LJProductListTableVC alloc] init];
    productListVC.brand = brand;
    [self.navigationController pushViewController:productListVC animated:YES];
}

#pragma mark - 选择某子品牌的代理方法
-(void)SubProductCategoryTVC:(LJSubProductCategoryTableVC *)controller didSelectSubCategory:(LJProductSubCategory *)subCategory
{
    LJFullScreenBrandVC * brandVC = [[LJFullScreenBrandVC alloc] init];
    brandVC.subCategory = subCategory;
    [self.navigationController pushViewController:brandVC animated:YES];
}

#pragma mark - 筛选btn
- (void)filterButtonClick:(id)sender
{
    LJProductFilterListTVC * filterTVC = [[LJProductFilterListTVC alloc] initWithStyle:UITableViewStylePlain];
    LJProductCategoryCell * cell = (LJProductCategoryCell *)[self.tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
    filterTVC.subCategory = [cell.category.childs firstObject];
    [self.navigationController pushViewController:filterTVC animated:YES];
}

#pragma mark - 设置showview 的手势滑动
- (void)setupGesture
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(showViewPanGesture:)];
    [self.showView addGestureRecognizer:pan];
}

- (void)setProductLabAlpha:(CGFloat)alpha
{
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[obj subTitleLab] setAlpha:alpha];
    }];
}

- (CGFloat)curSubLabAlpah
{
    return self.isShow ? 0 : 1;
}

- (void)showViewPanGesture:(UIPanGestureRecognizer *)pan
{
    static CGPoint startPoint;
    static CGFloat startAlpah;
    CGPoint endPoint = CGPointZero;
    CGFloat endAlpah = 0; //sublabel 的透明度
    CGRect showViewFrame = self.showView.frame;
    CGRect tableViewFrame = self.tableView.frame;
    //根据手势的不同过程设置view的frame
    if (pan.state == UIGestureRecognizerStateBegan) {
        //记录手势开始点和开始的透明度
        startPoint = [pan translationInView:self.view];
        startAlpah = [self curSubLabAlpah];
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        endPoint = [pan translationInView:self.view];
        CGFloat offset = endPoint.x - startPoint.x;
        
        if (showViewFrame.origin.x + offset > kScrW) { //到达右边界
            showViewFrame.origin.x = kScrW;
            tableViewFrame.origin.x = 0;
            endAlpah = 0;
        }
        else if(showViewFrame.origin.x + offset < kScrW - kShowViewW) //到达左边界
        {
            showViewFrame.origin.x = kScrW - kShowViewW;
            tableViewFrame.origin.x = -kTableViewOffset;
            endAlpah = 1;
        }
        else
        {
            CGFloat rate = offset / kShowViewW;
            showViewFrame.origin.x = showViewFrame.origin.x + offset;
            tableViewFrame.origin.x = tableViewFrame.origin.x + rate * kTableViewOffset;
            endAlpah = startAlpah + rate;
        }
        
        [self setProductLabAlpha:endAlpah];
        self.showView.frame = showViewFrame;
        self.tableView.frame = tableViewFrame;
        startPoint = endPoint;
        startAlpah = endAlpah;
    }
    else
    {
        //手势结束后，showView会自动回到最近的一侧
        CGFloat offset;
        CGFloat leftOffset = showViewFrame.origin.x - kScrW + kShowViewW;
        CGFloat rightOffset = kScrW - showViewFrame.origin.x;
        if (leftOffset > rightOffset) { //靠近右侧
            offset = rightOffset;
            showViewFrame.origin.x = kScrW;
            tableViewFrame.origin.x = 0;
            endAlpah = 1;
        }
        else //靠近左侧
        {
            offset = leftOffset;
            showViewFrame.origin.x = kScrW - kShowViewW;
            tableViewFrame.origin.x = -kTableViewOffset;
            endAlpah = 0;
        }
        NSTimeInterval animateDur = offset / (kScrW - kTableViewOffset) * 2.0f; //计算相对时间
        [UIView animateWithDuration:animateDur animations:^{
            self.showView.frame = showViewFrame;
            self.tableView.frame = tableViewFrame;
            [self setProductLabAlpha:endAlpah];
        } completion:^(BOOL finished) {
            //设置导航栏
            if (leftOffset > rightOffset) {
                [self setupNavButton];
                self.show = NO;
            }
            else
            {
                [self changeNavButton];
                self.show = YES;
            }
        }];
    }
}
    
    

@end
