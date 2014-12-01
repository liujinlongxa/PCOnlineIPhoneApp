//
//  LJNewsNormalCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsNormalCell.h"

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
    self.imageIcon.image = [UIImage imageNamed:news.image];
    self.titleLab.text = news.title;
    self.pubDate.text = news.pubDate;
    self.cmtCountLab.text = [NSString stringWithFormat:@"%d评论", [news.cmtCount integerValue]];
}

@end
