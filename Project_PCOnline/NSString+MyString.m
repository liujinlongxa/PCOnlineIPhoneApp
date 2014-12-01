//
//  NSString+MyString.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)

- (CGSize)sizeOfStringInIOS7WithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;
{
    CGRect textRect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return textRect.size;
}

@end
