//
//  LJSubjectView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSubjectView.h"
#import "NSString+MyString.h"

#define kBtnWH 44
#define kShowBtnCount 5

@interface LJSubjectView()

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) UIButton * moreSubjectBtn;
//@property (nonatomic, weak) LJSelectButton * curSelecteButton;
@end

@implementation LJSubjectView
{
    UIButton * curSelectButton;
}

+ (instancetype)subjectView
{
    CGRect frame = CGRectMake(0, 0, kScrW, kNavBarH);
    LJSubjectView * subjectView = [[LJSubjectView alloc] initWithFrame:frame];
    [subjectView setupSubjectView];
    subjectView.backgroundColor = [UIColor whiteColor];
    return subjectView;
}

- (void)setupSubjectView
{
    //滚动区域
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScrW - kBtnWH - 1, kNavBarH - 1)];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //中间线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scrollView.frame), 0, 1, kNavBarH)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    //底部线
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), CGRectGetWidth(self.frame), 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
    
    //moreSubject Button
    UIButton * moreSubjectBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, kBtnWH, kBtnWH)];
    [self addSubview:moreSubjectBtn];
    self.moreSubjectBtn = moreSubjectBtn;
    [self.moreSubjectBtn setImage:[UIImage imageNamed:@"btn_to_subscribe"] forState:UIControlStateNormal];
}

- (void)setSubjects:(NSArray *)subjects
{
    CGFloat btnH = CGRectGetHeight(self.scrollView.frame);
    for (int i = 0; i < subjects.count; i++) {
        LJSubject * subject = subjects[i];
        //设置按钮，动态计算文字宽度
        CGFloat btnW = [subject.title sizeOfStringInIOS7WithFont:SubjectButtonFont andMaxSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame) * 0.5, CGRectGetHeight(self.scrollView.frame))].width;
        CGFloat btnX = CGRectGetMaxX([[self.scrollView.subviews lastObject] frame]);
        LJSelectButton * button = [LJSelectButton selectButtonWithFrame:CGRectMake(btnX, 0, btnW + 10, btnH) andTitle:subject.title];
        [button addTarget:self action:@selector(changeeSubject:) forControlEvents:UIControlEventTouchDown];
        button.subject = subject;
        button.tag = i;
        [self.scrollView addSubview:button];
    }
    curSelectButton = self.scrollView.subviews[0];//默认选中第一个头条Button
    curSelectButton.selected = YES;
    //设置滚动区域
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([[self.scrollView.subviews lastObject] frame]), 0);
}

- (void)changeeSubject:(LJSelectButton *)sender
{
    //设置选中
    curSelectButton.selected = NO;
    sender.selected = YES;
    curSelectButton = sender;
    //调用回调方法
    if ([self.delegate respondsToSelector:@selector(subjectView:didSelectButton:)]) {
        [self.delegate subjectView:self didSelectButton:sender];
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    LJSelectButton * btn = self.scrollView.subviews[selectIndex];
    curSelectButton.selected = NO;
    btn.selected = YES;
    curSelectButton = btn;
    //计算Button区域，将Button显示出来
    CGFloat btnOffsetX = btn.frame.origin.x;
    CGFloat scrollOffsetX = self.scrollView.contentOffset.x;
    CGFloat scrollW = CGRectGetWidth(self.scrollView.frame);
    CGFloat offset = scrollOffsetX - btnOffsetX;
    CGFloat retOffsetX = 0;
    if (offset > 0) {
        retOffsetX = btn.frame.origin.x;
        self.scrollView.contentOffset = CGPointMake(retOffsetX, 0);
    }
    else if(offset < -(scrollW - CGRectGetWidth(btn.frame)))
    {
        retOffsetX = btn.frame.origin.x - (scrollW - CGRectGetWidth(btn.frame));
        self.scrollView.contentOffset = CGPointMake(retOffsetX, 0);
    }
    
}

@end
