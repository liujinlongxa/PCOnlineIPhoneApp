//
//  LJSettingSwitchCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSettingSwitchCell.h"

@interface LJSettingSwitchCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UISwitch *sw;

@end

@implementation LJSettingSwitchCell

- (void)setItem:(LJSettingSwitchItem *)item
{
    _item = item;
    self.title.text = item.title;
    self.sw.on = item.isOn;
}

@end
