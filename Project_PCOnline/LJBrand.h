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

+ (instancetype)brandWithDict:(NSDictionary *)dict;

@end
