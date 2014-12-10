//
//  LJSearchBar.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSearchBar.h"
#import "LJSearchBarSelectButtonsView.h"
#import "LJCommonHeader.h"

@interface LJSearchBar ()

@property (nonatomic, weak) LJSearchBarSelectButtonsView * selectButtonView;

@property (nonatomic, weak) UIView * inputView;
@property (nonatomic, weak) UIButton * selectButton;


@property (nonatomic, weak) UIView * line;
@property (nonatomic, weak) UIButton * searchButton;

@property (nonatomic, weak) UIView * bottomLine;

@property (nonatomic, copy) void (^actionBlock)(NSInteger index);

@end

@implementation LJSearchBar

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    CGFloat barY = frame.origin.y;
    CGFloat barH = 50;
    self.backgroundColor = [UIColor redColor];
    if (self = [super initWithFrame:CGRectMake(0, barY, kScrW, barH)]) {
        
        //inputView
        UIView * inputView = [[UIView alloc] init];
        [self addSubview:inputView];
        self.inputView = inputView;
        self.inputView.layer.borderWidth = 1;
        self.inputView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.inputView.layer.cornerRadius = 5;
        self.inputView.clipsToBounds = YES;
        
        //line
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.inputView addSubview:line];
        self.line = line;
        
        //text field
        UITextField * text = [[UITextField alloc] init];
        text.backgroundColor = [UIColor whiteColor];
        [self.inputView addSubview:text];
        self.textField = text;
        self.textField.text = @"iPhone";
        
        //button
        UIButton * selectBtn = [[UIButton alloc] init];
        [selectBtn setTitle:titles[0] forState:UIControlStateNormal];
        [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        selectBtn.backgroundColor = [UIColor whiteColor];
        [self.inputView addSubview:selectBtn];
        self.selectButton = selectBtn;
        [self.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //search button
        UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn setTitleColor:BlueTextColor forState:UIControlStateNormal];
        [self addSubview:searchBtn];
        [searchBtn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.searchButton = searchBtn;
        
        //bottom line
        UIView * bottomLine =[[UIView alloc] init];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLine];
        self.bottomLine = bottomLine;
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
    CGFloat searchBtnW = 40;
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    
    //input view
    CGFloat inputX = padding * 2;
    CGFloat inputY = padding;
    CGFloat inputW = viewW - searchBtnW - 4 * padding;
    CGFloat inputH = viewH - 2 * padding;
    self.inputView.frame = CGRectMake(inputX, inputY, inputW, inputH);
    
    //search btn
    CGFloat searchBtnX = CGRectGetMaxX(self.inputView.frame) + padding;
    CGFloat searchBtnY = padding;
    CGFloat searchBtnH = viewH - 2 * padding;
    self.searchButton.frame = CGRectMake(searchBtnX, searchBtnY, searchBtnW, searchBtnH);
    
    //select btn
    CGFloat selectBtnX = 0;
    CGFloat selectBtnY = 0;
    CGFloat selectBtnW = 80;
    CGFloat selectBtnH = CGRectGetHeight(self.inputView.frame);
    self.selectButton.frame = CGRectMake(selectBtnX, selectBtnY, selectBtnW, selectBtnH);
    
    //line
    CGFloat lineX = CGRectGetMaxX(self.selectButton.frame);
    self.line.frame = CGRectMake(lineX, 0, 1, CGRectGetHeight(self.inputView.frame));
    
    //text filed
    CGFloat textX = CGRectGetMaxX(self.line.frame);
    CGFloat textW = CGRectGetWidth(self.inputView.frame) - CGRectGetWidth(self.selectButton.frame) - 1;
    self.textField.frame = CGRectMake(textX, 0, textW, CGRectGetHeight(self.inputView.frame));
    
    //bottom
    self.bottomLine.frame = CGRectMake(0, viewH - 1, viewW, 1);
    
}

- (void)selectButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(searchBar:didClickSelectBtn:)]) {
        [self.delegate searchBar:self didClickSelectBtn:sender];
    }
}

- (void)searchButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(searchBar:didClickSearchBtn:)]) {
        [self.delegate searchBar:self didClickSearchBtn:sender];
    }
}

@end
