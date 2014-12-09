//
//  LJProductFilterItemCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductFilterItemCell.h"
#import "LJCommonHeader.h"

#define kObersverKeyPath @"item.selected"

#define kImageW 20
@interface LJProductFilterItemCell ()

@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UILabel * detailLab;
@property (nonatomic, weak) UIImageView * selectImage;

@property (nonatomic, assign) CGRect normalDetailLabFrame;
@property (nonatomic, assign) CGRect selectDetailLabFrame;

@end

@implementation LJProductFilterItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //title
        UILabel * title = [[UILabel alloc] init];
        [self.contentView addSubview:title];
        self.titleLab = title;
        self.titleLab.font = [UIFont systemFontOfSize:17];
        
        //detail
        UILabel * detailLab = [[UILabel alloc] init];
        [self.contentView addSubview:detailLab];
        self.detailLab = detailLab;
        self.detailLab.font = [UIFont systemFontOfSize:13];
        self.detailLab.textColor = [UIColor darkGrayColor];
        self.detailLab.textAlignment = NSTextAlignmentRight;
        
        //image
        UIImageView * selectImage = [[UIImageView alloc] init];
        selectImage.image = [UIImage imageNamed:@"btn_common_blue_selected_hint"];
        selectImage.hidden = YES;
        [self.contentView addSubview:selectImage];
        self.selectImage = selectImage;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == nil) {
        if ([keyPath isEqualToString:kObersverKeyPath]) {
            if (self.item.isSelected) {
                [self setupSelect];
            }
            else
            {
                [self setupDeselect];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)prepareForReuse
{
    //重用时也应该先删除观察者，否则会添加多个观察者
    [self removeObserver:self forKeyPath:kObersverKeyPath];
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
    
    //title lab
    CGFloat titleW = 170;
    CGFloat titleX = padding;
    CGFloat titleY = 0;
    CGFloat titleH = CGRectGetHeight(self.contentView.frame);
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //image
    CGFloat imageW = kImageW;
    CGFloat imageX = CGRectGetWidth(self.contentView.frame) - padding - imageW;
    CGFloat imageY = 10;
    CGFloat imageH = CGRectGetHeight(self.contentView.frame) - imageY * 2;
    
    //detail lab
    CGFloat detailX = 0;
    if (self.item.isSelected) {
        detailX = CGRectGetMaxX(self.titleLab.frame) - imageW;
    }
    else
    {
        detailX = CGRectGetMaxX(self.titleLab.frame) + padding;
    }
    CGFloat detailY = 0;
    CGFloat detailW = CGRectGetWidth(self.contentView.frame) - titleW - 3 * padding;
    CGFloat detailH = CGRectGetHeight(self.contentView.frame);
    self.detailLab.frame = CGRectMake(detailX, detailY, detailW, detailH);
    
    
    self.selectImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setupSelect
{
    //颜色
    self.titleLab.textColor = BlueTextColor;
    self.detailLab.textColor = BlueTextColor;
    //image
    self.selectImage.hidden = NO;
}

- (void)setupDeselect
{
    //颜色
    self.titleLab.textColor = [UIColor blackColor];
    self.detailLab.textColor = [UIColor darkGrayColor];
    //image
    self.selectImage.hidden = YES;
}

- (void)setItem:(LJProductFilterItem *)item
{
    _item = item;
    self.titleLab.text = item.name;
    self.detailLab.text = [NSString stringWithFormat:@"(%@款符合条件)", item.count];
    if (self.item.isSelected) {
        [self setupSelect];
    }
    else
    {
        [self setupDeselect];
    }
    //设置kvo观察者
    [self addObserver:self forKeyPath:kObersverKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:kObersverKeyPath];
}

@end
