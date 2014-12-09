//
//  LJQueryJson.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJQueryJson.h"
#import "LJProductFilterItem.h"

@implementation LJQueryJson

+ (NSString *)jsonWithFilterItemGroup:(NSArray *)groups
{
    NSMutableDictionary * rootDict = [NSMutableDictionary dictionary];
    for (LJProductFilterItemGroup * group in groups) {
        if(group.selectCount == 0) continue;
        
        NSMutableArray * subArr = [NSMutableArray array];
        for (LJProductFilterItem * item in group.cris) {
            if (item.isSelected) {
                [subArr addObject:item.value];
            }
        }
        [rootDict setObject:subArr forKey:group.value];
    }
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:rootDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

@end
