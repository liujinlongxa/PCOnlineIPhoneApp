//
//  LJProduct.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProduct.h"

@implementation LJProduct

+ (instancetype)productWithDict:(NSDictionary *)dict
{
    LJProduct * product = [[self alloc] init];
    product.hotNew = dict[@"hotNew"];
    product.ID = dict[@"id"];
    product.idxPic = dict[@"idxPic"];
    product.is_ultrabook = dict[@"is-ultrabook"];
    product.items = dict[@"items"];
    product.noPriceMsg = dict[@"noPriceMsg"];
    product.price = dict[@"price"];
    product.shortName = dict[@"shortName"];
    product.url = dict[@"url"];
    return product;
}

+ (instancetype)productWithID:(NSNumber *)ID
{
    LJProduct * product = [[self alloc] init];
    product.ID = ID;
    return product;
}

@end
