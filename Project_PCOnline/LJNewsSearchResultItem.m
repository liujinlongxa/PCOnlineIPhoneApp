//
//  LJNewsSearchResultItem.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsSearchResultItem.h"

@implementation LJNewsSearchResultItem

+ (instancetype)newsSearchResultItemWithDict:(NSDictionary *)dict
{
    LJNewsSearchResultItem * item = [[self alloc] init];
    item.ID = dict[@"id"];
    item.pubDate = dict[@"pubDate"];
    item.url = dict[@"url"];
    item.title = dict[@"title"];
//    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
