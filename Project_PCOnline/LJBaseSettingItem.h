//
//  LJBaseSettingItem.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LJSettingItemTypeSwitch,        //开关类型
    LJSettingItemTypeChildSelect,   //子界面选择类型
    LJSettingItemTypeSubtitle,      //无跳转，只有一个subtitle，如：清理缓存
    LJSettingItemTypeWithAction,    //有跳转动作或其他特殊动作
    LJSettingItemTypeTwoImage       //两张图片类型
} LJSettingItemType;

@class LJBaseSettingItem;

typedef void(^SettingActionBlock)(LJBaseSettingItem * item);

@interface LJBaseSettingItem : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) LJSettingItemType type;
@property (nonatomic, copy) SettingActionBlock action;


- (instancetype)initWithTitle:(NSString *)title andType:(LJSettingItemType)type andAction:(SettingActionBlock)action;

@end
