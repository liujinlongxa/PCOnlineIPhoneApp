//
//  LJPullingBar.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPullingBar.h"
#import "LJCommonHeader.h"
#import "LJPullBarButton.h"

#define BtnAreaH 60

@interface LJPullingBar ()

@property (nonatomic, weak) UIButton * pullBtn;
@property (nonatomic, strong) NSMutableArray * buttons;
@property (nonatomic, weak) LJPullBarButton * curSelectBtn;

@end


@implementation LJPullingBar

- (instancetype)initPullingBarWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    CGFloat btnH = BtnAreaH;
    CGFloat padding = 10;
    CGRect newFrame = frame;
    newFrame.origin.y -= btnH;
    newFrame.size.height += btnH;
    if (self = [super initWithFrame:newFrame]) {
        //button
        CGFloat btnW = (kScrW - (titles.count + 1) * padding) / titles.count;
        UIView * btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrW, btnH)];
        for (int i = 0; i < titles.count; i++) {
            LJPullBarButton * btn = [[LJPullBarButton alloc] initWithFrame:CGRectMake(padding + i * (padding + btnW), padding, btnW, btnH - 2 * padding)];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(pullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnView addSubview:btn];
            [self.buttons addObject:btn];
        }
        btnView.backgroundColor = LightGrayBGColor;
        [[self.buttons firstObject] setSelected:YES];//默认选中第一个
        self.curSelectBtn = [self.buttons firstObject];
        [self addSubview:btnView];
        
        //image
        CGFloat imageH = 30;
        UIImageView * pullImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, btnH, kScrW, imageH)];
        pullImage.image = [UIImage imageNamed:@"bg_pulling_bar"];
        [self addSubview:pullImage];
        pullImage.userInteractionEnabled = YES;
        
        //pull btn
        CGFloat pullBtnW = 60;
        UIButton * pullBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, pullBtnW, imageH)];
        [pullBtn setTitle:[titles firstObject] forState:UIControlStateNormal];
        [pullBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        pullBtn.center = CGPointMake(kScrW / 2, imageH / 2);
        pullBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [pullBtn addTarget:self action:@selector(pullLittleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [pullImage addSubview:pullBtn];
        self.pullBtn = pullBtn;
    }
    return self;
}

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)pullBtnClick:(LJPullBarButton *)sender
{
    
    if(sender == self.curSelectBtn) return;
    sender.selected = YES;
    self.curSelectBtn.selected = NO;
    self.curSelectBtn = sender;
    [self.pullBtn setTitle:self.curSelectBtn.currentTitle forState:UIControlStateNormal];
    [self pullLittleBtnClick:self.pullBtn];
}

- (void)pullLittleBtnClick:(UIButton *)sender
{
    CGRect viewF = self.frame;
    if (viewF.origin.y < 0) {
        viewF.origin.y = 0;
    }
    else
    {
        viewF.origin.y = -BtnAreaH;
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = viewF;
    }];
}

@end
