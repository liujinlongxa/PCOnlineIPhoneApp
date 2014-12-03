//
//  LJProjectCategory.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJProductCategory : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * hightlight_image;
@property (nonatomic, strong) NSArray * childs;
@property (nonatomic, strong) NSArray * subCategoryName;

+ (instancetype)productCategoryWithDict:(NSDictionary *)dict;

@end
