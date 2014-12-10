//
//  LJProductSearchResultVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductSearchResultVC.h"
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "LJProductSearchResultItem.h"
#import "LJNetWorking.h"
#import "LJProductSearchResultCell.h"

#define kProductSearchResultCellIdentifier @"ProductSearchResultCell"

@interface LJProductSearchResultVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * searchResultData;
@property (nonatomic, copy) void (^selectAction)(LJProductSearchResultItem * item);
@property (nonatomic, weak) UITableView * tableView;
@end

@implementation LJProductSearchResultVC

- (instancetype)initWithSelectActionBlock:(void (^)(LJProductSearchResultItem * item))actionBlock
{
    self = [super init];
    if (self) {
        self.selectAction = actionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init table view
    [self setupTableView];
}

#pragma mark - init UI
- (void)setupTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - 50 - kNavBarH - kStatusBarH) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:[UINib nibWithNibName:@"LJProductSearchResultCell" bundle:nil] forCellReuseIdentifier:kProductSearchResultCellIdentifier];
}

#pragma mark - search
- (NSMutableArray *)searchResultData
{
    if (!_searchResultData) {
        _searchResultData = [NSMutableArray array];
    }
    return _searchResultData;
}

- (void)setKeyWord:(NSString *)keyWord
{
    _keyWord = keyWord;
    [self search];
}

- (void)search
{
    NSString * urlStr = [NSString stringWithFormat:kProductSearchUrl, self.keyWord];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        for (NSDictionary * itemDict in dict[@"resultList"]) {
            LJProductSearchResultItem * item = [LJProductSearchResultItem productSearchResultItemWithDict:itemDict];
            [self.searchResultData addObject:item];
        }
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductSearchResultCell * cell = [tableView dequeueReusableCellWithIdentifier:kProductSearchResultCellIdentifier];
    LJProductSearchResultItem * item = self.searchResultData[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJProductSearchResultItem * item = self.searchResultData[indexPath.row];
    if (self.selectAction) {
        self.selectAction(item);
    }
}





@end
