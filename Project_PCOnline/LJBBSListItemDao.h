//
//  LJBBSListItemDao.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//  LJBBSListItem的数据持久化对象

#import <Foundation/Foundation.h>

@class LJBBSListItem;

@interface LJBBSListItemDao : NSObject

/**
 *  向数据库中添加一条数据
 *
 *  @param item 要添加的数据
 */
+ (void)addBBSListItemToDB:(LJBBSListItem *)item;

/**
 *  从数据库中删除指定数据
 *
 *  @param item 要删除的数据
 */
+ (void)removeBBSListItemFromDB:(LJBBSListItem *)item;

/**
 *  从数据库中查询所有的BBSListItem
 *
 *  @return 返回查询结果
 */
+ (NSArray *)selectAllBBSListItemFromDB;

/**
 *  从数据库中查询是否存在指定item
 *
 *  @param item 要查询的item
 *
 *  @return 查询结果，存在返回YES，否则返回NO
 */
+ (BOOL)selectWithExistItem:(LJBBSListItem *)item;

@end
