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
{
    CGFloat btnW;
    CGFloat btnH;
    CGFloat padding;
    NSInteger lineNum;
    CGFloat titleH;
}

- (instancetype)initWithFrame:(CGRect)frame andButttons:(NSArray *)buttons andTitles:(NSString *)title
{
    padding = 10;
    titleH = title ? kTitleLabH : 0;
    btnH = CGRectGetHeight([[buttons firstObject] frame]);
    btnW = CGRectGetWidth([[buttons firstObject] frame]);
    lineNum = ceil(buttons.count / kCountOfBtnInOneLine);
    //view Frame
    CGFloat viewX = frame.origin.x;
    CGFloat viewY = frame.origin.y;
    CGFloat viewW = kScrW;
    CGFloat viewH = titleH + padding + lineNum * (btnH + padding) + kBottomBlankH;
    
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
    if (self.titleLabel) {
        titleW = kScrW;
        self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    }
    
    //buttons
    CGFloat startY = padding + CGRectGetMaxY(self.titleLabel.frame);
    lineNum = ceil(self.buttons.count / kCountOfBtnInOneLine);
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
    [self addgestureToButton:button];
}

- (void)removeButton:(LJChannelItemBtn *)button
{
    [self.buttons removeObject:button];
    [button removeFromSuperview];
    [self removeGestureFromButton:button];
}

#pragma mark - drag to move
- (void)setCanDragToMove:(BOOL)canDragToMove
{
    _canDragToMove = canDragToMove;
    if (canDragToMove)
    {
        for (LJChannelItemBtn * btn in self.buttons) {
            [self addgestureToButton:btn];
        }
    }
}

- (void)addgestureToButton:(LJChannelItemBtn *)button
{
    if(!self.isCanDragToMove) return;
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLogPress:)];
    longPress.minimumPressDuration = 0.5f;
    [button addGestureRecognizer:longPress];
    button.dragGesture = longPress;
}

- (void)removeGestureFromButton:(LJChannelItemBtn *)button
{
    if (button.dragGesture)
    {
        [button removeGestureRecognizer:button.dragGesture];
        button.dragGesture = nil;
    }
}

- (void)buttonLogPress:(UILongPressGestureRecognizer *)gesture
{
    CGPoint p = [gesture locationInView:self];
    LJChannelItemBtn * btn = (LJChannelItemBtn *)gesture.view;
    [self bringSubviewToFront:btn];
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        //超出边界不再移动
        if (p.x + btnW / 2 <= viewW && p.x - btnW / 2 >= 0 &&
            p.y + btnH / 2 <= viewH && p.y - btnH / 2 >= 0)
        {
            btn.center = p;
        }
        [self updateButtonsLocationMovingWithPoint:p andMovingButton:btn];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        //移动结束后，更新button的位置
        [self updateButtonsLocationMoveEndWithPoint:p andButton:btn];
    }
    
}

- (void)updateButtonsLocationMoveEndWithPoint:(CGPoint)point andButton:(LJChannelItemBtn *)button
{
    CGFloat startY = padding + CGRectGetMaxY(self.titleLabel.frame);
    [UIView animateWithDuration:0.3f animations:^{
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
    }];
}

- (void)updateButtonsLocationMovingWithPoint:(CGPoint)point andMovingButton:(LJChannelItemBtn *)movingBtn
{
    for (LJChannelItemBtn * btn in self.buttons) {
        if(btn == movingBtn) continue;
        //第一个头条不移动
        if (CGRectContainsPoint(btn.frame, point) && [self.buttons indexOfObject:btn] != 0)
        {
            NSInteger movingBtnIndex = [self.buttons indexOfObject:movingBtn];
            NSInteger btnIndex = [self.buttons indexOfObject:btn];
            [self.buttons removeObject:movingBtn];
            if (movingBtnIndex > btnIndex)
            {
                [self.buttons insertObject:movingBtn atIndex:[self.buttons indexOfObject:btn]];
            }
            else
            {
                [self.buttons insertObject:movingBtn atIndex:[self.buttons indexOfObject:btn] + 1];
            }
            [self updateLocationWithMovingBtn:movingBtn];
            
            break;
        }
    }
}

- (void)updateLocationWithMovingBtn:(LJChannelItemBtn *)movingBtn
{
    CGFloat startY = padding + CGRectGetMaxY(self.titleLabel.frame);
    [UIView animateWithDuration:0.3f animations:^{
        for (int i = 0; i < lineNum; i++) {
            for (int j = 0; j < kCountOfBtnInOneLine; j++) {
                NSInteger index = i * kCountOfBtnInOneLine + j;
                if (index >= self.buttons.count) return;
                LJChannelItemBtn * button = self.buttons[index];
                if(button == movingBtn) continue; //如果遇见自己，则继续
                CGFloat btnX = padding + (btnW + padding) * j;
                CGFloat btnY = (btnH + padding) * i + startY;
                button.frame = CGRectMake(btnX, btnY, btnW, btnH);
            }
        }
    }];
}

@end
