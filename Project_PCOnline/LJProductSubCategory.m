//
//  LJProductBrand.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductSubCategory.h"

@implementation LJProductSubCategory

+ (instancetype)productSubCategoryWithDict:(NSDictionary *)dict
{
    LJProductSubCategory * subCategory = [[self alloc] init];
    [subCategory setValuesForKeysWithDictionary:dict];
    return subCategory;
}


@end
