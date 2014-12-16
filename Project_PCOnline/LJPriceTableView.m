//
//  LJPriceTableView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPriceTableView.h"
#import "LJPriceTableHeaderView.h"

@implementation LJPriceTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        LJPriceTableHeaderView * header = [[LJPriceTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScrW, 50)];
        self.tableHeaderView = header;
    }
    return self;
}

@end
