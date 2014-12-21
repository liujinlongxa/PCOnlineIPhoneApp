//
//  LJLoginButtong.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJLoginButton.h"

@interface LJLoginButton ()

@property (nonatomic, weak) UIImageView * logoImage;
@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UILabel * subtitleLab;

@end

@implementation LJLoginButton

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title andSubtitle:(NSString *)subtitle
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //logo image
        UIImageView * logoImage = [[UIImageView alloc] init];
        [self addSubview:logoImage];
        self.logoImage = logoImage;
        self.logoImage.image = image;

        //title lab
        UILabel * titleLab = [[UILabel alloc] init];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        self.titleLab.text = title;
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.font = [UIFont boldSystemFontOfSize:15];
        
        //sub title Lab
        UILabel * subtitleLab = [[UILabel alloc] init];
        [self addSubview:subtitleLab];
        self.subtitleLab = subtitleLab;
        self.subtitleLab.text = subtitle;
        self.subtitleLab.textColor = [UIColor whiteColor];
        self.subtitleLab.font = [UIFont systemFontOfSize:13];
    }
    return self;
}


- (void)layoutSubviews
{
    CGFloat btnW = CGRectGetWidth(self.frame);
    CGFloat btnH = CGRectGetHeight(self.frame);
    CGFloat padding = 10;
    
    //logo image
    CGFloat imageWH = btnH;
    self.logoImage.layer.cornerRadius = imageWH / 2;
    self.logoImage.clipsToBounds = YES;
    self.logoImage.frame = CGRectMake(0, 0, imageWH, imageWH);
    
    //title label
    CGFloat titleX = CGRectGetMaxX(self.logoImage.frame) + padding;
    CGFloat titleY = padding / 2;
    CGFloat titleW = btnW - padding * 2 - imageWH;
    CGFloat titleH = 20;
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //subtitle label
    CGFloat subX = titleX;
    CGFloat subY = CGRectGetMaxY(self.titleLab.frame) + padding;
    CGFloat subW = titleW;
    CGFloat subH = btnH - 1.5 * padding - titleH;
    self.subtitleLab.frame = CGRectMake(subX, subY, subW, subH);
}

@end
