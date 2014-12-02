//
//  LJBBSSquareViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSquareViewController.h"
#import "LJAdsGroupView.h"
#import "LJNetWorking.h"
//模型
#import "LJBBSAds.h"

#define kBBSAdsKey @"focus"

@interface LJBBSSquareViewController ()

//scrollView
@property (nonatomic, weak) UIScrollView * scrollView;

//数据
@property (nonatomic, strong) NSMutableArray * adsData;
@property (nonatomic, strong) NSMutableArray * hotTopicData;
@property (nonatomic, strong) NSMutableArray * hotForumsData;
//广告栏
@property (nonatomic, strong) LJAdsGroupView * adsView;
@end

@implementation LJBBSSquareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //scrollview
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    //设置广告
    CGFloat adsX = 10;
    CGFloat adsW = kScrW - adsX * 2;
    CGFloat adsY = 10;
    CGFloat adsH = 100;
    LJAdsGroupView * adsView = [LJAdsGroupView adViewWithAds:self.adsData andFrame:CGRectMake(adsX, adsY, adsW, adsH)];
    adsView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:adsView];
    self.adsView = adsView;
    
    
    self.scrollView.contentSize = CGSizeMake(0, 500);
}

#pragma mark - 加载数据
- (NSMutableArray *)adsData
{
    if (!_adsData) {
        _adsData = [NSMutableArray array];
        [self loadAdsData];
    }
    return _adsData;
}

- (void)loadAdsData
{
    NSString * urlStr = kBBSAdsUrl;
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //解析数据
        NSMutableArray * adsArr = [NSMutableArray array];
        for (NSDictionary * adsDict in dict[kBBSAdsKey]) {
            LJBBSAds * ads = [LJBBSAds BBSAdsWithDict:adsDict];
            [adsArr addObject:ads];
        }
        _adsData = adsArr;
        [self reloadAdsData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)reloadAdsData
{
    [self.adsView reloadViewWithAds:self.adsData];
}

@end
