//
//  LJProductFilterItem.h
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJProductFilterItem : NSObject

@property (nonatomic, copy) NSString * count;
@property (nonatomic, copy) NSString * criId;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * value;

//品牌ID
@property (nonatomic, copy) NSString * cId;

//是否被选中
@property (nonatomic, assign, getter=isSelected) BOOL selected;

+ (instancetype)productFilterItemWithDict:(NSDictionary *)dict;



@end
