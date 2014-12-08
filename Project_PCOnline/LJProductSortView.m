//
//  LJProductSortView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductSortView.h"
#import "LJProductSelectButton.h"
#import "LJCommonHeader.h"

@interface LJProductSortView ()

@property (nonatomic, weak) UIView * shadowView;
@property (nonatomic, weak) LJProductSelectButton * curSelect;
@end

@implementation LJProductSortView

- (instancetype)initProductSortViewWithFrame:(CGRect)frame andButTitles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        CGFloat btnH = CGRectGetHeight(frame) / 4;
        for (int i = 0; i < titles.count; i++) {
            LJProductSelectButton * btn = [[LJProductSelectButton alloc] initWithFrame:CGRectMake(0, i * btnH, kScrW, btnH) andTitles:titles[i]];
            [btn addTarget:self action:@selector(selectSortType:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.tag = i;
        }
        [[self.subviews firstObject] setSelected:YES];
        self.curSelect = [self.subviews firstObject];
    }
    return self;
}

+ (instancetype)productScoTViewWithFrame:(CGRect)frame andButTitles:(NSArray *)titles
{
    LJProductSortView * sortView = [[self alloc] initProductSortViewWithFrame:frame andButTitles:titles];
    return sortView;
}

- (void)selectSortType:(LJProductSelectButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(productSortView:didSelectIndex:)]) {
        [self.delegate productSortView:self didSelectIndex:sender.tag];
    }
    if (sender == self.curSelect) return;
    sender.selected = YES;
    self.curSelect.selected  = NO;
    self.curSelect = sender;
}

@end
