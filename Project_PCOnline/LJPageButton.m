//
//  LJPageButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPageButton.h"

@implementation LJPageButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:@"btn_common_toolbar_page"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat btnH = CGRectGetHeight(self.frame);
    CGFloat btnW = CGRectGetWidth(self.frame);
    return CGRectMake(30, 0, btnW - 30, btnH);
}

@end
