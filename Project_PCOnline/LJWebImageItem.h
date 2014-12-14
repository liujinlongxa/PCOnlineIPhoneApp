//
//  LJWebImageItem.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJWebImageItem : NSObject

@property (nonatomic, copy) NSString * bigPath;
@property (nonatomic, copy) NSString * smallPath;

+ (instancetype)webImageItemWithDict:(NSDictionary *)dict;

@end
