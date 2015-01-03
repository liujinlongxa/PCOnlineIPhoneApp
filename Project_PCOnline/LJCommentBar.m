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
#import "LJCollectionButton.h"

@interface LJCommentBar ()

/**
 *  评论输入TextField
 */
@property (nonatomic, weak) UITextField * textField;

/**
 *  分页Button
 */
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
        
        //middle button
        UIButton * middleBtn = [[UIButton alloc] init];
        //默认是收藏
        [middleBtn addTarget:self action:@selector(middleButtonClck:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:middleBtn];
        self.middleButton = middleBtn;
        
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
    
    //middle button
    CGFloat middleX = CGRectGetMaxX(self.textField.frame);
    CGFloat middleW = 40;
    CGFloat middleH = 40;
    CGFloat middleY = (kBarH - middleH) / 2;
    self.middleButton.frame = CGRectMake(middleX, middleY, middleW, middleH);
    
    //page button
    CGFloat pageX = CGRectGetMaxX(self.middleButton.frame);
    CGFloat pageW = 80;
    CGFloat pageH = 40;
    CGFloat pageY = (kBarH - pageH) / 2;
    self.pageButton.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
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
- (void)middleButtonClck:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(commentBar:didSelectMidButton:)])
    {
        [self.delegate commentBar:self didSelectMidButton:sender];
    }
}

#pragma mark - setup middle button type
- (void)setCommentBarBtnType:(LJCommentBarButtonType)commentBarBtnType
{
    _commentBarBtnType = commentBarBtnType;
    
    switch (commentBarBtnType) {
        case LJCommentBarButtonTypeRefresh:
        {
            [self.middleButton setImage:[UIImage imageNamed:@"common_fullscreen_refresh"] forState:UIControlStateNormal];
            break;
        }
        case LJCommentBarButtonTypeCollection:
        {
//            [self.middleButton setImage:[UIImage imageNamed:@"btn_common_toolbar_collect"] forState:UIControlStateNormal];
//            [self.middleButton setImage:[UIImage imageNamed:@"btn_common_toolbar_collected"] forState:UIControlStateSelected];
            
            //删除原有的Button，使用LJCollectionButton
            [self.middleButton removeFromSuperview];
            LJCollectionButton * collectionBtn = [[LJCollectionButton alloc] init];
            [self addSubview:collectionBtn];
            self.middleButton = collectionBtn;
            [self.middleButton addTarget:self action:@selector(middleButtonClck:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        default:
            NSAssert(NO, @"type error");
            break;
    }
}

@end
