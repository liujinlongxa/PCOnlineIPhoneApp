//
//  LJCommentItem.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentItem.h"

@implementation LJCommentItem

+ (instancetype)commentItemWithDict:(NSDictionary *)dict
{
    LJCommentItem * item = [[self alloc] init];
    item.client = dict[@"client"];
    item.content = dict[@"content"];
    item.floor = dict[@"floor"];
    item.ID = dict[@"id"];
    item.name = dict[@"name"];
    item.time = dict[@"time"];
    item.userId = dict[@"userId"];
    return item;
}

@end
