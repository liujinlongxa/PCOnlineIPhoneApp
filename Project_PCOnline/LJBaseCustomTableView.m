//
//  LJBaseCustomView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseCustomTableView.h"

@interface LJBaseCustomTableView ()


@end

@implementation LJBaseCustomTableView

- (void)showData
{
    //抽象方法
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.curPage = 1;
        [self setupRefresh];
    }
    return self;
}

#pragma mark - 设置刷新
- (void)setupRefresh
{
    __weak typeof(self) weakSelf = self;
    [self addHeaderWithCallback:^{
        weakSelf.curPage = 1;
        [weakSelf showData];
    }];
    [self addFooterWithCallback:^{
        weakSelf.curPage++;
        [weakSelf showData];
    }];
}

- (void)beginRefresh
{
    if (!self.isRefresh) {
        self.Refresh = YES;
        [self headerBeginRefreshing];
        [self showData];
    }
}

@end
