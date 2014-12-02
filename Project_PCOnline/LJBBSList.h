//
//  LJBBSList.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJBBSListItem.h"

@interface LJBBSList : NSObject

@property (nonatomic, strong) LJBBSListItem * listItem;
@property (nonatomic, strong) NSArray * children;
@property (nonatomic, strong) NSArray * me;

+ (instancetype)bbsListWithDict:(NSDictionary *)dict;

@end
