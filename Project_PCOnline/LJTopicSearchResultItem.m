//
//  LJTopicSearchResultItem.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJTopicSearchResultItem.h"

@implementation LJTopicSearchResultItem

+ (instancetype)topicSearchResultItemWithDict:(NSDictionary *)dict
{
    LJTopicSearchResultItem * item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
