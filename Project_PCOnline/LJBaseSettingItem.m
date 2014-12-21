//
//  LJBaseSettingItem.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseSettingItem.h"

@implementation LJBaseSettingItem

- (instancetype)initWithTitle:(NSString *)title andType:(LJSettingItemType)type andAction:(SettingActionBlock)action
{
    if (self = [super init]) {
        self.title = title;
        self.type = type;
        self.action = action;
    }
    return self;
}

@end
