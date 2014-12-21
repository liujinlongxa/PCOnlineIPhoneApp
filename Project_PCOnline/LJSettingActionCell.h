//
//  LJSettingActionCell.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSettingSubtitleItem.h"

#define kSettingActionCellIdentifier @"SettingActionCell"

@interface LJSettingActionCell : UITableViewCell

@property (nonatomic, strong) LJSettingSubtitleItem * item;

@end
