//
//  LJSearchBarChannelButton.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSearchBarChannelButton.h"

@interface LJSearchBarChannelButton ()

@property (nonatomic, copy) void (^actionBlock)(NSInteger index);
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSMutableArray * buttons;

@property (nonatomic, assign, getter=isShow) BOOL show;

@property (nonatomic, weak) UIView * bigView;
@property (nonatomic, weak) UIView * smallView;
@end

@implementation LJSearchBarChannelButton

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
            btn.hidden = YES;
            [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
        [[self.buttons firstObject] setHidden:NO];
        self.curSelectIndex = 0;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat btnW = CGRectGetWidth(self.frame);
    CGFloat btnH = CGRectGetHeight(self.frame);
    for (int i = 0; i < self.buttons.count; i++) {
        [self.buttons[i] setFrame:CGRectMake(0, i * btnH, btnW, btnH)];
    }
}

- (void)btnSelect:(UIButton *)sender
{
    //点击第一个button，显示下拉菜单
    if (sender.tag == 0 && !self.isShow) {
        
        CGRect viewF = self.frame;
        viewF.size.height = self.titles.count * CGRectGetHeight(viewF);
        self.frame = viewF;
        
        [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setHidden:NO];
        }];
        sender.backgroundColor = [UIColor lightGrayColor];
        [sender setTitle:self.titles[0] forState:UIControlStateNormal];
        self.show = YES;
    }
    else//点击下拉菜单上的按钮，隐藏下拉菜单
    {
        CGRect viewF = self.frame;
        viewF.size.height = CGRectGetHeight(viewF) / self.titles.count;
        self.frame = viewF;
        
        [[self.buttons firstObject] setTitle:sender.currentTitle forState:UIControlStateNormal];
        [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx != 0) {
                [obj setHidden:YES];
            }
        }];
        self.show = NO;
        self.curSelectIndex = sender.tag;
        if (self.actionBlock) {
            self.actionBlock(sender.tag);
        }
        
    }
}

@end
