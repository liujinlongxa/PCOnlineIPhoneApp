//
//  LJCommentTableHeaderView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentTableHeaderView.h"
#import "NSString+MyString.h"
#import "LJCommonHeader.h"

#define TitleFont [UIFont systemFontOfSize:17]
#define SmallFont [UIFont systemFontOfSize:13]

@interface LJCommentTableHeaderView ()

@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UILabel * posterLab;
@property (nonatomic, weak) UILabel * dateLab;
@property (nonatomic, weak) UIImageView * agreeImage;
@property (nonatomic, weak) UIImageView * disagreeImage;
@property (nonatomic, weak) UILabel * agreeLabel;
@property (nonatomic, weak) UILabel * disagreeLabel;

@property (nonatomic, weak) UILabel * addOne;

@end

@implementation LJCommentTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        //title
        UILabel * titleLab = [[UILabel alloc] init];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        self.titleLab.font = TitleFont;
        self.titleLab.numberOfLines = 2;
        
        //poster
        UILabel * posterLab = [[UILabel alloc] init];
        [self addSubview:posterLab];
        self.posterLab = posterLab;
        self.posterLab.font = SmallFont;
        self.posterLab.textColor = [UIColor grayColor];
        
        //date lab
        UILabel * dateLab = [[UILabel alloc] init];
        [self addSubview:dateLab];
        self.dateLab = dateLab;
        self.dateLab.font = SmallFont;
        self.dateLab.textColor = [UIColor grayColor];
        
        //agreeImage
        UIImageView * agreeImage = [[UIImageView alloc] init];
        agreeImage.image = [UIImage imageNamed:@"btn_comment_support"];
        [self addSubview:agreeImage];
        self.agreeImage = agreeImage;
        self.agreeImage.userInteractionEnabled = YES;
        [self.agreeImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreeAddOne:)]];
        
        //disagree image
        UIImageView * disagreeImage = [[UIImageView alloc] init];
        disagreeImage.image = [UIImage imageNamed:@"btn_comment_against"];
        [self addSubview:disagreeImage];
        self.disagreeImage = disagreeImage;
        self.disagreeImage.userInteractionEnabled = YES;
        [self.disagreeImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disagreeAddOne:)]];
        
        //agree label
        UILabel * agreeLab = [[UILabel alloc] init];
        [self addSubview:agreeLab];
        self.agreeLabel = agreeLab;
        self.agreeLabel.textAlignment = NSTextAlignmentCenter;
        
        //disagree label
        UILabel * disagreeLab = [[UILabel alloc] init];
        [self addSubview:disagreeLab];
        self.disagreeLabel = disagreeLab;
        self.disagreeLabel.textAlignment = NSTextAlignmentCenter;
        
        //add one
        UILabel * addOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        addOne.text = @"+1";
        addOne.textColor = [UIColor redColor];
        addOne.backgroundColor = [UIColor clearColor];
        [self addSubview:addOne];
        self.addOne = addOne;
        self.addOne.hidden = YES;
        self.addOne.font = [UIFont systemFontOfSize:17];
        self.addOne.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 10;
    
    //title label
    CGFloat titleX = padding;
    CGFloat titleY = padding;
    CGSize titleSize = [self.titleLab.text sizeOfStringInIOS7WithFont:TitleFont andMaxSize:CGSizeMake(kScrW - 2 * padding, 50)];
    self.titleLab.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    
    //poster label
    CGFloat posterX = titleX;
    CGFloat posterY = CGRectGetMaxY(self.titleLab.frame) + padding;
    CGSize posterSize = [self.posterLab.text sizeOfStringInIOS7WithFont:SmallFont andMaxSize:CGSizeMake(150, 30)];
    self.posterLab.frame = CGRectMake(posterX, posterY, posterSize.width, posterSize.height);
    
    //date label
    CGFloat dateX = CGRectGetMaxX(self.posterLab.frame) + padding;
    CGFloat dateY = posterY;
    CGFloat dateW = kScrW - 3 * padding - posterSize.width;
    CGFloat dateH = posterSize.height;
    self.dateLab.frame = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat imageW = 75;
    CGFloat imageH = 50;
    
    //agree image
    CGFloat agreeX = (kScrW - 2 * imageW) / 3;
    CGFloat agreeY = CGRectGetMaxY(self.dateLab.frame) + padding;
    self.agreeImage.frame = CGRectMake(agreeX, agreeY, imageW, imageH);
    
    //disagree image
    CGFloat disagreeX = (kScrW - 2 * imageW) / 3 * 2 + imageW;
    CGFloat disagreeY = agreeY;
    self.disagreeImage.frame = CGRectMake(disagreeX, disagreeY, imageW, imageH);
    
    CGFloat countLabelW = 75;
    CGFloat countLabelH = 30;
    
    //agree label
    CGFloat agreeLabelX = agreeX;
    CGFloat agreeLabelY = CGRectGetMaxY(self.agreeImage.frame) + padding;
    self.agreeLabel.frame = CGRectMake(agreeLabelX, agreeLabelY, countLabelW, countLabelH);
    
    //disagree label
    CGFloat disagreeLabelX = disagreeX;
    CGFloat disagreeLabelY = agreeLabelY;
    self.disagreeLabel.frame = CGRectMake(disagreeLabelX, disagreeLabelY, countLabelW, countLabelH);
    
}

#pragma mark - set data
- (void)setPageInfo:(LJCommentPageInfo *)pageInfo
{
    _pageInfo = pageInfo;
    self.titleLab.text = pageInfo.title;
    self.posterLab.text = pageInfo.author;
    self.dateLab.text = pageInfo.pubDate;
}

- (void)setSupprotInfo:(LJCommentSupportInfo *)supprotInfo
{
    _supprotInfo = supprotInfo;
    self.agreeLabel.text = [NSString stringWithFormat:@"%d顶", supprotInfo.agreeCount.integerValue];
    self.disagreeLabel.text = [NSString stringWithFormat:@"%d踩", supprotInfo.againstCount.integerValue];
}

#pragma mark - click agree or disagree
- (void)agreeAddOne:(UITapGestureRecognizer *)tap
{
    self.addOne.center = self.agreeImage.center;
    self.addOne.hidden = NO;

    [self startAnimation];
}

- (void)disagreeAddOne:(UITapGestureRecognizer *)tap
{
    self.addOne.center = self.disagreeImage.center;
    self.addOne.hidden = NO;
    
    [self startAnimation];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.addOne.hidden = YES;
}

- (void)startAnimation
{
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.delegate = self;
    CABasicAnimation * anim1 = [CABasicAnimation animation];
    anim1.keyPath = @"transform.translation.y";
    anim1.toValue = @(-40);
    
    CABasicAnimation * anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"transform.scale";
    anim2.toValue = @(3.0);
    
    group.duration = 1.0f;
    group.animations = @[anim1, anim2];
    
    [self.addOne.layer addAnimation:group forKey:nil];
}

@end
