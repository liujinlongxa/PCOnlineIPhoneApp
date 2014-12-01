//
//  LJCommonData.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJUrlHeader.h"

@interface LJCommonData : NSObject

+ (instancetype)shareCommonData;

@property (nonatomic, strong) NSDictionary * SubjectsData;
@property (nonatomic, strong) NSDictionary * BBSData;
@property (nonatomic, strong) NSDictionary * AreaData;

@end
