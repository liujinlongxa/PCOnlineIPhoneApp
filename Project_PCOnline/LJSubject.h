//
//  LJSubject.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//  频道模型

#import <Foundation/Foundation.h>
#import "LJUrlHeader.h"

//频道模型
@interface LJSubject : NSObject

@property (nonatomic, copy) NSString * index;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * ID;

+ (instancetype)subjectWithArray:(NSArray *)arr;
+ (instancetype)subjectWithDict:(NSDictionary *)dict;
@end
