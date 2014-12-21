//
//  LJBigSettingButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBigSettingButton.h"

@implementation LJBigSettingButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat padding = 10;
    return CGRectMake(padding, padding, CGRectGetWidth(contentRect) - padding * 2, CGRectGetHeight(contentRect) * 0.6 - padding);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, CGRectGetHeight(contentRect) * 0.6, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect) * 0.4);
}

@end
