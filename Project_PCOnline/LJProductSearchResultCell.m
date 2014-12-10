//
//  LJProductSearchResultCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductSearchResultCell.h"
#import "UIImageView+WebCache.h"

@interface LJProductSearchResultCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end

@implementation LJProductSearchResultCell

- (void)setItem:(LJProductSearchResultItem *)item
{
    _item = item;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:@"common_default_93x62"]];
    self.titleLab.text = item.title;
    self.priceLab.text = [NSString stringWithFormat:@"￥%d", item.price.integerValue];
    self.detailLab.text = item.summary;
}

@end
