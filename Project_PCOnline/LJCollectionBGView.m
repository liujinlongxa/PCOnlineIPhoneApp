//
//  LJCollectionBGView.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJCollectionBGView.h"
#import "LJCommonHeader.h"

#define kImageH 260
#define kPadding 10

@interface LJCollectionBGView ()


@property (weak, nonatomic) UIImageView *image;
@property (weak, nonatomic) UILabel *msgLabel;

@end

@implementation LJCollectionBGView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //image
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kImageH)];
        [self addSubview:imageView];
        self.image = imageView;
        
        //label
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + kPadding * 2, kScrW, 50)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.numberOfLines = 2;
        [self addSubview:label];
        self.msgLabel = label;
    }
    return self;
}

- (void)setBgType:(LJCollectionBGViewType)bgType
{
    switch (bgType) {
        case LJCollectionBGViewTypeArticle:
            self.image.image = [UIImage imageNamed:@"empty_favo_article"];
            self.msgLabel.text = @"您还没有收藏文章\n请点击文章星标进行收藏";
            break;
        case LJCollectionBGViewTypeBBS:
            self.image.image = [UIImage imageNamed:@"empty_favo_forum"];
            self.msgLabel.text = @"您还没有收藏论坛\n请点击论坛星标进行收藏";
            break;
        case LJCollectionBGViewTypeTopic:
            self.image.image = [UIImage imageNamed:@"empty_favo_topic"];
            self.msgLabel.text = @"您还没有收藏帖子\n请点击帖子星标进行收藏";
            break;
        default:
            break;
    }
}

@end
