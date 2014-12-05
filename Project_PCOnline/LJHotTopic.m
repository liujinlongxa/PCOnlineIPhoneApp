//
//  LJHotTopic.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotTopic.h"

@implementation LJHotTopic

+ (instancetype)hotTopicWithDict:(NSDictionary *)dict
{
    LJHotTopic * topic = [[self alloc] init];
    [topic setValuesForKeysWithDictionary:dict];
    return topic;
}

- (BOOL)isShowImage
{
    return ((self.image != nil) && ![self.image isEqualToString:@""]);
}

@end
