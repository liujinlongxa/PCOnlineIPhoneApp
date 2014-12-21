//
//  LJSettingTwoImageCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSettingTwoImageCell.h"

@interface LJSettingTwoImageCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;


@end

@implementation LJSettingTwoImageCell

- (void)setItem:(LJSettingTwoImageItem *)item
{
    self.title.text = item.title;
    self.image1.image = item.image1;
    self.image2.image = item.image2;
}

@end
