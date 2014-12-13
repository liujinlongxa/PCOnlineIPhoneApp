//
//  LJCommentPage.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentPage.h"

@implementation LJCommentPage

+ (instancetype)commentPageWithDict:(NSDictionary *)dict
{
    LJCommentPage * page = [[self alloc] init];
    [page setValuesForKeysWithDictionary:dict];
    return page;
}

@end
