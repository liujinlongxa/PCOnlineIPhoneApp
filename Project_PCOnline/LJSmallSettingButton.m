//
//  LJSmallSettingButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSmallSettingButton.h"

@implementation LJSmallSettingButton

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textColor = [UIColor whiteColor];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
}

@end
