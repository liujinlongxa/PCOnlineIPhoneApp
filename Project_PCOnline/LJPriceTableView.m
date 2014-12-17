//
//  LJPriceTableView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPriceTableView.h"
#import "LJPriceTableHeaderView.h"

@interface LJPriceTableView ()

@property (nonatomic, weak) LJPriceTableHeaderView * areaHeader;

@end

@implementation LJPriceTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        LJPriceTableHeaderView * header = [[LJPriceTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScrW, 40)];
        self.tableHeaderView = header;
        self.areaHeader = header;
    }
    return self;
}

- (void)setCurArea:(LJArea *)curArea
{
    self.areaHeader.curArea = curArea;
}

@end
