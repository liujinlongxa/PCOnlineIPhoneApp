//
//  LJAds.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJBaseAds.h"

//新闻广告模型
@interface LJAds : LJBaseAds

@property (nonatomic, copy) NSString * counter;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * pubDate;

+ (instancetype)adsWithDict:(NSDictionary *)dict;

@end
