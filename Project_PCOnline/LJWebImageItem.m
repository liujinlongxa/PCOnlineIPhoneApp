//
//  LJWebImageItem.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJWebImageItem.h"

@implementation LJWebImageItem

+ (instancetype)webImageItemWithDict:(NSDictionary *)dict
{
    LJWebImageItem * item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
