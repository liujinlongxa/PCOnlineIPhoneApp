//
//  LJProductSearchResultItem.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJProductSearchResultItem : NSObject

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * pic;
@property (nonatomic, copy) NSString * summary;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSNumber * price;


+ (instancetype)productSearchResultItemWithDict:(NSDictionary *)dict;

@end
