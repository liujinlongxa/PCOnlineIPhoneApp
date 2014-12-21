//
//  LJSettingChildSelectItem.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseSettingItem.h"

@interface LJSettingChildSelectItem : LJBaseSettingItem

@property (nonatomic, strong) NSArray * childItems;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) NSString * message;
@end
