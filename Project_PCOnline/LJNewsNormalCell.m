//
//  LJNewsNormalCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsNormalCell.h"
#import "UIImageView+WebCache.h"

@interface LJNewsNormalCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;
@property (weak, nonatomic) IBOutlet UILabel *cmtCountLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;

@end

@implementation LJNewsNormalCell

- (void)setNews:(LJNews *)news
{
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:news.image] placeholderImage:[UIImage imageNamed:@"common_default_60x60"]];
    self.titleLab.text = news.title;
    self.pubDate.text = news.pubDate;
    self.cmtCountLab.text = (news.cmtCount.integerValue == 0) ? @"抢沙发" : [NSString stringWithFormat:@"%d评论", [news.cmtCount integerValue]];
}

@end
