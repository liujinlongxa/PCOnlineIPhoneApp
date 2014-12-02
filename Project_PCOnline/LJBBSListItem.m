//
//  LJBBSListItem.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSListItem.h"

@implementation LJBBSListItem

+ (instancetype)bbsListItemWithArr:(NSArray *)arr
{
    LJBBSListItem * item = [[self alloc] init];
    item.ID = arr[0];
    item.title = arr[1];
    if (arr.count == 3) {
        item.imageUrl = arr[2];
    }
    return item;
}

@end
