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
@property (nonatomic, assign) CGRect sortBtnViewFrame;
@end

@implementation LJProductSortView

+ (instancetype)productScoTViewWithFrame:(CGRect)frame andButTitles:(NSArray *)titles
{
    LJProductSortView * sortView = [[self alloc] initWithFrame:frame];
    sortView.sortBtnViewFrame = frame;
    //button
    CGFloat btnH = CGRectGetHeight(frame) / 4;
    for (int i = 0; i < titles.count; i++) {
        LJProductSelectButton * btn = [[LJProductSelectButton alloc] initWithFrame:CGRectMake(0, i * btnH, kScrW, btnH) andTitles:titles[i]];
        [btn addTarget:self action:@selector(selectSortType:) forControlEvents:UIControlEventTouchUpInside];
        [sortView addSubview:btn];
    }
    
    return sortView;
}



- (void)selectSortType:(id)sender
{
    
}

@end
