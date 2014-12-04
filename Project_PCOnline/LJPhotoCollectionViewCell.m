//
//  LJPhotoCollectionViewCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPhotoCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface LJPhotoCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@end

@implementation LJPhotoCollectionViewCell

- (void)setPhoto:(LJPhoto *)photo
{
    _photo = photo;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo.url] placeholderImage:[UIImage imageNamed:@"common_default_320x480"]];
}

@end
