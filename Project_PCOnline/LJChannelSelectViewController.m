//
//  LJChannelSelectViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJChannelSelectViewController.h"
#import "LJCommonHeader.h"
#import "LJChannelItemBtn.h"
#import "LJCommonData.h"



@interface LJChannelSelectViewController ()

@property (nonatomic, strong) NSMutableArray * showChannelSubjects;
@property (nonatomic, strong) NSMutableArray * hideChannelSubjects;

@end

@implementation LJChannelSelectViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self setupShowChannelView];
        [self setupHideChannelView];
    }
    return self;
}

#pragma mark - init UI
- (void)setupShowChannelView
{
    self.showChannelSubjects = [[LJCommonData shareCommonData].curShowSubjectsData mutableCopy];
    NSMutableArray * showChannelBtns = [NSMutableArray array];
    for (int i = 0; i < self.showChannelSubjects.count; i++) {
        LJChannelItemBtn * btn = [[LJChannelItemBtn alloc] initWithFrame:CGRectZero andSubject:self.showChannelSubjects[i]];
        btn.show = YES;
        [btn addTarget:self action:@selector(channelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [showChannelBtns addObject:btn];
    }
    
    [[showChannelBtns firstObject] setEnabled:NO];
    LJChannelItemBtnsView * showBtnsView = [[LJChannelItemBtnsView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andButttons:showChannelBtns andTitles:nil];
    showBtnsView.canDragToMove = YES;
    [self.view addSubview:showBtnsView];
    self.showChannelView = showBtnsView;
}

- (void)setupHideChannelView
{
    self.hideChannelSubjects = [[LJCommonData shareCommonData].curHideSubjectsData mutableCopy];
    NSMutableArray * hideChannelBtns = [NSMutableArray array];
    for (int i = 0; i < self.hideChannelSubjects.count; i++) {
        LJChannelItemBtn * btn = [[LJChannelItemBtn alloc] initWithFrame:CGRectZero andSubject:self.hideChannelSubjects[i]];
        btn.show = NO;
        [btn addTarget:self action:@selector(channelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [hideChannelBtns addObject:btn];
    }
    
    LJChannelItemBtnsView * hideBtnsView = [[LJChannelItemBtnsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.showChannelView.frame), 0, 0) andButttons:hideChannelBtns andTitles:@"   更多栏目，点击标签进行添加"];
    [self.view addSubview:hideBtnsView];
    self.hideChannelView = hideBtnsView;
    self.hideChannelView.backgroundColor = LightGrayBGColor;
}

#pragma mark - channel btn click
- (void)channelBtnClick:(LJChannelItemBtn *)sender
{
    if (sender.isShow) {
        sender.show = NO;
        [self.showChannelView removeButton:sender];
        [self.hideChannelView addButton:sender];
        [self.showChannelSubjects removeObject:sender.subject];
        [self.hideChannelSubjects addObject:sender.subject];
    }
    else
    {
        sender.show = YES;
        [self.hideChannelView removeButton:sender];
        [self.showChannelView addButton:sender];
        [self.showChannelSubjects addObject:sender.subject];
        [self.hideChannelSubjects removeObject:sender.subject];
    }
    [self updateShowBtnViewFrame];
    [self updateHideBtnViewFrame];
    [self updateViewFrame];
}

- (void)updateViewFrame
{
    if ([self.delegate respondsToSelector:@selector(channelSelectViewControllerShowViewFrame:)]) {
        [self.delegate channelSelectViewControllerShowViewFrame:self];
    }
}

- (void)updateShowBtnViewFrame
{
    NSInteger lineNum = ceil(self.showChannelView.buttons.count / kCountOfBtnInOneLine);
    
    CGFloat padding = 10;
    CGFloat bottomH = kBottomBlankH;
    CGFloat btnH = CGRectGetHeight([[self.showChannelView.buttons firstObject] frame]);
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = kScrW;
    CGFloat viewH = CGRectGetHeight(self.showChannelView.titleLabel.frame) + padding + lineNum * (btnH + padding) + bottomH;
    [UIView animateWithDuration:0.5 animations:^{
        self.showChannelView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }];
    
}

- (void)updateHideBtnViewFrame
{
    NSInteger lineNum = ceil(self.hideChannelView.buttons.count / kCountOfBtnInOneLine);
    
    CGFloat padding = 10;
    CGFloat bottomH = kBottomBlankH;
    CGFloat btnH = CGRectGetHeight([[self.hideChannelView.buttons firstObject] frame]);
    CGFloat viewX = 0;
    CGFloat viewY = CGRectGetMaxY(self.showChannelView.frame);
    CGFloat viewW = kScrW;
    CGFloat viewH = CGRectGetHeight(self.hideChannelView.titleLabel.frame) + padding + lineNum * (btnH + padding) + bottomH;
    [UIView animateWithDuration:0.5 animations:^{
        self.hideChannelView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }];
    
}

//数据保存
- (void)saveChannelList
{
    NSMutableArray * showSubjectArr = [NSMutableArray array];
    for (LJChannelItemBtn * btn in self.showChannelView.buttons) {
        [showSubjectArr addObject:btn.subject];
    }
    
    NSMutableArray * hideSubjectArr = [NSMutableArray array];
    for (LJChannelItemBtn * btn in self.hideChannelView.buttons) {
        [hideSubjectArr addObject:btn.subject];
    }
    [LJCommonData shareCommonData].curShowSubjectsData = [showSubjectArr copy];
    [LJCommonData shareCommonData].curHideSubjectsData = [hideSubjectArr copy];
}

@end
