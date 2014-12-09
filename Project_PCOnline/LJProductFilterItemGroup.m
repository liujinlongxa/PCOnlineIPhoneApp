//
//  LJProductFilterItemGroup.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductFilterItemGroup.h"
#import "LJProductFilterItem.h"

@implementation LJProductFilterItemGroup

+ (instancetype)productFilterItemGroupWithDict:(NSDictionary *)dict
{
    LJProductFilterItemGroup * group = [[self alloc] init];
    [group setValuesForKeysWithDictionary:dict];
    group.selectCount = 0;
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * itemDict in group.cris) {
        LJProductFilterItem * item = [LJProductFilterItem productFilterItemWithDict:itemDict];
        [arr addObject:item];
    }
    group.cris = arr;
    return group;
}

@end
