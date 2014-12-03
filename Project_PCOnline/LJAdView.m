//
//  LJAdView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJAdView.h"
#import "UIImageView+WebCache.h"

#define kTitleLableH 30

@interface LJAdView ()

@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation LJAdView


+ (instancetype)adViewWithFrame:(CGRect)frame andImage:(NSString *)imageUrl andTitle:(NSString *)title
{
    LJAdView * view = [[LJAdView alloc] initWithFrame:frame];
    //设置图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:view.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"common_default_300x165"]];
    [view addSubview:imageView];
    view.imageView = imageView;
    //设置标题
    if (title) {
        CGFloat titleH = kTitleLableH;
        CGFloat titleY = CGRectGetHeight(view.frame) - kTitleLableH;
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, titleY, CGRectGetWidth(view.frame), titleH)];
        titleLab.text = title;
        titleLab.alpha = 0.9;
        titleLab.backgroundColor = [UIColor grayColor];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont systemFontOfSize:15];
        view.titleLabel = titleLab;
        [view addSubview:titleLab];
    }
    return view;
}

- (void)updateWithImage:(NSString *)imageUrl andTitle:(NSString *)title
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"common_default_93x62"]];
    self.titleLabel.text = title;
}


@end
