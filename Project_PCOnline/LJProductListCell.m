//
//  LJProductListCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductListCell.h"
#import "UIImageView+WebCache.h"

@interface LJProductListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;

@end

@implementation LJProductListCell

- (void)setProduct:(LJProduct *)product
{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:product.idxPic] placeholderImage:[UIImage imageNamed:@"common_default_80x60"]];
    self.nameLab.text = product.shortName;
    self.priceLab.text = [NSString stringWithFormat:@"￥%d", [product.price integerValue]];
#warning 此处有bug，每种品牌显示的内容应该不一样
    NSString * desc = [NSString stringWithFormat:@"%@:%@\n%@:%@", product.items[0], product.items[1], product.items[2], product.items[3]];
    self.desLab.text = desc;
}

@end
