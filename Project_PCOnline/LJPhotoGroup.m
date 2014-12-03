//
//  LJPhotoGroup.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPhotoGroup.h"

@implementation LJPhotoGroup

+ (instancetype)photoGroupWithDict:(NSDictionary *)dict
{
    LJPhotoGroup * group = [[self alloc] init];
    group.ID = dict[@"id"];
    group.cover = dict[@"cover"];
    group.name = dict[@"name"];
    group.photoCount = dict[@"photoCount"];
    group.url = dict[@"url"];
    return group;
}

@end
