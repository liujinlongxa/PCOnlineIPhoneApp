//
//  LJTopic.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJBaseTopic.h"
#import "LJUser.h"

@interface LJTopic : LJBaseTopic

@property (nonatomic, strong) LJUser * author;
@property (nonatomic, strong) LJUser * lastPoster;
@property (nonatomic, copy) NSString * uri;
@property (nonatomic, strong) NSNumber * view;
@property (nonatomic, strong) NSNumber * createAt;
@property (nonatomic, strong) NSString * flag;
@property (nonatomic, assign, getter=isEssence) BOOL essence;//是否是精华

//最数码
@property (nonatomic, strong) NSArray * imgUrls;
@property (nonatomic, assign) BOOL isContainImage;
@property (nonatomic, assign) BOOL isPick;

+ (instancetype)topciWithDict:(NSDictionary *)dict;

@property (nonatomic, copy) NSString * createAtStr;

@end
