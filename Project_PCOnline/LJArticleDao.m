//
//  LJArticleDao.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/3.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJArticleDao.h"
#import "LJDataManager.h"

#define kArticleTableName @"ArticleTable"

@implementation LJArticleDao


/**
 *  创建表
 */
+ (void)createArticleTable
{
    NSString * sql = [NSString stringWithFormat:@"create table if not exists %@( \
                      articleId integer primary key,\
                      title text)", kArticleTableName];
    [[LJDataManager manager] executeUpdate:sql];
}

/**
 *  向数据库中添加一条数据
 *
 *  @param item 要添加的数据
 */
+ (void)addArticleToDB:(LJArticleDaoModel *)item
{
    NSString * sql = [NSString stringWithFormat:@"insert into %@ (articleId, title) \
                      values ('%@','%@')", kArticleTableName, item.articleId, item.title];
    [[LJDataManager manager] executeUpdate:sql];
    [[LJDataManager manager] closeDatabase];
}

/**
 *  从数据库中删除指定数据
 *
 *  @param item 要删除的数据
 */
+ (void)removeArticleFromDB:(LJArticleDaoModel *)item
{
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where articleId = '%@'", kArticleTableName, item.articleId];
    [[LJDataManager manager] executeUpdate:sql];
    [[LJDataManager manager] closeDatabase];
}

/**
 *  从数据库中查询所有的Article
 *
 *  @return 返回查询结果
 */
+ (NSArray *)selectAllArticleFromDB
{
    [self createArticleTable];
    NSMutableArray * result = [NSMutableArray array];
    
    NSString * sql = [NSString stringWithFormat:@"select * from %@", kArticleTableName];
    FMResultSet * resultSet = [[LJDataManager manager] executeQuery:sql];
    
    while ([resultSet next])
    {
        LJArticleDaoModel * item = [[LJArticleDaoModel alloc] init];
        item.articleId = @([resultSet intForColumn:@"articleId"]);
        item.title = [resultSet stringForColumn:@"title"];
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
+ (BOOL)selectWithExistItem:(LJArticleDaoModel *)item
{
    [self createArticleTable];
    NSString * sql = [NSString stringWithFormat:@"select * from %@ where articleId = '%@'", kArticleTableName, item.articleId];
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
