//
//  LJNews.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    InformateTypeNormal = 1,
    InformateTypeBBS = 2,
    InformateTypePhoto = 3,
} InformateType;

@interface LJNews : NSObject

@property (nonatomic, copy) NSString * bigImage;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * pubDate;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, strong) NSNumber * cmtCount;
@property (nonatomic, assign) InformateType informationType;

+ (instancetype)newsWithDict:(NSDictionary *)dict;

@end
