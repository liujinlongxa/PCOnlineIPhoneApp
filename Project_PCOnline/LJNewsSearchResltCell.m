//
//  LJNewsSearchResltCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsSearchResltCell.h"
#import "LJNewsSearchResultItem.h"

@interface LJNewsSearchResltCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end

@implementation LJNewsSearchResltCell

- (void)setNewsItem:(LJNewsSearchResultItem *)newsItem
{
    _newsItem = newsItem;
    self.titleLab.text = newsItem.title;
    self.dateLab.text = newsItem.pubDate;
}

@end
