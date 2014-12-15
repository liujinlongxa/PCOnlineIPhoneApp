//
//  LJCommentInfo.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJCommentInfo : NSObject

@property (nonatomic, strong) NSNumber * floor;
@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, strong) NSNumber * total;
@property (nonatomic, copy) NSString * turl;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * url43g;

+ (instancetype)commentInfoWithDict:(NSDictionary *)dict;

@end
