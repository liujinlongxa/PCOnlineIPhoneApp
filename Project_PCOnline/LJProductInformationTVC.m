//
//  LJProductInformationTVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductInformationTVC.h"
#import "LJNetWorkingTool.h"
#include "LJCommonHeader.h"
#import "LJUrlHeader.h"


#define LJProductInformationCellIdentifier @"ProductInformationCell"

@interface LJProductInformationTVC ()

@property (nonatomic, strong) NSMutableArray * informationData;

@end

@implementation LJProductInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LJProductInformationCellIdentifier];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kNavBarH * 2, 0);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.informationData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductInformation * info = self.informationData[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LJProductInformationCellIdentifier];
    cell.textLabel.text = info.title;
    return cell;
}

#pragma mark - 加载数据
- (NSMutableArray *)informationData
{
    if (!_informationData) {
        _informationData = [NSMutableArray array];
        [self loadInformationData];
    }
    return _informationData;
}

- (NSString *)setupUrlStr
{
    NSString * urlStr = nil;
    if (self.product == nil) {
        urlStr = [NSString stringWithFormat:kProductDetailInformationUrl, self.productID.integerValue];
    }
    else
    {
        urlStr = [NSString stringWithFormat:kProductDetailInformationUrl, self.product.ID.integerValue];
    }
    assert(urlStr != nil);
    return urlStr;
}

- (void)loadInformationData
{
    [LJNetWorkingTool GET:[self setupUrlStr] parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * infoDict in dict[@"articleList"]) {
            LJProductInformation * pInfo = [LJProductInformation productInformationWithDict:infoDict];
            pInfo.productId = dict[@"productId"];
            [arr addObject:pInfo];
        }
        self.informationData = arr;
        [self.tableView reloadData];
        
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

#pragma mark - 选中一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductInformation * info = self.informationData[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(productInformationTVC:didSelectInfo:)]) {
        [self.delegate productInformationTVC:self didSelectInfo:info];
    }
}

@end
