//
//  LJWebImages.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJWebImages : NSObject

@property (nonatomic, copy) NSString * total;
@property (nonatomic, copy) NSString * currentIndex;
@property (nonatomic, strong) NSArray * photos;

+ (instancetype)webImages:(NSDictionary *)dict;

@end
