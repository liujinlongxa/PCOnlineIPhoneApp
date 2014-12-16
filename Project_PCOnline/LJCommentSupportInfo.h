//
//  LJCommentSupport.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LJCommentSupportTypeAgree = 1,
    LJCommentSupportTypeAgainst,
} LJCommentSupportType;

@interface LJCommentSupportInfo : NSObject

@property (nonatomic, strong) NSNumber * addAgainst;
@property (nonatomic, strong) NSNumber * addAgree;
@property (nonatomic, strong) NSNumber * addCollect;
@property (nonatomic, strong) NSNumber * againstCount;
@property (nonatomic, strong) NSNumber * agreeCount;
@property (nonatomic, strong) NSNumber * articleId;
@property (nonatomic, strong) NSNumber * collectionCount;
@property (nonatomic, strong) NSNumber * createTime;
@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, strong) NSNumber * siteId;

+ (instancetype)commentSupportWithDict:(NSDictionary *)dict;

@end
