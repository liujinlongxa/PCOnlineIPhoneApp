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

@property (nonatomic, strong) NSString * subItemIDStr; //子版块ID集合，用逗号分开，用于请求数据

+ (instancetype)bbsListWithDict:(NSDictionary *)dict;

@end
