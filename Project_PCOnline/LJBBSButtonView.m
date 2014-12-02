//
//  LJBBSButtonView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSButtonView.h"


@implementation LJBBSButtonView

+ (instancetype)bbsButtonViewWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    LJBBSButtonView * view = [[LJBBSButtonView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    //设置Button
    NSInteger count = titles.count;
    CGFloat btnW = 80;
    CGFloat padding = (kScrW - btnW * count) / (count + 1);
    CGFloat btnH = CGRectGetHeight(frame);
    for (int i = 0; i < count; i++) {
        LJSelectButton * btn = [LJSelectButton selectButtonWithFrame:CGRectMake(i * (btnW + padding) + padding, 0, btnW, btnH) andTitle:titles[i]];
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:btn];
    }
    //设置分割线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame) - 1, CGRectGetWidth(view.frame), 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    return view;
}

//点击事件
- (void)btnClick:(LJSelectButton *)sender
{
    if (self) {
        if ([self.delegate respondsToSelector:@selector(BBSButtonView:didClickButton:)]) {
            [self.delegate BBSButtonView:self didClickButton:sender];
        }
    }
}

@end
