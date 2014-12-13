//
//  LJWebImages.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJWebImages.h"

@implementation LJWebImages

+ (instancetype)webImages:(NSDictionary *)dict
{
    LJWebImages * images = [[self alloc] init];
    [images setValuesForKeysWithDictionary:dict];
    return  images;
}

@end
