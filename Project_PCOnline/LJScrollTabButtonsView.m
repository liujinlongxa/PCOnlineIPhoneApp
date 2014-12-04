//
//  LJScrollTabButtonsView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJScrollTabButtonsView.h"
#define kBtnH 40

@interface LJScrollTabButtonsView ()

@property (nonatomic, assign) NSInteger curSelectIndex;
@property (nonatomic, strong) NSMutableArray * buttons;

@end

@implementation LJScrollTabButtonsView

+ (instancetype)scrollTabButtonsViewWithTitles:(NSArray *)titles
{
    LJScrollTabButtonsView * view = [[LJScrollTabButtonsView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kBtnH)];
    
    //设置Button
    NSInteger count = titles.count;
    CGFloat btnW = 80;
    CGFloat padding = (kScrW - btnW * count) / (count + 1);
    CGFloat btnH = CGRectGetHeight(view.frame);
    for (int i = 0; i < count; i++) {
        LJScrollTabButton * btn = [LJScrollTabButton scrollTabButtonWithTitle:titles[i]];
        btn.frame = CGRectMake(i * (btnW + padding) + padding, 0, btnW, btnH);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"haha" forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:btn];
        [view.buttons addObject:btn];
    }
    //设置分割线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame) - 1, CGRectGetWidth(view.frame), 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    //设置默认选中
    view.curSelectIndex = 0;
    [view selectButtonAtIndex:0];
    return view;
}
//点击事件
- (void)btnClick:(LJScrollTabButton *)sender
{
    NSLog(@"haha");
    if (self) {
        if ([self.delegate respondsToSelector:@selector(scrollTabButtonsView:didSelectIndex:)]) {
            [self.delegate scrollTabButtonsView:self didSelectIndex:sender.tag];
        }
    }
}

- (void)selectButtonAtIndex:(NSInteger)index
{
    if(index == self.curSelectIndex) return;
    [self.buttons[index] setSelected:YES];
    [self.buttons[self.curSelectIndex] setSelected:NO];
    self.curSelectIndex = index;
}

@end
