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

@property (nonatomic, strong) NSArray * SubjectsData;
@property (nonatomic, strong) NSArray * BBSData;
@property (nonatomic, strong) NSArray * AreaData;

- (void)saveObjc:(id)object forKey:(NSString *)key;
- (id)loadObjcForKey:(NSString *)key;

@end
