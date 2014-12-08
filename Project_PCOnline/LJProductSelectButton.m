//
//  LJProductSelectButton.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//



#import "LJProductSelectButton.h"
#import "LJCommonHeader.h"
#import "UIImage+MyImage.h"
#define kImageW 20
@implementation LJProductSelectButton

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        //图片
        [self setImage:[UIImage imageWithNameNoRender:@"btn_common_blue_selected_hint"] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageWithNameNoRender:@"btn_common_blue_selected_hint"] forState:UIControlStateSelected];
        //标题颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:BlueTextColor forState:UIControlStateSelected];
        [self setTitleColor:BlueTextColor forState:UIControlStateHighlighted];
        //背景颜色
        self.backgroundColor = LightGrayBGColor;
        //分割先
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(frame) - 1, CGRectGetWidth(frame) - 10, 1)];
        [self addSubview:line];
        line.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat padding = 10;
    return CGRectMake(padding, 0, CGRectGetWidth(contentRect) - kImageW - padding * 3, CGRectGetHeight(contentRect));
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat padding = 10;
    return CGRectMake(CGRectGetWidth(contentRect) - padding - kImageW, padding / 2, kImageW, CGRectGetHeight(contentRect) - padding);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.backgroundColor = LightGrayBGColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.backgroundColor = LightGrayBGColor;
    }
    
}

@end
