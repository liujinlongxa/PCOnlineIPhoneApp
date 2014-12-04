//
//  LJProjectCategory.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductCategory.h"
#import "LJProductSubCategory.h"

@implementation LJProductCategory

+ (instancetype)productCategoryWithDict:(NSDictionary *)dict
{
    LJProductCategory * category = [[self alloc] init];
    category.title = dict[@"title"];
    category.image = dict[@"image"];
    category.hightlight_image = dict[@"hightlight-image"];
    category.childs = dict[@"childs"];
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * subCategoryDict in category.childs) {
        LJProductSubCategory * subCategory = [LJProductSubCategory productSubCategoryWithDict:subCategoryDict];
        [arr addObject:subCategory];
    }
    category.childs = [arr copy];
    return category;
}

@end
