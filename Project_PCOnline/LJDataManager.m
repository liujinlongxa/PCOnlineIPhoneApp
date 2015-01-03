//
//  LJDataManager.m
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJDataManager.h"
#import "LJCommonHeader.h"
#import "fmdb/FMDB.h"

static LJDataManager * manager;

@interface LJDataManager ()

/**
 *  数据库文件路径
 */
@property (nonatomic, copy) NSString * dbPath;

/**
 *  数据库对象
 */
@property (nonatomic, strong) FMDatabase * database;

@end

@implementation LJDataManager

+ (instancetype)manager
{
    if (!manager) {
        manager = [[LJDataManager alloc] init];
    }
    return manager;
}

#pragma mark - NSUserDefaults
- (void)saveDictionaryWithObjects:(id)objs andPropertyNames:(NSArray *)names forKey:(id)key
{
    NSMutableArray * arr = [NSMutableArray array];
    for (id obj in objs) {
        NSDictionary * dict = [obj dictionaryWithValuesForKeys:names];
        [arr addObject:dict];
    }
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:key];
}

- (NSArray *)loadObjectsForKey:(id)key;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark - FMDB

- (FMDatabase *)database
{
    if (!_database)
    {
        _database = [FMDatabase databaseWithPath:self.dbPath];
    }
    return _database;
}

/**
 *  获取数据文件路径
 */
- (NSString *)dbPath
{
    if (!_dbPath)
    {
        _dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _dbPath = [_dbPath stringByAppendingPathComponent:@"data.sqlite"];
        LJLog(@"%@", _dbPath);
    }
    return _dbPath;
}

/**
 *  打开数据库
 */
- (void)openDatabase
{
    BOOL result = [self.database open];
    NSParameterAssert(result);
}

/**
 *  关闭数据库
 */
- (void)closeDatabase
{
    NSParameterAssert(self.database != nil);
    BOOL result = [self.database close];
    NSParameterAssert(result);
}

/**
 *  更新数据库
 *
 *  @param sql SQL语句
 */
- (void)executeUpdate:(NSString*)sql, ...
{
    BOOL ret = NO;
    
    va_list args;
    va_start(args, sql);
    
    [self openDatabase];
    
    /**
     *  执行更新
     */
    ret = [self.database executeUpdate:sql withVAList:args];
    
//    [self closeDatabase];
    
    va_end(args);
    
    NSParameterAssert(ret);
}

/**
 *  查询数据库
 *
 *  @param sql SQL语句
 *
 *  @return 返回查询结果集
 */
- (FMResultSet *)executeQuery:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    
    [self openDatabase];
    
    /**
     *  执行查询
     */
    FMResultSet * resultSet = [self.database executeQuery:sql withVAList:args];
    
//    [self closeDatabase];
    
    va_end(args);
    
    return resultSet;
}

@end
