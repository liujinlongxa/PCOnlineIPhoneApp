//
//  LJAdView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJAdsGroupView.h"
#import "LJAdView.h"

@interface LJAdsGroupView ()

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * images;

@property (nonatomic, weak) UIScrollView * scrollView;

@end

@implementation LJAdsGroupView

+ (instancetype)adViewWithAds:(NSArray *)ads andFrame:(CGRect)frame
{
    LJAdsGroupView * adView = [[self alloc] initWithFrame:frame];
    [adView setupDataWithAds:ads];
    [adView setupViewWithFrame:frame];
    adView.layer.cornerRadius = 5;
    adView.clipsToBounds = YES;
    return adView;
}

- (void)setupViewWithFrame:(CGRect)frame
{
    //设置uiscrollview
    CGRect scrollFrame = frame;
    scrollFrame.origin.x = 0;
    scrollFrame.origin.y = 0;
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    [self addSubview:scrollView];
    self.scrollView  = scrollView;
    for (int i = 0; i < self.images.count; i++) {
        NSString * image = self.images[i];
        NSString * title = (i >= self.titles.count) ? nil : self.titles[i];
        //改变frame
        CGRect adFrame = frame;
        adFrame.origin.x = i * adFrame.size.width;
        adFrame.origin.y = 0;
        LJAdView * adView = [LJAdView adViewWithFrame:adFrame andImage:image andTitle:title];
        [scrollView addSubview:adView];
    }
    self.scrollView.contentSize = CGSizeMake(self.images.count * CGRectGetWidth(frame), 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
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
    if (self.scrollView.subviews.count == 0) {
        [self setupViewWithFrame:self.scrollView.frame];
        return;
    }
    
#warning 考虑个数不相同的情况
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        LJAdView * adView = self.scrollView.subviews[i];
        [adView updateWithImage:self.images[i] andTitle:self.titles[i]];
    }
}

- (void)reloadViewWithAds:(NSArray *)ads
{
    [self setupDataWithAds:ads];
    [self reloadView];
}

@end
