//
//  LJDataManager.h
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface LJDataManager : NSObject

+ (instancetype)manager;

//使用NSUserDefaults保存数据
- (void)saveDictionaryWithObjects:(id)obj andPropertyNames:(NSArray *)names forKey:(id)key;
- (NSArray *)loadObjectsForKey:(id)key;

//数据库操作
- (void)openDatabase;
- (void)closeDatabase;
- (void)executeUpdate:(NSString*)sql, ...;
- (FMResultSet *)executeQuery:(NSString *)sql, ...;

@end
