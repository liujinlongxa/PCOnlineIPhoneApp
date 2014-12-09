//
//  LJProductFilterGroupCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductFilterGroupCell.h"
#import "LJProductFilterItem.h"
@interface LJProductFilterGroupCell ()

@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UILabel * detailLab;
@property (nonatomic, weak) UIImageView * indicatorImage;
@end

@implementation LJProductFilterGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                
        //title lab
        UILabel * titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
        
        //detail lab
        UILabel * detailLab = [[UILabel alloc] init];
        [self.contentView addSubview:detailLab];
        self.detailLab = detailLab;
        self.detailLab.font = [UIFont systemFontOfSize:12];
        self.detailLab.textAlignment = NSTextAlignmentRight;
        self.detailLab.textColor = [UIColor darkGrayColor];
        
        //indicator
        UIImageView * indicatorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_setting_cell_indicator"]];
        [self.contentView addSubview:indicatorImage];
        self.indicatorImage = indicatorImage;
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
    
    //indicator
    CGFloat indicatorCenterX = CGRectGetWidth(self.contentView.frame) - 20;
    CGFloat indicatorCenterY = CGRectGetHeight(self.contentView.frame) / 2;
    self.indicatorImage.center = CGPointMake(indicatorCenterX, indicatorCenterY);
    
    //title lab
    CGFloat titleW = 120;
    CGFloat titleX = padding;
    CGFloat titleY = 0;
    CGFloat titleH = CGRectGetHeight(self.contentView.frame);
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //detail lab
    CGFloat detailX = CGRectGetMaxX(self.titleLab.frame) + padding;
    CGFloat detailY = 0;
    CGFloat detailW = CGRectGetWidth(self.contentView.frame) - titleW - 4 * padding - CGRectGetWidth(self.indicatorImage.frame);
    CGFloat detailH = CGRectGetHeight(self.contentView.frame);
    self.detailLab.frame = CGRectMake(detailX, detailY, detailW, detailH);
    
    
}

- (void)setGroup:(LJProductFilterItemGroup *)group
{
    _group = group;
    self.titleLab.text = group.name;
    self.detailLab.text = [self getSelectItemStr];
}

- (NSString *)getSelectItemStr
{
    if(self.group.selectCount == 0) return @"请选择";
    
    NSMutableArray * selectItemStrArr = [NSMutableArray array];
    for (LJProductFilterItem * item in self.group.cris) {
        if (item.isSelected) {
            [selectItemStrArr addObject:item.name];
        }
    }
    return [selectItemStrArr componentsJoinedByString:@","];
    
}

@end
