//
//  LJDataManager.h
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJDataManager : NSObject

+ (instancetype)manager;

- (void)saveDictionaryWithObjects:(id)obj andPropertyNames:(NSArray *)names forKey:(id)key;
- (NSArray *)loadObjectsForKey:(id)key;
@end
