//
//  LJBrand.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBrand.h"

@implementation LJBrand

+(instancetype)brandWithDict:(NSDictionary *)dict
{
    LJBrand * brand = [[self alloc] init];
    brand.ID = dict[@"id"];
    brand.logo = dict[@"logo"];
    brand.name = dict[@"name"];
    return brand;
}

@end
