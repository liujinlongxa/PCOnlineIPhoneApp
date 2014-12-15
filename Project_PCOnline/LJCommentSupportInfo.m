//
//  LJCommentSupport.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentSupportInfo.h"

@implementation LJCommentSupportInfo

/*
 @property (nonatomic, strong) NSNumber * addAgainst;
 @property (nonatomic, strong) NSNumber * addAgree;
 @property (nonatomic, strong) NSNumber * addCollect;
 @property (nonatomic, strong) NSNumber * againstCount;
 @property (nonatomic, strong) NSNumber * articleId;
 @property (nonatomic, strong) NSNumber * collectionCount;
 @property (nonatomic, strong) NSNumber * createTime;
 @property (nonatomic, strong) NSNumber * ID;
 @property (nonatomic, strong) NSNumber * siteId;
 */

+ (instancetype)commentSupportWithDict:(NSDictionary *)dict
{
    LJCommentSupportInfo * comment = [[self alloc] init];
    comment.addAgainst = dict[@"addAgainst"];
    comment.addAgree = dict[@"addAgree"];
    comment.addCollect = dict[@"addCollect"];
    comment.againstCount = dict[@"againstCount"];
    comment.articleId = dict[@"articleId"];
    comment.collectionCount = dict[@"collectionCount"];
    comment.createTime = dict[@"createTime"];
    comment.ID = dict[@"id"];
    comment.siteId = dict[@"siteId"];
    comment.agreeCount = dict[@"agreeCount"];
    return comment;
}

@end
