//
//  LJProductFilterItem.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductFilterItem.h"

@implementation LJProductFilterItem

+ (instancetype)productFilterItemWithDict:(NSDictionary *)dict
{
    LJProductFilterItem * item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    item.selected = NO;
    return item;
}

@end
