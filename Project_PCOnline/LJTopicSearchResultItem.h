//
//  LJTopicSearchResultItem.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJTopicSearchResultItem : NSObject

@property (nonatomic, copy) NSString * access;
@property (nonatomic, copy) NSString * authorId;
@property (nonatomic, strong) NSNumber * createAt;
@property (nonatomic, copy) NSString * flag;
@property (nonatomic, strong) NSNumber * forumId;
@property (nonatomic, copy) NSString * replycount;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSNumber * topicId;
@property (nonatomic, copy) NSString * userName;

+ (instancetype)topicSearchResultItemWithDict:(NSDictionary *)dict;

@end
