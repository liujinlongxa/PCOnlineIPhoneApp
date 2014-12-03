//
//  LJPhotoCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPhotoCell.h"
#import "UIImageView+WebCache.h"

@interface LJPhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation LJPhotoCell

- (void)setPhotoGroup:(LJPhotoGroup *)photoGroup
{
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:photoGroup.cover] placeholderImage:[UIImage imageNamed:@"common_default_100x76"]];
    self.nameLab.text = photoGroup.name;
    self.countLab.text = [NSString stringWithFormat:@"%d张", photoGroup.photoCount.integerValue];
}

@end
