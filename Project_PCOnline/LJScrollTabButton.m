//
//  LJScrollTabButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJScrollTabButton.h"
#define kBlueViewH 3

@interface LJScrollTabButton ()

@property (nonatomic, weak) UIView * blueView;

@end

@implementation LJScrollTabButton

+ (instancetype)scrollTabButtonWithTitle:(NSString *)title
{
    LJScrollTabButton * button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:BlueTextColor forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //创建蓝色view
    UIView * blueView = [[UIView alloc] init];
    blueView.backgroundColor = BlueTextColor;
    blueView.hidden = YES;
    [button addSubview:blueView];
    button.blueView = blueView;
    
    return button;
}

- (void)layoutSubviews
{
    CGFloat viewX = 0;
    CGFloat viewH = kBlueViewH;
    CGFloat viewY = CGRectGetHeight(self.frame) - viewH;
    CGFloat viewW = CGRectGetWidth(self.frame);
    self.blueView.frame = CGRectMake(viewX, viewY, viewW, viewH);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.blueView.hidden = !selected;
}

@end
