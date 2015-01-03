//
//  LJTopicDaoModel.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/3.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//  专为帖子的数据持久化创建的模型

#import <Foundation/Foundation.h>

@interface LJTopicDaoModel : NSObject

/**
 *  帖子ID
 */
@property (nonatomic, strong) NSNumber * topicId;

/**
 *  帖子标题
 */
@property (nonatomic, copy) NSString * title;

/**
 *  Url,用于区分最数码还是普通bbs
 */
@property (nonatomic, copy) NSString * baseUrl;

//- (instancetype)initTopicDaoModelWithTopicID:(NSNumber *)topicID andTitle:(NSString *)title andBaseUr:(NSString *)baseUrl;
//- (instancetype)initTopicDaoModelWithTopicID:(NSNumber *)topicID andTitle:(NSString *)title;
@end
