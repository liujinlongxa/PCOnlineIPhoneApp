//
//  LJAreaManualSelectCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/16.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJAreaManualSelectCell.h"
#import "LJCommonHeader.h"

@interface LJAreaManualSelectCell ()

@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, weak) UIImageView * selectIcon;

@end

@implementation LJAreaManualSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //title label
        UILabel * titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        //select icon
        UIImageView * icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"btn_common_blue_selected_hint"];
        [self.contentView addSubview:icon];
        self.selectIcon = icon;
        self.selectIcon.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
    CGFloat viewW = CGRectGetWidth(self.contentView.frame);
    CGFloat viewH = CGRectGetHeight(self.contentView.frame);
    
    self.titleLabel.frame = CGRectMake(padding, padding, 200, viewH - 2 * padding);
    
    CGFloat iconWH = 22;
    self.selectIcon.frame = CGRectMake(viewW - 2 * padding - iconWH, (viewH - iconWH) / 2, iconWH, iconWH );
}

- (void)setArea:(LJArea *)area
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@", area.title];
}

- (void)setupSelect
{
    //颜色
    self.titleLabel.textColor = BlueTextColor;
    //image
    self.selectIcon.hidden = NO;
}

- (void)setupDeselect
{
    //颜色
    self.titleLabel.textColor = [UIColor blackColor];
    //image
    self.selectIcon.hidden = YES;
}

@end
