//
//  LJFastForumButton.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJFastForumButton.h"

@implementation LJFastForumButton

+ (instancetype)fastForumButtonWithImage:(NSString *)imageName
{
    LJFastForumButton * btn = [LJFastForumButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}

@end
