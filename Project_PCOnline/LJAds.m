//
//  LJAds.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJAds.h"

@implementation LJAds

+ (instancetype)adsWithDict:(NSDictionary *)dict
{
    LJAds * ad = [[self alloc] init];
    ad.ID = dict[@"id"];
    ad.counter = dict[@"counter"];
    ad.image = dict[@"image"];
    ad.pubDate = dict[@"pubDate"];
    ad.title = dict[@"title"];
    ad.url = dict[@"url"];
    return ad;
}

@end
