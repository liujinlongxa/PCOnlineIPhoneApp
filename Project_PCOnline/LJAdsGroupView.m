//
//  LJAdView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJAdsGroupView.h"
#import "LJAdView.h"
#import "LJInfiniteScrollView.h"

@interface LJAdsGroupView ()

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * images;

@property (nonatomic, weak) LJInfiniteScrollView * scrollView;
@property (nonatomic, assign) CGRect viewF;
@end

@implementation LJAdsGroupView

+ (instancetype)adViewWithAds:(NSArray *)ads andFrame:(CGRect)frame
{
    LJAdsGroupView * adView = [[self alloc] initWithFrame:frame];
    adView.viewF = frame;
    NSLog(@"%@", NSStringFromCGRect(frame));
    [adView setupDataWithAds:ads];
    [adView setupView];
    adView.backgroundColor = [UIColor greenColor];
    adView.layer.cornerRadius = 5;
    adView.clipsToBounds = YES;
    return adView;
}

- (void)setupView
{
    //设置uiscrollview
    CGRect scrollFrame = self.viewF;
    scrollFrame.origin.x = 0;
    scrollFrame.origin.y = 0;
    LJInfiniteScrollView * scrollView = [[LJInfiniteScrollView alloc] initWithFrame:scrollFrame];
    [self addSubview:scrollView];
    self.scrollView  = scrollView;
    [self loadAdsData];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
}

//加载数据
- (void)loadAdsData
{
    for (int i = 0; i < self.images.count; i++) {
        NSString * image = self.images[i];
        NSString * title = (i >= self.titles.count) ? nil : self.titles[i];
        //改变frame
        CGRect adFrame = self.viewF;
        adFrame.origin.x = i * adFrame.size.width;
        adFrame.origin.y = 0;
        LJAdView * adView = [LJAdView adViewWithFrame:adFrame andImage:image andTitle:title];
        [self.scrollView addSubview:adView];
    }
    self.scrollView.contentSize = CGSizeMake(self.images.count * CGRectGetWidth(self.viewF), 0);
    [self.scrollView startInfiniteScrollView];
}

- (void)setupDataWithAds:(NSArray *)ads
{
    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * titles = [NSMutableArray array];
    for (LJBaseAds * baseAd in ads) {
        [images addObject:baseAd.image];
        [titles addObject:baseAd.title];
    }
    
    self.titles = [titles copy];
    self.images = [images copy];
}

- (void)reloadView
{
    for (UIView * view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self loadAdsData];
}

- (void)reloadViewWithAds:(NSArray *)ads
{
    [self setupDataWithAds:ads];
    [self reloadView];
}

@end
