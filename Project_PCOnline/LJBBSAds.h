//
//  LJBBSAds.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJBaseAds.h"

@interface LJBBSAds : LJBaseAds

@property (nonatomic, copy) NSString * from;
@property (nonatomic, copy) NSString * topicId;

+ (instancetype)BBSAdsWithDict:(NSDictionary *)dict;

@end
