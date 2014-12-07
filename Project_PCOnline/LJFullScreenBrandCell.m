//
//  LJFullScreenBrandCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/7.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJFullScreenBrandCell.h"
#import "LJBrandButton.h"

@interface LJFullScreenBrandCell ()

@property (nonatomic, weak) LJBrandButton * leftButton;
@property (nonatomic, weak) UIView * line;//分割线
@property (nonatomic, weak) LJBrandButton * rightButton;

@end

@implementation LJFullScreenBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat padding = 10;
        CGFloat cellW = CGRectGetWidth(self.frame);
        CGFloat btnW = (cellW - 0.5 - 2 * padding) / 2;
        CGFloat cellH = CGRectGetHeight(self.frame);
        
        //左侧Buton
        LJBrandButton * leftButton = [[LJBrandButton alloc] initWithFrame:CGRectMake(0, 0, btnW, cellH)];
        [self.contentView addSubview:leftButton];
        self.leftButton = leftButton;
        [self.leftButton addTarget:self action:@selector(brandBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //分割线
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftButton.frame), 0, 0.5, cellH)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
        self.line = line;
        
        //右侧Button
        LJBrandButton * rightButton = [[LJBrandButton alloc] initWithFrame:CGRectMake(btnW + 0.5, 0, btnW, cellH)];
        [self.contentView addSubview:rightButton];
        self.rightButton = rightButton;
        [self.rightButton addTarget:self action:@selector(brandBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置cell边框
        self.layer.borderColor = [[UIColor grayColor] CGColor];
        self.layer.borderWidth = 0.5;
    }
    return self;
}

- (void)setLeftBrand:(LJBrand *)leftBrand
{
    _leftBrand = leftBrand;
    self.leftButton.brand = leftBrand;
}

- (void)setRightBrand:(LJBrand *)rightBrand
{
    _rightBrand = rightBrand;
    self.rightButton.brand = rightBrand;
}

- (void)brandBtnClick:(LJBrandButton *)button
{
    self.SelectBrandBlock(button.brand);
}


@end
