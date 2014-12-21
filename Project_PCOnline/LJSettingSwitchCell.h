//
//  LJSettingSwitchCell.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSettingSwitchItem.h"

#define kSettingSwitchCellIdentifier @"SettingSwitchCell"
@interface LJSettingSwitchCell : UITableViewCell

@property (nonatomic, strong) LJSettingSwitchItem * item;

@end
