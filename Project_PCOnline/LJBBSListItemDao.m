//
//  LJBBSListItemDao.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJBBSListItemDao.h"
#import "LJDataManager.h"
#import "LJBBSListItem.h"

#define kBBSListItemTableName @"BBSListItemTable"

@implementation LJBBSListItemDao

/**
 *  创建表
 */
+ (void)createBBSListItemTable
{
    NSString * sql = [NSString stringWithFormat:@"create table if not exists %@( \
                      ID integer primary key,\
                      title text, \
                      imageUrl text)", kBBSListItemTableName];
    [[LJDataManager manager] executeUpdate:sql];
}

+ (void)addBBSListItemToDB:(LJBBSListItem *)item
{
    NSString * sql = [NSString stringWithFormat:@"insert into %@ (ID, title, imageUrl) \
                      values ('%@','%@','%@')", kBBSListItemTableName, item.ID, item.title, item.imageUrl];
    [[LJDataManager manager] executeUpdate:sql];
    [[LJDataManager manager] closeDatabase];
}

+ (void)removeBBSListItemFromDB:(LJBBSListItem *)item
{
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where ID = '%@'", kBBSListItemTableName, item.ID];
    [[LJDataManager manager] executeUpdate:sql];
    [[LJDataManager manager] closeDatabase];
}

+ (NSArray *)selectAllBBSListItemFromDB
{
    [self createBBSListItemTable];
    NSMutableArray * result = [NSMutableArray array];
    
    NSString * sql = [NSString stringWithFormat:@"select * from %@", kBBSListItemTableName];
    FMResultSet * resultSet = [[LJDataManager manager] executeQuery:sql];
    
    while ([resultSet next])
    {
        LJBBSListItem * item = [[LJBBSListItem alloc] init];
        item.ID = @([resultSet intForColumn:@"ID"]);
        item.title = [resultSet stringForColumn:@"title"];
        item.imageUrl = [resultSet stringForColumn:@"imageUrl"];
        [result addObject:item];
    }
    
    [[LJDataManager manager] closeDatabase];
    
    return [result copy];
}

+ (BOOL)selectWithExistItem:(LJBBSListItem *)item
{
    [self createBBSListItemTable];
    NSString * sql = [NSString stringWithFormat:@"select * from %@ where ID = '%@'", kBBSListItemTableName, item.ID];
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
