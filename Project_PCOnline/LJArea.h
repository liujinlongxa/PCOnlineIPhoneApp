//
//  LJArea.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//地区模型
@interface LJArea : NSObject
@property (nonatomic, copy) NSString * index;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * ID;

+ (instancetype)subjectWithArray:(NSArray *)arr;

@end
