//
//  LJHotForum.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJBBSListItem.h"

@interface LJHotForum : NSObject

@property (nonatomic, copy) NSString * forumId;
@property (nonatomic, copy) NSString * forumName;
@property (nonatomic, copy) NSString * from;
@property (nonatomic, copy) NSString * topics;

+ (instancetype)hotForumWithDict:(NSDictionary *)dict;

@property (nonatomic, strong) LJBBSListItem * bbsItem;

@end
