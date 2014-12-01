//
//  LJNews.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNews.h"

@implementation LJNews

+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    LJNews * news = [[self alloc] init];
    news.bigImage = dict[@"bigImage"];
    news.ID = dict[@"id"];
    news.image = dict[@"image"];
    news.pubDate = dict[@"pubDate"];
    news.title = dict[@"title"];
    news.url = dict[@"url"];
    news.cmtCount = dict[@"cmtCount"];
    news.informationType = [dict[@"informationType"] integerValue];
    return news;
}

@end
