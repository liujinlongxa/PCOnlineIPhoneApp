//
//  LJSubProductCategoryTableVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSubProductCategoryTableVC.h"
#import "LJProductCategory.h"
#import "LJProductSubCategory.h"

#define kSubProductCategoryCellIdentifier @"SubProductCategoryCell"

@interface LJSubProductCategoryTableVC ()

@end

@implementation LJSubProductCategoryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSubProductCategoryCellIdentifier];
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

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.subCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSubProductCategoryCellIdentifier];
    LJProductSubCategory * category = self.subCategories[indexPath.row];
    cell.textLabel.text = category.title;
    return cell;
}


@end
