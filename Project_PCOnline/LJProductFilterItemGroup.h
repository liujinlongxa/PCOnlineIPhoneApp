//
//  LJProductFilterItemGroup.h
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJProductFilterItemGroup : NSObject

@property (nonatomic, strong) NSArray * cris;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * value;

+ (instancetype)productFilterItemGroupWithDict:(NSDictionary *)dict;
@property (nonatomic, assign) NSInteger selectCount;
@end
