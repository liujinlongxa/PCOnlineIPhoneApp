//
//  LJCommentBar.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentBar.h"
#import "LJCommonHeader.h"
#import "LJPageButton.h"

@interface LJCommentBar ()

@property (nonatomic, weak) UITextField * textField;
@property (nonatomic, weak) UIButton * collectionButton;
@property (nonatomic, weak) UIButton * pageButton;

@end

@implementation LJCommentBar

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = kBarH;
    frame.size.width = kScrW;
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 0.5;
        
        //textfield
        UITextField * textField = [[UITextField alloc] init];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"我也来说点什么...";
        //text field left view
        UIImageView * leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_topic_list_send_topic"]];
        textField.leftView = leftImage;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.backgroundColor = LightGrayBGColor;
        [self addSubview:textField];
        self.textField = textField;
        self.textField.layer.borderWidth = 1;
        self.textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textField.layer.cornerRadius = 5;
        
        //collection button
        UIButton * collectionBtn = [[UIButton alloc] init];
        [collectionBtn setImage:[UIImage imageNamed:@"btn_common_toolbar_collect"] forState:UIControlStateNormal];
        [collectionBtn setImage:[UIImage imageNamed:@"btn_common_toolbar_collected"] forState:UIControlStateSelected];
        [self addSubview:collectionBtn];
        self.collectionButton = collectionBtn;
        
        //page button
        LJPageButton * pageButton = [[LJPageButton alloc] init];
        [self addSubview:pageButton];
        self.pageButton = pageButton;
        [self.pageButton addTarget:self action:@selector(showPageTable:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
    //text filed
    CGFloat textX = padding;
    CGFloat textY = padding * 1.5;
    CGFloat textW = kScrW * 0.6;
    CGFloat textH = kBarH - 3 * padding;
    self.textField.frame = CGRectMake(textX, textY, textW, textH);
    
    //collection button
    CGFloat collectX = CGRectGetMaxX(self.textField.frame);
    CGFloat collectW = 40;
    CGFloat collectH = 40;
    CGFloat collectY = (kBarH - collectH) / 2;
    self.collectionButton.frame = CGRectMake(collectX, collectY, collectW, collectH);
    
    //page button
    CGFloat pageX = CGRectGetMaxX(self.collectionButton.frame);
    CGFloat pageW = 80;
    CGFloat pageH = 40;
    CGFloat pageY = (kBarH - pageH) / 2;
    self.pageButton.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
}

- (void)setPage:(LJCommentPage *)page
{
    _page = page;
//    self.curPage = 0;
    
}

- (void)setCurPage:(NSInteger)curPage
{
    _curPage = curPage;
    [self.pageButton setTitle:[NSString stringWithFormat:@"%d/%d", self.curPage + 1, self.page.pageCount.integerValue] forState:UIControlStateNormal];
}

#pragma mark - 点击page button 选择页面
- (void)showPageTable:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(commentBar:didSelectPageButton:)])
    {
        [self.delegate commentBar:self didSelectPageButton:sender];
    }
}

#pragma mark - 点击收藏button
- (void)collectionButtonClck:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if ([self.delegate respondsToSelector:@selector(commentBar:didSelectCollectionButton:)])
    {
        [self.delegate commentBar:self didSelectCollectionButton:sender];
    }
}

@end
