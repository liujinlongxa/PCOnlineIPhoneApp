//
//  LJBBSSearchResultVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSearchResultVC.h"
#import "LJCommonHeader.h"
#import "LJCommonData.h"
#import "LJUrlHeader.h"
#import "LJBBSList.h"
#import "LJBBSListItem.h"
#import "LJNetWorkingTool.h"


#define kLJBBSSearchResultCellIdentifier @"BBSSearchResultCell"

@interface LJBBSSearchResultVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSArray * bbsListData;
@property (nonatomic, strong) NSMutableArray * resultList;

@property (nonatomic, copy) void (^selectAction)(LJBBSListItem * item);

@end

@implementation LJBBSSearchResultVC

- (instancetype)initWithSelectActionBlock:(void (^)(LJBBSListItem * item))actionBlock
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
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLJBBSSearchResultCellIdentifier];
}

#pragma mark - load data
- (NSArray *)bbsListData
{
    if (!_bbsListData) {
        [self loadBBSListData];
    }
    return _bbsListData;
}

- (void)loadBBSListData
{
    NSArray * listData = [LJCommonData shareCommonData].BBSListData;
    if (listData) {
        _bbsListData = listData;
        return;
    }
    //从远程加载
    [LJNetWorkingTool GET:kBBSListUrl parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * bbsListDict in dict[@"children"]) {
            LJBBSList * list = [LJBBSList bbsListWithDict:bbsListDict];
            [arr addObject:list];
        }
        _bbsListData = [arr copy];
        [self search];
        [LJCommonData shareCommonData].BBSListData = arr;
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - search
- (NSMutableArray *)resultList
{
    if (!_resultList) {
        _resultList = [NSMutableArray array];
    }
    return _resultList;
}

- (void)setKeyWord:(NSString *)keyWord
{
    _keyWord = keyWord;
    [self search];
}

- (void)searchBBSList:(LJBBSList *)list
{
    //使用递归进行搜索
    if (list.children == nil) {
        if ([list.listItem.title rangeOfString:self.keyWord options:NSCaseInsensitiveSearch | NSLiteralSearch].location != NSNotFound) {
            [self.resultList addObject:list.listItem];
        }
    }
    else
    {
        for (LJBBSList * subList in list.children) {
            [self searchBBSList:subList];
        }
    }
}

- (void)search
{
    for (LJBBSList * list in self.bbsListData) {
        [self searchBBSList:list];
    }
    [self.tableView reloadData];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJBBSSearchResultCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kLJBBSSearchResultCellIdentifier];
    }
    LJBBSListItem * item = self.resultList[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = @"进入论坛";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBBSListItem * item = self.resultList[indexPath.row];
    if (self.selectAction) {
        self.selectAction(item);
    }
    
    
}

@end
