//
//  LJPullBarButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPullBarButton.h"
#import "LJCommonHeader.h"

@implementation LJPullBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:BlueTextColor forState:UIControlStateSelected];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.layer.borderColor = [BlueTextColor CGColor];
    }
    else
    {
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
}

@end
