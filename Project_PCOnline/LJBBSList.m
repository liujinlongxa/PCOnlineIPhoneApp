//
//  LJBBSList.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSList.h"

@implementation LJBBSList

+ (instancetype)bbsListWithDict:(NSDictionary *)dict
{
    LJBBSList * list = [[self alloc] init];
    [list setValuesForKeysWithDictionary:dict];
    LJBBSListItem * item = [LJBBSListItem bbsListItemWithArr:list.me];
    list.listItem = item;
    if (list.children != nil && list.children.count != 0) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * subDict in list.children) {
            LJBBSList * subList = [LJBBSList bbsListWithDict:subDict];
            [arr addObject:subList];
        }
        list.children = [arr copy];
    }
    return list;
}

- (NSString *)subItemIDStr
{
    if (!_subItemIDStr)
    {
        NSMutableArray * strArr = [NSMutableArray array];
        for (LJBBSList * list in self.children) {
            [strArr addObject:[NSString stringWithFormat:@"%d", list.listItem.ID.integerValue]];
        }
        _subItemIDStr = [strArr componentsJoinedByString:@","];
    }
    return _subItemIDStr;
}

@end
