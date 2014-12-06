//
//  LJUser.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJUser : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, strong) NSNumber * userId;
//最数码
@property (nonatomic, copy) NSString * userFace;
@property (nonatomic, copy) NSString * lastPostAt;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
