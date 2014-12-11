//
//  LJProductFilterSelectItemListTVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductFilterSelectItemListTVC.h"
#import "LJProductFilterItemCell.h"
#import "LJCommonHeader.h"

#define kProductFilterSelectItemCellIdentifier @"ProductFilterSelectItemCell"

@interface LJProductFilterSelectItemListTVC ()

@end

@implementation LJProductFilterSelectItemListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[LJProductFilterItemCell class] forCellReuseIdentifier:kProductFilterSelectItemCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backNavBtnClick:)];
    self.navigationItem.title = @"选择";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelect:)];
}

- (void)backNavBtnClick:(id)sender
{
    //点击返回按钮返回，不保存选择项
    for (LJProductFilterItem * item in self.group.cris) {
        item.selected = NO;
    }
    self.group.selectCount = 0;
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 选择完成
- (void)finishSelect:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.group.cris.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductFilterItem * item = self.group.cris[indexPath.row];
    LJProductFilterItemCell * cell = [tableView dequeueReusableCellWithIdentifier:kProductFilterSelectItemCellIdentifier];
    cell.item = item;
    return cell;
}

#pragma mark - 选中一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LJProductFilterItem * item = self.group.cris[indexPath.row];
    if (item.isSelected) {
        item.selected = NO;
        self.group.selectCount--;
    }
    else
    {
        item.selected = YES;
        self.group.selectCount++;
    }
}

#pragma mark - tablview 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    return [NSString stringWithFormat:@"选择%@", self.group.name];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScrW, 60)];
    lab.text = [NSString stringWithFormat:@"  选择%@", self.group.name];
    lab.backgroundColor = [UIColor lightGrayColor];
    lab.textColor = [UIColor darkGrayColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    assert(section == 0);
    return 40;
}

@end
