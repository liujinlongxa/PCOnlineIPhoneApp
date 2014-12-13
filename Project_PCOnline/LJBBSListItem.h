//
//  LJBBSListItem.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBBSListItem : NSObject

@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * imageUrl;

+ (instancetype)bbsListItemWithArr:(NSArray *)arr;
+ (instancetype)bbsListItemWithID:(NSNumber *)ID;
@end
