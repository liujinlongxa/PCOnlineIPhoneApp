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

@interface LJAdsGroupView ()<UIScrollViewDelegate>

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
    self.scrollView.delegate = self;
}

//加载数据
- (void)loadAdsData
{
    if (self.images.count == 0) {
        return;
    }
    for (int i = 0; i < self.images.count + 2; i++) {
        NSString * image = nil;
        NSString * title = nil;
        if (i == 0) {
            image = self.images[self.images.count - 1];
            title = self.titles[self.titles.count - 1];
        }
        else if(i == self.images.count + 1)
        {
            image = self.images[0];
            title = self.titles[0];
        }
        else{
            image = self.images[i - 1];
            title = (i >= self.titles.count) ? nil : self.titles[i - 1];
        }
        //改变frame
        CGRect adFrame = self.viewF;
        adFrame.origin.x = i * adFrame.size.width;
        adFrame.origin.y = 0;
        LJAdView * adView = [LJAdView adViewWithFrame:adFrame andImage:image andTitle:title];
        [self.scrollView addSubview:adView];
    }
    self.scrollView.contentSize = CGSizeMake((self.images.count + 2) * CGRectGetWidth(self.viewF), 0);
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

#pragma mark - 重新加载
- (void)reloadView
{
    //删除以前的子控件，全部重新加载
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

#pragma mark - 滚动视图代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= scrollView.contentSize.width - CGRectGetWidth(scrollView.frame)) {
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame), 0);
    }
}

@end
