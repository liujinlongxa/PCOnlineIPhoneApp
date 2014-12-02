//
//  LJBBSAds.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//  论坛广场广告栏

#import "LJBBSAds.h"

@implementation LJBBSAds
@synthesize url = _url;

+ (instancetype)BBSAdsWithDict:(NSDictionary *)dict
{
    LJBBSAds * ads = [[self alloc] init];
    [ads setValuesForKeysWithDictionary:dict];
    return ads;
}

- (NSString *)url
{
    if (!_url) {
        
    }
    return _url;
}

@end
