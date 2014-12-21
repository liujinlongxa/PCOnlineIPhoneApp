//
//  LJSearchBarChannelButton.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSearchBarSelectButtonsView.h"

@interface LJSearchBarSelectButtonsView ()

@property (nonatomic, copy) void (^actionBlock)(NSInteger index);
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSMutableArray * buttons;

@property (nonatomic, weak) UIButton * curSelectBtn;

@end

@implementation LJSearchBarSelectButtonsView

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame andTitiles:(NSArray *)titles andActionBlock:(void (^)(NSInteger))actionBlock
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.actionBlock = actionBlock;
        self.titles = titles;
        
        //添加button
        for (int i = 0; i < titles.count; i++) {
            UIButton * btn = [[UIButton alloc] init];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            btn.layer.borderWidth = 0.5;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:btn];
            [self.buttons addObject:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
        [[self.buttons firstObject] setBackgroundColor:[UIColor lightGrayColor]];
        self.curSelectBtn = [self.buttons firstObject];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat btnW = CGRectGetWidth(self.frame);
    CGFloat btnH = CGRectGetHeight(self.frame) / self.titles.count;
    for (int i = 0; i < self.buttons.count; i++) {
        [self.buttons[i] setFrame:CGRectMake(0, i * btnH, btnW, btnH)];
    }
}

- (void)btnSelect:(UIButton *)sender
{
    sender.backgroundColor = [UIColor lightGrayColor];
    self.curSelectBtn.backgroundColor = [UIColor whiteColor];
    self.curSelectBtn = sender;
    self.actionBlock(sender.tag);
}

@end
