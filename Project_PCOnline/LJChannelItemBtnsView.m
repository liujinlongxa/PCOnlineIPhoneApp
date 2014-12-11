//
//  LJChannelItemBtnsView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJChannelItemBtnsView.h"
#import "LJCommonHeader.h"

#define kTitleLabH 30

@interface LJChannelItemBtnsView ()

@end

@implementation LJChannelItemBtnsView

- (instancetype)initWithFrame:(CGRect)frame andButttons:(NSArray *)buttons andTitles:(NSString *)title
{
    CGFloat padding = 10;
    CGFloat titleH = 0;
    if (title) titleH = kTitleLabH;
    CGFloat bottomH = kBottomBlankH;
    CGFloat btnH = CGRectGetHeight([[buttons firstObject] frame]);
    NSInteger lineNum = ceil(buttons.count / kCountOfBtnInOneLine);
    //view Frame
    CGFloat viewX = frame.origin.x;
    CGFloat viewY = frame.origin.y;
    CGFloat viewW = kScrW;
    CGFloat viewH = titleH + padding + lineNum * (btnH + padding) + bottomH;
    
    if (self = [super initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)]) {
        
        //title label
        if (title) {
            UILabel * titleLab = [[UILabel alloc] init];
            titleLab.text = title;
            [self addSubview:titleLab];
            self.titleLabel = titleLab;
            self.titleLabel.textColor = [UIColor lightGrayColor];
        }
        
        //buttons
        self.buttons = [buttons mutableCopy];
        for (LJChannelItemBtn * btn in buttons) {
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    //title label
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = 0;
    CGFloat titleH = 0;
    if (self.titleLabel) {
        titleW = kScrW;
        titleH = kTitleLabH;
        self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    }
    
    //buttons
    CGFloat padding = 10;
    CGFloat startY = padding + CGRectGetMaxY(self.titleLabel.frame);
    CGFloat btnW = CGRectGetWidth([[self.buttons firstObject] frame]);
    CGFloat btnH = CGRectGetHeight([[self.buttons firstObject] frame]);
    
    NSInteger lineNum = ceil(self.buttons.count / kCountOfBtnInOneLine);
    for (int i = 0; i < lineNum; i++) {
        for (int j = 0; j < kCountOfBtnInOneLine; j++) {
            NSInteger index = i * kCountOfBtnInOneLine + j;
            if (index >= self.buttons.count) return;
            LJChannelItemBtn * button = self.buttons[index];
            CGFloat btnX = padding + (btnW + padding) * j;
            CGFloat btnY = (btnH + padding) * i + startY;
            button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        }
    }
}

#pragma mark - add or remove button
- (void)addButton:(LJChannelItemBtn *)button
{
    [self.buttons addObject:button];
    [self addSubview:button];
}

- (void)removeButton:(LJChannelItemBtn *)button
{
    [self.buttons removeObject:button];
    [button removeFromSuperview];
}



@end
