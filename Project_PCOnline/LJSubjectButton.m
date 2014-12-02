//
//  LJSubjectButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSubjectButton.h"

@interface LJSubjectButton ()

@property (nonatomic, weak) UIView * blueView;

@end

@implementation LJSubjectButton

+ (instancetype)subjectButtonWithFrame:(CGRect)frame andTitle:(NSString *)title;
{
    LJSubjectButton * button = [[self alloc] initWithFrame:frame];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:BlueTextColor forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //创建蓝色view
    CGFloat viewX = 0;
    CGFloat viewH = 3;
    CGFloat viewY = CGRectGetHeight(frame) - viewH;
    CGFloat viewW = CGRectGetWidth(frame);
    UIView * blueView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    blueView.backgroundColor = BlueTextColor;
    blueView.hidden = YES;
    [button addSubview:blueView];
    button.blueView = blueView;
    
    return button;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.blueView.hidden = !selected;
}

@end
