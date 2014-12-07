//
//  LJHotForum.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotForum.h"

@implementation LJHotForum

+ (instancetype)hotForumWithDict:(NSDictionary *)dict
{
    LJHotForum * hotForum = [[self alloc] init];
    [hotForum setValuesForKeysWithDictionary:dict];
    return hotForum;
}

//NSNumber * ID;
//@property (nonatomic, copy) NSString * title;
//@property (nonatomic, copy) NSString * imageUrl;

- (LJBBSListItem *)bbsItem
{
    if (!_bbsItem)
    {
        NSArray * arr = @[[NSNumber numberWithInteger:self.forumId.integerValue], self.forumName];
        _bbsItem = [LJBBSListItem bbsListItemWithArr:arr];
    }
    return _bbsItem;
}

@end
