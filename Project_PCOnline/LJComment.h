//
//  LJComment.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJComment : NSObject

@property (nonatomic, strong) NSArray * commentItems;
@property (nonatomic, copy) NSString * current;
@property (nonatomic, assign) BOOL expand;
@property (nonatomic, copy) NSString * support;

@end
