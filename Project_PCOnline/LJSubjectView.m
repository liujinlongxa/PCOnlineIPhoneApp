//
//  LJSubjectView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSubjectView.h"

#define kBtnWH 44

@interface LJSubjectView()

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) UIButton * moreSubjectBtn;

@end

@implementation LJSubjectView

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
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScrW - kBtnWH - 1, kNavBarH)];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    //中间线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scrollView.frame), 0, 1, kNavBarH)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    
    //moreSubject Button
    UIButton * moreSubjectBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, kBtnWH, kBtnWH)];
    [self addSubview:moreSubjectBtn];
    self.moreSubjectBtn = moreSubjectBtn;
    [self.moreSubjectBtn setImage:[UIImage imageNamed:@"btn_to_subscribe"] forState:UIControlStateNormal];
}

@end
