//
//  LJQueryJson.h
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJProductFilterItemGroup.h"

@interface LJQueryJson : NSObject

+ (NSString *)jsonWithFilterItemGroup:(NSArray *)groups;

@end
