//
//  LJSettingActionCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSettingActionCell.h"

@interface LJSettingActionCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation LJSettingActionCell

- (void)setItem:(LJSettingSubtitleItem *)item
{
    self.title.text = item.title;
}

@end
