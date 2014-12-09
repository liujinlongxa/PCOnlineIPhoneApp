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

//用于查询
@property (nonatomic, strong) NSArray * filterGroups;
@property (nonatomic, strong) NSString * queryJson;

+ (instancetype)productSubCategoryWithDict:(NSDictionary *)dict;


@end
