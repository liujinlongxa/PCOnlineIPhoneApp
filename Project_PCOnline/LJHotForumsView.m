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

- (instancetype)initHotForumsViewWithFroums:(NSArray *)forumsData
{
    if (self = [super init]) {
        self.forumsData = forumsData;
        
        UILabel * lab = [[UILabel alloc] init];
        lab.text = @"热门板块";
        [self addSubview:lab];
        
    }
    return self;
}

- (void)setForumsData:(NSArray *)forumsData
{
    _forumsData = forumsData;
    self.titleLab.frame = CGRectMake(2 * kPadding, kPadding, kScrW - kPadding * 4, 40);
    CGFloat btnStartY = CGRectGetMaxY(self.titleLab.frame) + kPadding;
    CGFloat btnW = kScrW - 2 * kPadding;
    CGFloat btnH = 70;
    CGFloat btnX = kPadding;
    for (int i = 0; i < forumsData.count; i++) {
        LJHotForumButton * button = [[LJHotForumButton alloc] initWithFrame:CGRectMake(btnX, btnStartY + i * (btnH + kPadding), btnW, btnH)];
        button.hotForum = forumsData[i];
        [self addSubview:button];
    }
    CGRect viewF = self.frame;
    viewF.size.height = CGRectGetMaxY([self.subviews.lastObject frame]);
    self.frame = viewF;
}


@end
