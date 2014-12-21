//
//  LJSettingSubtitleCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSettingSubtitleCell.h"

@interface LJSettingSubtitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@end

@implementation LJSettingSubtitleCell

- (void)setItem:(LJSettingSubtitleItem *)item
{
    self.titleLab.text = item.title;
    self.subTitleLab.text = item.subtitle;
}

@end
