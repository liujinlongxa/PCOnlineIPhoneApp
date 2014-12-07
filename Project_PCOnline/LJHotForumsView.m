//
//  LJHotForumsView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotForumsView.h"
#import "LJHotForumButton.h"

#define kPadding 10

@interface LJHotForumsView ()

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) NSArray * btnArr;

@end

@implementation LJHotForumsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel * lab = [[UILabel alloc] init];
        lab.text = @"热门板块";
        lab.textColor = [UIColor grayColor];
        [self addSubview:lab];
        self.titleLab = lab;
    }
    return self;
}

- (void)setForumsData:(NSArray *)forumsData
{
    _forumsData = forumsData;
    self.titleLab.frame = CGRectMake(2 * kPadding, 0, kScrW - kPadding * 4, 40);
    CGFloat btnStartY = CGRectGetMaxY(self.titleLab.frame) + kPadding;
    CGFloat btnW = kScrW - 2 * kPadding;
    CGFloat btnH = 70;
    CGFloat btnX = kPadding;
    for (int i = 0; i < forumsData.count; i++) {
        LJHotForumButton * button = [[LJHotForumButton alloc] initWithFrame:CGRectMake(btnX, btnStartY + i * (btnH + kPadding), btnW, btnH)];
        button.hotForum = forumsData[i];
        [button addTarget:self action:@selector(forumsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    CGRect viewF = self.frame;
    viewF.size.height = CGRectGetMaxY([self.subviews.lastObject frame]) + kPadding;
    self.frame = viewF;
}

#pragma mark - 按钮点击
- (void)forumsButtonClick:(LJHotForumButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(hotForumView:didSelectHotForum:)])
    {
        [self.delegate hotForumView:self didSelectHotForum:sender.hotForum];
    }
}

@end
