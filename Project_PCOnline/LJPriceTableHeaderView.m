//
//  LJPriceTableHeaderView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/16.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPriceTableHeaderView.h"
#import "LJCommonData.h"
#import "LJCommonHeader.h"



@interface LJPriceTableHeaderView ()

@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UIButton * locationButton;

@end

@implementation LJPriceTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        //title
        UILabel * titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        self.titleLab = titleLabel;
        self.titleLab.text = @"行情文章";
        
        //local button
        self.curArea = [LJCommonData shareCommonData].curArea;
        UIButton * localButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:localButton];
        self.locationButton = localButton;
        self.locationButton.adjustsImageWhenHighlighted = NO;
        self.locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 5);
        [self.locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.locationButton setTitle:self.curArea.title forState:UIControlStateNormal];
        [self.locationButton setBackgroundImage:[UIImage imageNamed:@"select_area_btn"] forState:UIControlStateNormal];
        [self.locationButton addTarget:self action:@selector(localButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
                                  
- (void)layoutSubviews
{
    CGFloat padding = 5;
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    
    self.titleLab.frame = CGRectMake(2 * padding, padding, 100, viewH - 2 * padding);
    
    CGFloat btnW = 70;
    self.locationButton.frame = CGRectMake(viewW - 2 * padding - btnW, padding, btnW, viewH - 2 * padding);
}


- (void)localButtonClick:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLJPriceTableLocationButtonClickNotification object:self];
}

- (void)setCurArea:(LJArea *)curArea
{
    _curArea = curArea;
    [self.locationButton setTitle:curArea.title forState:UIControlStateNormal];
}

@end
