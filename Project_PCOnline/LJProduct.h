//
//  LJProduct.h
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJProduct : NSObject

@property (nonatomic, strong) NSNumber * hotNew;
@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, copy) NSString * idxPic;
@property (nonatomic, strong) NSNumber * is_ultrabook;
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, copy) NSString * noPriceMsg;
@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, copy) NSString * shortName;
@property (nonatomic, copy) NSString * url;

@property (nonatomic, strong) NSNumber * type;

+ (instancetype)productWithDict:(NSDictionary *)dict;
+ (instancetype)productWithID:(NSNumber *)ID;
@end
