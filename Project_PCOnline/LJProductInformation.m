//
//  LJProductInformation.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductInformation.h"

@implementation LJProductInformation

+ (instancetype)productInformationWithDict:(NSDictionary *)dict
{
    LJProductInformation * information = [[self alloc] init];
    information.channel = dict[@"channel"];
    information.ID = dict[@"id"];
    information.image = dict[@"image"];
    information.pubDate = dict[@"pubDate"];
    information.title = dict[@"title"];
    information.url = dict[@"url"];
    return information;
}

@end
