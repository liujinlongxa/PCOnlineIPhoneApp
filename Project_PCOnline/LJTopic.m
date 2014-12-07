//
//  LJTopic.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJTopic.h"
#import "LJUser.h"
#import "NSDate+MyDate.h"
#import "LJCommonHeader.h"

@implementation LJTopic

+ (instancetype)topciWithDict:(NSDictionary *)dict
{
    LJTopic * topic = [[self alloc] init];
    [topic setValuesForKeysWithDictionary:dict];
    
    LJUser * author = [LJUser userWithDict:(NSDictionary *)topic.author];
    topic.author = author;
    LJUser * lastPoster = [LJUser userWithDict:(NSDictionary *)topic.lastPoster];
    topic.lastPoster = lastPoster;
    return topic;
}

- (NSString *)createAtStr
{
    NSDate * dateCreateAt = [NSDate dateWithTimeIntervalSince1970:self.createAt.longLongValue];
    if (self.lastPoster.lastPostAt != nil)
    {
        return self.lastPoster.lastPostAt;
    }
    return [dateCreateAt dateStringToNow];
}

- (BOOL)isEssence
{
    if ([self.flag isEqualToString:@"精"])
    {
        return YES;
    }
    return NO;
}

@end
