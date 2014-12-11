//
//  LJChannelItemBtn.m
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJChannelItemBtn.h"
#import "LJCommonHeader.h"

#define kBtnCountInOneLine 4
@implementation LJChannelItemBtn

- (instancetype)initWithFrame:(CGRect)frame andSubject:(LJSubject *)subject
{
    CGFloat padding = 10;
    CGFloat btnX = frame.origin.x;
    CGFloat btnY = frame.origin.y;
    CGFloat btnW = (kScrW - padding * (kBtnCountInOneLine + 1)) / kBtnCountInOneLine;
    CGFloat btnH = 30;
    if (self = [super initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)]) {
        [self setTitle:subject.title forState:UIControlStateNormal];
        self.backgroundColor = LightGrayBGColor;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
        self.show = NO;
        self.subject = subject;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    }
    return self;
}

@end
