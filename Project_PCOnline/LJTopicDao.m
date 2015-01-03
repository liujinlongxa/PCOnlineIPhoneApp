//
//  LJBBSTopicDao.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/3.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJTopicDao.h"
#import "LJDataManager.h"

#define kTopicTableName @"TopicTable"

@implementation LJTopicDao

/**
 *  创建表
 */
+ (void)createTopicTable
{
    NSString * sql = [NSString stringWithFormat:@"create table if not exists %@( \
                      topicId integer primary key,\
                      title text, \
                      baseUrl text)", kTopicTableName];
    [[LJDataManager manager] executeUpdate:sql];
}

/**
 *  向数据库中添加一条数据
 *
 *  @param item 要添加的数据
 */
+ (void)addTopicItemToDB:(LJTopicDaoModel *)item
{
    NSString * sql = [NSString stringWithFormat:@"insert into %@ (topicId, title, baseUrl) \
                      values ('%@','%@','%@')", kTopicTableName, item.topicId, item.title, item.baseUrl];
    [[LJDataManager manager] executeUpdate:sql];
    [[LJDataManager manager] closeDatabase];
}

/**
 *  从数据库中删除指定数据
 *
 *  @param item 要删除的数据
 */
+ (void)removeTopicItemFromDB:(LJTopicDaoModel *)item
{
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where topicId = '%@'", kTopicTableName, item.topicId];
    [[LJDataManager manager] executeUpdate:sql];
    [[LJDataManager manager] closeDatabase];
}

/**
 *  从数据库中查询所有的TopicItem
 *
 *  @return 返回查询结果
 */
+ (NSArray *)selectAllTopicItemFromDB
{
    [self createTopicTable];
    NSMutableArray * result = [NSMutableArray array];
    
    NSString * sql = [NSString stringWithFormat:@"select * from %@", kTopicTableName];
    FMResultSet * resultSet = [[LJDataManager manager] executeQuery:sql];
    
    while ([resultSet next])
    {
        LJTopicDaoModel * item = [[LJTopicDaoModel alloc] init];
        item.topicId = @([resultSet intForColumn:@"topicId"]);
        item.title = [resultSet stringForColumn:@"title"];
        item.baseUrl = [resultSet stringForColumn:@"baseUrl"];
        [result addObject:item];
    }
    
    [[LJDataManager manager] closeDatabase];
    
    return [result copy];
}

/**
 *  从数据库中查询是否存在指定item
 *
 *  @param item 要查询的item
 *
 *  @return 查询结果，存在返回YES，否则返回NO
 */
+ (BOOL)selectWithExistItem:(LJTopicDaoModel *)item
{
    [self createTopicTable];
    NSString * sql = [NSString stringWithFormat:@"select * from %@ where topicId = '%@'", kTopicTableName, item.topicId];
    FMResultSet * resultSet = [[LJDataManager manager] executeQuery:sql];
    if ([resultSet next])
    {
        [[LJDataManager manager] closeDatabase];
        return YES;
    }
    else
    {
        [[LJDataManager manager] closeDatabase];
        return NO;
    }
}

@end
