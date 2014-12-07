//
//  LJProductBrand.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJProductSubCategory : NSObject

@property (nonatomic, copy) NSString * sid;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;

@property (nonatomic, strong) NSNumber * type;

+ (instancetype)productSubCategoryWithDict:(NSDictionary *)dict;


@end
