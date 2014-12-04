//
//  LJBrandCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBrandCell.h"
#import "UIImageView+WebCache.h"

@interface LJBrandCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation LJBrandCell

- (void)setBrand:(LJBrand *)brand
{
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:brand.logo] placeholderImage:[UIImage imageNamed:@"common_default_80x60"]];
    self.nameLab.text = brand.name;
}

@end
