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

#define kNewsButtonCount 3
#define kMoreBtnH 40

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

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items andClickActionBlock:(void (^)(NSInteger clickIndex))actionBlock
{
    //个数为0则返回nil
    if (items.count == 0) return nil;
    
    NSInteger count = items.count > kNewsButtonCount ? kNewsButtonCount : items.count;
    CGFloat BtnH = (frame.size.height - kMoreBtnH) / kNewsButtonCount;
    frame.size.height = kMoreBtnH + count * BtnH;
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clickActionBlock = actionBlock;
        
        //border
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor whiteColor];
        
        self.newsItems = items;
        
    }
    return self;
}

/**
 *  按钮点击，回调Block
 */
- (void)btnClick:(UIControl *)sender
{
    if (self.clickActionBlock)
    {
        self.clickActionBlock(sender.tag);
    }
}

/**
 *  初始化UI
 */
- (void)setupSubViewsWithItems:(NSArray *)newsItems
{
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    NSInteger count = newsItems.count > kNewsButtonCount ? kNewsButtonCount : newsItems.count;
    
    //根据搜索结果，初始化Button
    CGFloat newsBtnX = 0;
    CGFloat newsBtnW = viewW;
    CGFloat newsBtnH = (viewH - kMoreBtnH) / count;
    for (int i = 0; i < count; i++) {
        CGFloat newsBtnY = i * newsBtnH;
        LJNewsSearchItemView * btn = [[LJNewsSearchItemView alloc] initWithFrame:CGRectMake(newsBtnX, newsBtnY, newsBtnW, newsBtnH) andActionBlock:nil];
        [self addSubview:btn];
        [self.newsBtns addObject:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.newsItem = newsItems[i];
    }
    
    //more btn
    CGFloat moreBtnX = 0;
    CGFloat moreBtnY = CGRectGetMaxY([[self.newsBtns lastObject] frame]);
    CGFloat moreBtnW = viewW;
    CGFloat moreBtnH = kMoreBtnH;
    UIButton * moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(moreBtnX, moreBtnY, moreBtnW, moreBtnH)];
    moreBtn.tag = count;
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:moreBtn];
    self.moreBtn = moreBtn;
    [moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
 *  设置数据
 */
- (void)setNewsItems:(NSArray *)newsItems
{
    _newsItems = newsItems;
    
    //初始化UI，必须在获取数据后再初始化UI
    [self setupSubViewsWithItems:newsItems];
    
    //设置更多Button上的文字
    LJNewsSearchResultItem * item = [self.newsItems firstObject];
     [self.moreBtn setTitle:[NSString stringWithFormat:@"查看所有%@(%d)", item.type, self.newsItems.count] forState:UIControlStateNormal];
}

/**
 *  布局子控件
 */
//- (void)setupSubviewsLayoutWithCount:(NSInteger)count
//{
//    CGFloat viewW = CGRectGetWidth(self.frame);
//    CGFloat viewH = CGRectGetHeight(self.frame);
//    CGFloat moreH = 40;
//    
//    //btn
//    CGFloat newsBtnX = 0;
//    CGFloat newsBtnW = viewW;
//    CGFloat newsBtnH = (viewH - moreH) / count;
//    for (int i = 0; i < count; i++) {
//        CGFloat newsBtnY = i * newsBtnH;
//        [self.newsBtns[i] setFrame:CGRectMake(newsBtnX, newsBtnY, newsBtnW, newsBtnH)];
//    }
//    
//    //more btn
//    CGFloat moreBtnX = 0;
//    CGFloat moreBtnY = CGRectGetMaxY([[self.newsBtns lastObject] frame]);
//    CGFloat moreBtnW = viewW;
//    CGFloat moreBtnH = moreH;
//    self.moreBtn.frame = CGRectMake(moreBtnX, moreBtnY, moreBtnW, moreBtnH);
//}

@end
