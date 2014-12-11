//
//  InfiniteScrollView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//  无限定时滚动View

#import "LJInfiniteScrollView.h"

@interface LJInfiniteScrollView ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) NSInteger viewCount;
@end

@implementation LJInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.time = 4.0f;
        self.curIndex = 0;
        
        self.timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(beginAutoScroll:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)beginAutoScroll:(NSTimer *)timer
{
    //如果正在手动滑动，则不滚动
    if (self.dragging) {
        return;
    }
    //手动滑动到新的位置后，从新的位置继续开始自动滚动
    if (self.curIndex != self.contentOffset.x / CGRectGetWidth(self.frame) + 1) {
        self.curIndex = self.contentOffset.x / CGRectGetWidth(self.frame);
    }
    //无限切换时不需要动画
    if (self.curIndex == self.viewCount) {
        self.curIndex = 1;
        [self setContentOffset:CGPointMake(self.curIndex * CGRectGetWidth(self.frame), 0) animated:NO];
    }
    else
    {
        [self setContentOffset:CGPointMake(self.curIndex * CGRectGetWidth(self.frame), 0) animated:YES];
    }
    self.curIndex++;
}

- (void)startInfiniteScrollView
{
    self.viewCount = self.contentSize.width / CGRectGetWidth(self.frame);
    [self.timer fire];
}

- (void)stopScroll
{
    [self.timer invalidate];
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
