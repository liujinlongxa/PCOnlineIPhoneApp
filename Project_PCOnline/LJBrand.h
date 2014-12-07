//
//  LJBrand.h
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBrand : NSObject

@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, copy) NSString * logo;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSNumber * type;//type，请求具体品牌产品列表时要用到
@property (nonatomic, copy) NSString * index;

+ (instancetype)brandWithDict:(NSDictionary *)dict;

@end
