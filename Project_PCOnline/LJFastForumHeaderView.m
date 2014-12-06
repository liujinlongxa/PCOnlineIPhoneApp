//
//  LJFastForumHeaderView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJFastForumHeaderView.h"
#import "LJBBSListItem.h"
#import "LJFastSubForumButton.h"
#import "LJContentView.h"

@implementation LJFastForumHeaderView

+ (instancetype)fastForumHeaderViewWithBBSList:(LJBBSList *)bbsList
{
    
    LJFastForumHeaderView * headerView = [[self alloc] initWithFrame:CGRectMake(0, 0, kScrW, 110)];
    CGFloat padding = 10;
    //设置背景view
    LJContentView * contentView = [[LJContentView alloc] initWithFrame:CGRectMake(padding, padding, CGRectGetWidth(headerView.frame) - 2 * padding, CGRectGetHeight(headerView.frame) - padding)];
    [headerView addSubview:contentView];
    
    //添加button
    NSInteger btnCount = bbsList.children.count;
    CGFloat btnY = 10;
    CGFloat btnPadding = (CGRectGetWidth(contentView.frame) - btnCount * kBtnW) / (btnCount + 1);
    for (int i = 0; i < bbsList.children.count; i++) {
        LJBBSList * subList = bbsList.children[i];
        LJFastSubForumButton * btn = [LJFastSubForumButton fastSubForumButtonWithItem:subList.listItem];
        CGFloat btnX = i * (kBtnW + btnPadding) + btnPadding;
        CGRect btnF = btn.frame;
        btnF.origin = CGPointMake(btnX, btnY);
        btn.frame = btnF;
        [btn addTarget:headerView action:@selector(fastForumHeaderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
    }
    return headerView;
}

- (void)fastForumHeaderBtnClick:(LJFastSubForumButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(fastForumHeaderView:didSelectForumItem:)])
    {
        [self.delegate fastForumHeaderView:self didSelectForumItem:sender.bbsListItem];
    }
}

@end
