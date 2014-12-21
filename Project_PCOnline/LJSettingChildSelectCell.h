//
//  LJSettingChildSelectCell.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSettingChildSelectItem.h"

#define kSettingChildSelectCellIdentifier @"SettingChildSelectCell"

@interface LJSettingChildSelectCell : UITableViewCell

@property (nonatomic, strong) LJSettingChildSelectItem * item;

@end
