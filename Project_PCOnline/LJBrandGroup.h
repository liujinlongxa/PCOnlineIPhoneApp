//
//  LJBrandGroup.h
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBrandGroup : NSObject

@property (nonatomic, strong) NSArray * brands;
@property (nonatomic, copy) NSString * index;
@property (nonatomic, strong) NSNumber * rowNum;

+ (instancetype)brandGroupWithDict:(NSDictionary *)dict;

@end
