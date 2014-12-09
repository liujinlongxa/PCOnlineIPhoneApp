//
//  LJProductCategoryCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductCategoryCell.h"

@interface LJProductCategoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end

@implementation LJProductCategoryCell

- (void)setCategory:(LJProductCategory *)category
{
    _category = category;
    self.iconImage.image = [UIImage imageNamed:category.image];
    self.titleLab.text = category.title;
    self.subTitleLab.text = [category.subCategoryName componentsJoinedByString:@"  "];
}

@end
