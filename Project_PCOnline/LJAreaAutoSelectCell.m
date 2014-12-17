//
//  LJAreaAutoSelectCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/16.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJAreaAutoSelectCell.h"

@interface LJAreaAutoSelectCell ()

@property (nonatomic, weak) UIActivityIndicatorView * activityView;
@property (nonatomic, weak) UILabel * subTextLab;
@property (nonatomic, weak) UILabel * titleLab;

@end

@implementation LJAreaAutoSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //activity View
        UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:activityView];
        self.activityView = activityView;
        self.activityView.hidden = YES;
        self.activityView.hidesWhenStopped = YES;
        
        //sub text lab
        UILabel * subTextLab = [[UILabel alloc] init];
        [self.contentView addSubview:subTextLab];
        self.subTextLab = subTextLab;
        self.subTextLab.text = @"正在定位";
        self.subTextLab.hidden = YES;
        
        //title lab
        UILabel * titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
//    CGFloat viewW = CGRectGetWidth(self.contentView.frame);
    CGFloat viewH = CGRectGetHeight(self.contentView.frame);
    
    //activity view
    self.activityView.frame = CGRectMake(padding, padding, 30, viewH - 2 * padding);
    
    //sub text lab
    CGFloat subTextX = CGRectGetMaxX(self.activityView.frame) + padding;
    self.subTextLab.frame = CGRectMake(subTextX, padding, 100, viewH - 2 * padding);
    
    //title
    self.titleLab.frame = CGRectMake(padding, padding, 100, viewH - 2 * padding);
    
}

#pragma mark - location

- (void)setArea:(LJArea *)area
{
    _area = area;
    [self stopLocation];
    self.titleLab.text = area.title;
}

- (void)startLocation
{
    self.activityView.hidden = NO;
    self.subTextLab.hidden = NO;
    self.titleLab.hidden = YES;
    [self.activityView startAnimating];
}

- (void)stopLocation
{
    [self.activityView stopAnimating];
    self.subTextLab.hidden = YES;
    self.titleLab.hidden = NO;
}

- (void)failedLocation
{
    [self stopLocation];
    self.titleLab.text = @"定位失败";
}



@end
