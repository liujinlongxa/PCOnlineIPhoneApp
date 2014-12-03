//
//  LJPhoto.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJPhoto : NSObject

@property (nonatomic, copy) NSString * desc;
@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * thumb;
@property (nonatomic, copy) NSString * tumbUrl;
@property (nonatomic, copy) NSString * url;

+ (instancetype)photoWithDict:(NSDictionary *)dict;

@end
