//
//  LJDataManager.m
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJDataManager.h"


static LJDataManager * manager;
@implementation LJDataManager

+ (instancetype)manager
{
    if (!manager) {
        manager = [[LJDataManager alloc] init];
    }
    return manager;
}

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

@end
