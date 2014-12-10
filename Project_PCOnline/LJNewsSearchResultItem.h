//
//  LJNewsSearchResultItem.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJNewsSearchResultItem : NSObject

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * pubDate;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;

@property (nonatomic, copy) NSString * type;//文章种类

+ (instancetype)newsSearchResultItemWithDict:(NSDictionary *)dict;

@end
