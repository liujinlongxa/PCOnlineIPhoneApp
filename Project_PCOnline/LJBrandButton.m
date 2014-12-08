//
//  LJBrandButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/7.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBrandButton.h"
#import "LJCommonHeader.h"
#import "UIImageView+WebCache.h"

@interface LJBrandButton ()

@property (nonatomic, weak) UILabel * indexLab;
@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UIImageView * brandLogo;

@end

@implementation LJBrandButton

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat indexW = 30;
    CGFloat padding = 5;
    
    self = [super initWithFrame:frame];
    if (self) {
        //index
        UILabel * indexLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, indexW, CGRectGetHeight(frame))];
        [self addSubview:indexLab];
        self.indexLab = indexLab;
        self.indexLab.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * brandLogo = [[UIImageView alloc] init];
        [self addSubview:brandLogo];
        self.brandLogo = brandLogo;
        self.brandLogo.hidden = YES;
        
        //title
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(indexW + padding, 0, CGRectGetWidth(frame) - indexW - padding, CGRectGetHeight(frame))];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        self.titleLab.font = [UIFont systemFontOfSize:15];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

- (void)setBrand:(LJBrand *)brand
{
    _brand = brand;
    CGFloat padding = 5;
    CGFloat logoW = 50;
    CGFloat indexW = 30;
    if ([brand.index isEqualToString:@"荐"]) {
        //logos
        self.brandLogo.frame = CGRectMake(padding * 2, padding, logoW, CGRectGetHeight(self.frame) - 2 * padding);
        [self.brandLogo sd_setImageWithURL:[NSURL URLWithString:brand.logo] placeholderImage:[UIImage imageNamed:@"common_default_80x60"]];
        self.brandLogo.hidden = NO;
        self.indexLab.hidden = YES;
        //lab
        self.titleLab.text = self.brand.name;
        self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.brandLogo.frame) + padding, 0, CGRectGetWidth(self.frame) - logoW - padding, CGRectGetHeight(self.frame));
    }
    else
    {
        self.brandLogo.hidden = YES;
        self.indexLab.hidden = NO;
        self.indexLab.text = self.brand.index;
        self.titleLab.text = self.brand.name;
        self.titleLab.frame = CGRectMake(indexW + padding, 0, CGRectGetWidth(self.frame) - indexW - padding, CGRectGetHeight(self.frame));
    }
}


@end
