//
//  LJPhotoGroup.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJPhotoGroup : NSObject

@property (nonatomic, copy) NSString * cover;
@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSNumber * photoCount;
@property (nonatomic, copy) NSString * url;

+ (instancetype)photoGroupWithDict:(NSDictionary *)dict;

@end
