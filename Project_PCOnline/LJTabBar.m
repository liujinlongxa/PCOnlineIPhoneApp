//
//  LJTabBar.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJTabBar.h"


#define kTabCount (5)

@implementation LJTabBar
{
    LJTabButton * curSelect;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //资讯
        LJTabButton * newBtn = [self setupTabButtonWithImage:@"pconline_tab_information" andSelectImage:@"pconline_tab_information_hl"];
        curSelect = newBtn;
        newBtn.selected = YES;
        [self addSubview:newBtn];
        
        //论坛
        LJTabButton * bbsBtn = [self setupTabButtonWithImage:@"pconline_tab_bbs" andSelectImage:@"pconline_tab_bbs_hl"];
        [self addSubview:bbsBtn];
        
        //找产品
        LJTabButton * productBtn = [self setupTabButtonWithImage:@"pconline_tab_products" andSelectImage:@"pconline_tab_products_hl"];
        [self addSubview:productBtn];
        
        //图赏
        LJTabButton * photoBtn = [self setupTabButtonWithImage:@"pconline_tab_photos" andSelectImage:@"pconline_tab_photos_hl"];
        [self addSubview:photoBtn];
        
        //专栏
        LJTabButton * specialBtn = [self setupTabButtonWithImage:@"pconline_tab_more" andSelectImage:@"pconline_tab_more_hl"];
        [self addSubview:specialBtn];
    }
    return self;
}

- (LJTabButton *)setupTabButtonWithImage:(NSString *)image andSelectImage:(NSString *)selectImage
{
    LJTabButton * btn = [[LJTabButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    return btn;
}

- (void)layoutSubviews
{
    CGFloat btnW = kScrW / kTabCount;
    CGFloat btnH = kTabBarH;
    for (int i = 0; i < kTabCount; i++) {
        LJTabButton * btn = [self.subviews objectAtIndex:i];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void)btnClick:(LJTabButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didselectButton:)]) {
        curSelect.selected = NO;
        sender.selected = YES;
        curSelect = sender;
        [self.delegate tabBar:self didselectButton:sender];
        
    }
}



@end
