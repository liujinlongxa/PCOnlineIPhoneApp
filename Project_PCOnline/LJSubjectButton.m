//
//  LJSubjectButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSubjectButton.h"

@implementation LJSubjectButton

+ (instancetype)subjectButtonWithFrame:(CGRect)frame andTitle:(NSString *)title;
{
    LJSubjectButton * button = [[self alloc] initWithFrame:frame];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:BlueTextColor forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

@end
