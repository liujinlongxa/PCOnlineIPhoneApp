//
//  LJNewsSearchGroupView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsSearchGroupView.h"
#import "LJNewsSearchItemView.h"
#import "LJNewsSearchResultItem.h"

#define kNewsBtnCount 3

@interface LJNewsSearchGroupView ()

@property (nonatomic, copy) void (^clickActionBlock)(NSInteger clickIndex);
@property (nonatomic, strong) NSMutableArray * newsBtns;
@property (nonatomic, weak) UIButton * moreBtn;

@end

@implementation LJNewsSearchGroupView

- (NSMutableArray *)newsBtns
{
    if (!_newsBtns) {
        _newsBtns = [NSMutableArray array];
    }
    return _newsBtns;
}

- (instancetype)initWithFrame:(CGRect)frame andClickActionBlock:(void (^)(NSInteger clickIndex))actionBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clickActionBlock = actionBlock;
        
        //border
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor whiteColor];
        
        //new btns
        for (int i = 0; i < kNewsBtnCount; i++) {
            LJNewsSearchItemView * btn = [[LJNewsSearchItemView alloc] initWithFrame:CGRectZero andActionBlock:nil];
            [self addSubview:btn];
            [self.newsBtns addObject:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
        }
        
        //more btn
        
        UIButton * moreBtn = [[UIButton alloc] init];
//        NSAttributedString * attStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"查看所有%@(%d)", item.type, self.newsItems.count]];
#warning 如何给部分文字加颜色
        moreBtn.tag = kNewsBtnCount;
        [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:moreBtn];
        self.moreBtn = moreBtn;
        [moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)btnClick:(UIControl *)sender
{
    if (self.clickActionBlock)
    {
        self.clickActionBlock(sender.tag);
    }
}

- (void)setNewsItems:(NSArray *)newsItems
{
    _newsItems = newsItems;
    for (int i = 0; i < kNewsBtnCount; i++) {
        LJNewsSearchItemView * item = self.newsBtns[i];
        item.newsItem = self.newsItems[i];
    }
    LJNewsSearchResultItem * item = [self.newsItems firstObject];
     [self.moreBtn setTitle:[NSString stringWithFormat:@"查看所有%@(%d)", item.type, self.newsItems.count] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    CGFloat moreH = 40;
    
    //btn
    CGFloat newsBtnX = 0;
    CGFloat newsBtnW = viewW;
    CGFloat newsBtnH = (viewH - moreH) / kNewsBtnCount;
    for (int i = 0; i < kNewsBtnCount; i++) {
        CGFloat newsBtnY = i * newsBtnH;
        [self.newsBtns[i] setFrame:CGRectMake(newsBtnX, newsBtnY, newsBtnW, newsBtnH)];
    }
    
    //more btn
    CGFloat moreBtnX = 0;
    CGFloat moreBtnY = CGRectGetMaxY([[self.newsBtns lastObject] frame]);
    CGFloat moreBtnW = viewW;
    CGFloat moreBtnH = moreH;
    self.moreBtn.frame = CGRectMake(moreBtnX, moreBtnY, moreBtnW, moreBtnH);
}

@end
