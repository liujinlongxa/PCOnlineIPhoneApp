//
//  NSString+MyString.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)

/**
 *  返回文字端的返回大小
 *
 *  @param font    字体
 *  @param maxSize 最大Size（限制再这之内）
 *
 *  @return 返回文字段大小
 */
- (CGSize)sizeOfStringInIOS7WithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;
{
    CGRect textRect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return textRect.size;
}

@end
