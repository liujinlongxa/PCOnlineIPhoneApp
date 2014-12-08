//
//  LJProductInformation.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJProductInformation : NSObject

@property (nonatomic, copy) NSString * channel;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * pubDate;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;

@property (nonatomic, strong) NSNumber * productId;

+ (instancetype)productInformationWithDict:(NSDictionary *)dict;

@end
