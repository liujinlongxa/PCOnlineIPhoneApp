//
//  LJFastSubForumButton.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJFastSubForumButton.h"



@interface LJFastSubForumButton ()

@end

@implementation LJFastSubForumButton

+ (instancetype)fastSubForumButtonWithItem:(LJBBSListItem *)item
{
    LJFastSubForumButton * btn = [[LJFastSubForumButton alloc] initWithFrame:CGRectMake(0, 0, kBtnW, kBtnH)];
    btn.bbsListItem = item;
    NSString * imageName = [item.imageUrl substringFromIndex:[item.imageUrl rangeOfString:@"/"].location + 1];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:item.title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    return btn;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(5, 0, kBtnW - 10, kBtnW - 10);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, kBtnW + 5, kBtnW, kBtnH - kBtnW - 5);
}

@end
