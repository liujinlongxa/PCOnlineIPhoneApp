//
//  LJComment.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJComment.h"

@implementation LJComment

+ (instancetype)commentWithDict:(NSDictionary *)dict
{
    LJComment * comment = [[self alloc] init];
    comment.current = dict[@"current"];
    comment.expand = [dict[@"expand"] boolValue];
    comment.support = dict[@"support"];
    
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < comment.current.integerValue; i++) {
        NSString * index = [NSString stringWithFormat:@"%d", i + 1];
        NSDictionary * itemDict = dict[index];
        LJCommentItem * item = [LJCommentItem commentItemWithDict:itemDict];
        if (i == comment.current.integerValue - 1) {
            comment.myCommentItem = item;
        }
        else
        {
            [arr addObject:item];
            item.level = comment.current.integerValue - i - 1;
        }
    }
    comment.replyCommentItems = [arr copy];
    return comment;
}

@end
