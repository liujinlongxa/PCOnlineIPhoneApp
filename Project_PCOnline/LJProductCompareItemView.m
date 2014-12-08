//
//  LJProductCompareItemView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductCompareItemView.h"
#import "UIImageView+WebCache.h"
#import "LJCommonHeader.h"

@interface LJProductCompareItemView ()

@property (nonatomic, weak) UIImageView * productImage;
@property (nonatomic, weak) UILabel * productTitleLab;
@property (nonatomic, weak) UIButton * closeBtn;

@end

@implementation LJProductCompareItemView

- (instancetype)initProductCompareItemViewWithFrame:(CGRect)frame andProduct:(LJProduct *)product
{
    if (self = [super initWithFrame:frame]) {
        
        //product image
        UIImageView * productImage = [[UIImageView alloc] init];
        [self addSubview:productImage];
        self.productImage = productImage;
        self.productImage.userInteractionEnabled = YES;
        [self.productImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCompareItem:)]];
        
        //product title
        UILabel * productTitleLab = [[UILabel alloc] init];
        [self addSubview:productTitleLab];
        self.productTitleLab = productTitleLab;
        self.productTitleLab.textAlignment = NSTextAlignmentCenter;
        self.productTitleLab.numberOfLines = 2;
        self.productTitleLab.backgroundColor = LightGrayBGColor;
        self.productTitleLab.font = [UIFont systemFontOfSize:15];
        
        //close btn
        UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:closeBtn];
        self.closeBtn = closeBtn;
        [self.closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.closeBtn setImage:[UIImage imageNamed:@"pconline_product_comparecancle_bg"] forState:UIControlStateNormal];
        
        self.product = product;
    }
    return self;
}

//根据产品是否为空，设置显示不同的内容
- (void)setProduct:(LJProduct *)product
{
    _product = product;
    if (product == nil) {
        self.productImage.image = [UIImage imageNamed:@"pconline_product_compare_bg"];
    }
    else
    {
        [self.productImage sd_setImageWithURL:[NSURL URLWithString:product.idxPic] placeholderImage:[UIImage imageNamed:@"common_default_120x90"]];
    }
    self.productTitleLab.hidden = product == nil;
    self.productTitleLab.text = self.product.shortName;
    
    self.closeBtn.hidden = (product == nil);
}

//布局子控件的frame
- (void)layoutSubviews
{
    CGFloat padding = 10;
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    CGFloat titleH = 40;
    
    //image
    CGFloat imageX = padding;
    CGFloat imageY = padding;
    CGFloat imageW = viewW - 2 * padding;
    CGFloat imageH = viewH - padding * 2 - 40;
    self.productImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //label
    CGFloat titleX = padding;
    CGFloat titleY = CGRectGetMaxY(self.productImage.frame) + padding;
    CGFloat titleW = viewW - 2 * padding;
    self.productTitleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //close btn
    CGFloat closeX = 0;
    CGFloat closeY = 0;
    CGFloat closeWH = 30;
    self.closeBtn.frame = CGRectMake(closeX, closeY, closeWH, closeWH);
}

+ (instancetype)productCompareItemViewWithFrame:(CGRect)frame andProduct:(LJProduct *)product
{
    LJProductCompareItemView * itemView = [[self alloc] initProductCompareItemViewWithFrame:frame andProduct:product];
    return itemView;
    
}

#pragma mark - 关闭（叉号）按钮点击
- (void)closeBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(productCompareItemViewCloseProductItem:)]) {
        [self.delegate productCompareItemViewCloseProductItem:self];
        self.product = nil;
    }
}

- (void)addCompareItem:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(productCompareItemViewAddProductItem:)]) {
        [self.delegate productCompareItemViewAddProductItem:self];
    }
}

@end
