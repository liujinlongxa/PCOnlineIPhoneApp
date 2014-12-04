//
//  LJBrandTableVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBrandTableVC.h"
#import "LJNetWorking.h"
#import "LJBrandGroup.h"
#import "LJBrand.h"
#import "UIImageView+WebCache.h"
#import "LJBrandCell.h"

#define kBrandCellIdentifier @"BrandCell"
#define kBrandImageCellIdentifier @"ImageBrandCell"

@interface LJBrandTableVC ()

@property (nonatomic, strong) NSMutableArray * brandData;

@end

@implementation LJBrandTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kBrandCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJBrandCell" bundle:nil] forCellReuseIdentifier:kBrandImageCellIdentifier];
}

- (void)viewDidLayoutSubviews
{
    UIEdgeInsets edge = self.tableView.contentInset;
    edge.bottom = kNavBarH + kTabBarH;
    self.tableView.contentInset = edge;
    CGRect viewF = self.tableView.frame;
    viewF.origin.y = 0;
    self.tableView.frame = viewF;
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

- (void)loadBrandData
{
    NSString * urlStr = [NSString stringWithFormat:kBrandListUrl, self.subCategory.sid];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        [[LJCommonData shareCommonData] saveObjc:dict[@"type"] forKey:ProductTypeKey];//保存type
        //解析数据
        //推荐品牌
        LJBrandGroup * recommendBrand = [LJBrandGroup brandGroupWithDict:dict[@"partition"][@"recommondBrands"]];
        if (recommendBrand.brands.count > 0) {
            [self.brandData addObject:recommendBrand];
        }
        //其他品牌
        for (NSDictionary * brandDict in dict[@"partition"][@"totalBrands"][@"sections"]) {
            LJBrandGroup * group = [LJBrandGroup brandGroupWithDict:brandDict];
            [self.brandData addObject:group];
        }
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.brandData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LJBrandGroup * group = self.brandData[section];
    return group.brands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBrandGroup * group = self.brandData[indexPath.section];
    LJBrand * brand = group.brands[indexPath.row];
    
    if (brand.logo != nil && ![brand.logo isEqualToString:@""]) {
        LJBrandCell * cell = [tableView dequeueReusableCellWithIdentifier:kBrandImageCellIdentifier];
        cell.brand = brand;
        return cell;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBrandCellIdentifier];
        cell.textLabel.text = brand.name;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBrandGroup * group = self.brandData[indexPath.section];
    LJBrand * brand = group.brands[indexPath.row];
    if (brand.logo != nil && ![brand.logo isEqualToString:@""]) {
        return 60;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    LJBrandGroup * group = self.brandData[section];
    return [group.index isEqualToString:@"荐"] ? @"推荐品牌" : group.index;
}

@end
