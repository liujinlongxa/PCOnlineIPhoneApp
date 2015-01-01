//
//  LJNewsSearchItemView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsSearchItemView.h"
#import "LJNewsSearchResultItem.h"

@interface LJNewsSearchItemView ()

@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UILabel * dateLab;
@property (nonatomic, weak) UIView * bottomLine;
@property (nonatomic, copy) void (^clickActionBlock)(LJNewsSearchResultItem * newItem);
@end

@implementation LJNewsSearchItemView

- (instancetype)initWithFrame:(CGRect)frame andActionBlock:(void (^)(LJNewsSearchResultItem * newsItem))clickActionBlcok
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //title lab
        UILabel * titleLab = [[UILabel alloc] init];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        self.titleLab.numberOfLines = 2;
        self.titleLab.font = [UIFont systemFontOfSize:16];
        
        //date lab
        UILabel * dateLab = [[UILabel alloc] init];
        [self addSubview:dateLab];
        self.dateLab = dateLab;
        self.dateLab.font = [UIFont systemFontOfSize:15];
        self.dateLab.textColor = [UIColor lightGrayColor];
        
        //bottom line
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        self.bottomLine = line;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    CGFloat padding = 10;
    
    //title
    CGFloat titleX = padding;
    CGFloat titleY = padding;
    CGFloat titleW = viewW - 2 * padding;
    CGFloat titleH = 40;
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //date lab
    CGFloat dateX = titleX;
    CGFloat dateY = CGRectGetMaxY(self.titleLab.frame) + padding;
    CGFloat dateW = viewW - 2 * padding;
    CGFloat dateH = viewH - 3 * padding - CGRectGetHeight(self.titleLab.frame);
    self.dateLab.frame = CGRectMake(dateX, dateY, dateW, dateH);
    
    //line
    CGFloat lineX = 0;
    CGFloat lineY = viewH - 1;
    CGFloat lineW = viewW;
    CGFloat lineH = 1;
    self.bottomLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
}

- (void)setNewsItem:(LJNewsSearchResultItem *)newsItem
{
    self.titleLab.text = newsItem.title;
    self.dateLab.text = newsItem.pubDate;
}

@end
