//
//  LJHotTopic.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJHotTopic : NSObject

@property (nonatomic, copy) NSString * createAt;
@property (nonatomic, strong) NSNumber * floor;
@property (nonatomic, strong) NSNumber * forumId;
@property (nonatomic, copy) NSString * forumName;
@property (nonatomic, copy) NSString * forumUrl;
@property (nonatomic, copy) NSString * lastPostAt;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, strong) NSNumber * replyCount;
@property (nonatomic, strong) NSNumber * rewardAmount;
@property (nonatomic, strong) NSNumber * rewardRemain;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSNumber * topicId;
@property (nonatomic, copy) NSString * topicUrl;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, strong) NSNumber * userId;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * userUrl;
@property (nonatomic, strong) NSNumber * viewCount;

+ (instancetype)hotTopicWithDict:(NSDictionary *)dict;



@end