//
//  LJAds.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJAds : NSObject

@property (nonatomic, copy) NSString * counter;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * pubDate;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;

+ (instancetype)adsWithDict:(NSDictionary *)dict;





@end
