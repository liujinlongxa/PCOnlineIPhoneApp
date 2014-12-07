//
//  LJBrandGroup.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBrandGroup.h"
#import "LJBrand.h"

@implementation LJBrandGroup

+ (instancetype)brandGroupWithDict:(NSDictionary *)dict
{
    LJBrandGroup * group = [[self alloc] init];
    [group setValuesForKeysWithDictionary:dict];
    
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * brandDict in group.brands) {
        LJBrand * brand = [LJBrand brandWithDict:brandDict];
        brand.index = group.index;
        [arr addObject:brand];
    }
    group.brands = [arr copy];
    return group;
}

- (void)setType:(NSNumber *)type
{
    for (LJBrand * brand in self.brands) {
        brand.type = type;
    }
    _type = type;
}

@end
