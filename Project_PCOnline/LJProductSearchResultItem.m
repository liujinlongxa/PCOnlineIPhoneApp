//
//  LJProductSearchResultItem.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductSearchResultItem.h"

@implementation LJProductSearchResultItem

+ (instancetype)productSearchResultItemWithDict:(NSDictionary *)dict
{
    LJProductSearchResultItem * item = [[self alloc] init];
    item.ID = dict[@"id"];
    item.price = dict[@"price"];
    item.pic = dict[@"pic"];
    item.summary = dict[@"summary"];
    item.title = dict[@"title"];
    
    return item;
    
}

@end
