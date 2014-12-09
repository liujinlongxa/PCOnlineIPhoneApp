//
//  LJSearchBar.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSearchBar.h"
#import "LJSearchBarChannelButton.h"
#import "LJCommonHeader.h"

@interface LJSearchBar ()

@property (nonatomic, weak) LJSearchBarChannelButton * selectButton;
@property (nonatomic, weak) UITextField * textField;
@property (nonatomic, weak) UIButton * searchButton;
@property (nonatomic, copy) void (^actionBlock)(NSInteger index) ;
@end

@implementation LJSearchBar

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andActionBlock:(void (^)(NSInteger index))actionBlock
{
    CGFloat barY = frame.origin.y;
    CGFloat barH = 60;
    if (self = [super initWithFrame:CGRectMake(0, barY, kScrW, barH)]) {
        
        self.actionBlock = actionBlock;
        
        //button
        LJSearchBarChannelButton * btn = [[LJSearchBarChannelButton alloc] initWithFrame:CGRectMake(0, 0, 100, barH - 20) andTitiles:titles andActionBlock:nil];
        [self addSubview:btn];
        self.selectButton = btn;
        
        //text field
        UITextField * text = [[UITextField alloc] init];
        text.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        text.layer.borderWidth = 1;
        text.backgroundColor = [UIColor whiteColor];
        text.layer.cornerRadius = 5;
        text.leftView = btn;
        text.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:text];
        self.textField = text;
        
        //search button
        UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn setTitleColor:BlueTextColor forState:UIControlStateNormal];
        [self addSubview:searchBtn];
        [searchBtn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.searchButton = searchBtn;
        
        //line
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 1, kScrW, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
    
    CGFloat searchBtnW = 50;
    
    self.textField.frame = CGRectMake(padding * 2, padding, CGRectGetWidth(self.frame) - searchBtnW - 5 * padding, CGRectGetHeight(self.frame) - 2 * padding);
    self.searchButton.frame = CGRectMake(CGRectGetMaxX(self.textField.frame) + padding, padding, searchBtnW, CGRectGetHeight(self.frame) - 2 * padding);
}

- (void)searchButtonClick:(id)sender
{
    self.actionBlock(self.selectButton.curSelectIndex);
}

@end
