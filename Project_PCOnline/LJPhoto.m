//
//  LJPhoto.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPhoto.h"

@implementation LJPhoto

+ (instancetype)photoWithDict:(NSDictionary *)dict
{
    LJPhoto * photo = [[self alloc] init];
    photo.desc = dict[@"desc"];
    photo.ID = dict[@"id"];
    photo.name = dict[@"name"];
    photo.thumb = dict[@"thumb"];
    photo.tumbUrl = dict[@"thumbUrl"];
    photo.url = dict[@"url"];
    return photo;
}

@end
