//
//  LJSettingChildSelectCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSettingChildSelectCell.h"

@interface LJSettingChildSelectCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end

@implementation LJSettingChildSelectCell

- (void)setItem:(LJSettingChildSelectItem *)item
{
    _item = item;
    self.title.text = item.title;
    self.subtitle.text = item.childItems[item.selectIndex];
}

@end
