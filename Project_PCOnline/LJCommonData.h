//
//  LJCommonData.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJUrlHeader.h"
#import "LJArea.h"

@class LJBBSListItem;

@interface LJCommonData : NSObject

+ (instancetype)shareCommonData;

//频道数据
@property (nonatomic, strong) NSArray * SubjectsData;
@property (nonatomic, strong) NSArray * curShowSubjectsData;//当前显示的频道
@property (nonatomic, strong) NSArray * curHideSubjectsData;//当前隐藏的频道

//论坛数据
@property (nonatomic, strong) NSArray * BBSListData;
@property (nonatomic, strong) NSArray * AreaData;
@property (nonatomic, strong) LJArea * curArea;
- (void)saveObjc:(id)object forKey:(NSString *)key;
- (id)loadObjcForKey:(NSString *)key;
- (LJBBSListItem *)findBBSItemByID:(NSNumber *)ID inBBSLists:(NSArray *)bbsLists;

@end
