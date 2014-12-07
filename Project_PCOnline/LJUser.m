//
//  LJUser.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJUser.h"
#import "LJCommonHeader.h"
@implementation LJUser

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    LJUser * user = [[self alloc] init];
    [user setValuesForKeysWithDictionary:dict];
    return user;
}

@end
