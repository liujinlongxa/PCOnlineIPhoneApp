//
//  LJBrandButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/7.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBrandButton.h"
#import "LJCommonHeader.h"


@interface LJBrandButton ()

@property (nonatomic, weak) UILabel * indexLab;
@property (nonatomic, weak) UILabel * titleLab;

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
        
        //title
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(indexW + padding, 0, CGRectGetWidth(frame) - indexW - padding, CGRectGetHeight(frame))];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

- (void)setBrand:(LJBrand *)brand
{
    _brand = brand;
    self.indexLab.text = self.brand.index;
    self.titleLab.text = self.brand.name;
}


@end
