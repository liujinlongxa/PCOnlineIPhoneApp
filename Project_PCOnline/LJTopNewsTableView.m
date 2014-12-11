//
//  LJTopNewsTableView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJTopNewsTableView.h"
#import "LJAdsGroupView.h"

@interface LJTopNewsTableView ()

@property (nonatomic, weak) LJAdsGroupView * groupView;

@end

@implementation LJTopNewsTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置headView
        [self setupAdsHeaderView];
    }
    return self;
}

- (void)setupAdsHeaderView
{
    CGFloat padding = 10;
    LJAdsGroupView * group = [LJAdsGroupView adViewWithAds:self.adsData andFrame:CGRectMake(padding, padding, kScrW - 2 * padding, 120)];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrW, CGRectGetHeight(group.frame) + 2 * padding)];
    [view addSubview:group];
    self.tableHeaderView = view;
    self.groupView = group;
}

- (void)reloadHeaderView
{
    [self.groupView reloadViewWithAds:self.adsData];
}

- (void)dealloc
{
    LJLog(@"top news tvc dealloc");
}

@end
