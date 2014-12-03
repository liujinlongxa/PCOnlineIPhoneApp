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
    if (self.dragging) {
        return;
    }
    if (self.curIndex != self.contentOffset.x / CGRectGetWidth(self.frame) + 1) {
        self.curIndex = self.contentOffset.x / CGRectGetWidth(self.frame);
    }
    if (self.curIndex == self.viewCount) {
        self.curIndex = 0;
    }
    [self setContentOffset:CGPointMake(self.curIndex * CGRectGetWidth(self.frame), 0) animated:YES];
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

@end
