//
//  LJCommentInfo.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentInfo.h"

@implementation LJCommentInfo

+ (instancetype)commentInfoWithDict:(NSDictionary *)dict
{
    LJCommentInfo * commentInfo = [[self alloc] init];
    commentInfo.floor = dict[@"floor"];
    commentInfo.ID = dict[@"id"];
    commentInfo.total = dict[@"total"];
    commentInfo.turl = dict[@"turl"];
    commentInfo.url = dict[@"url"];
    commentInfo.url43g = dict[@"url43g"];
    
    return commentInfo;
}

@end
