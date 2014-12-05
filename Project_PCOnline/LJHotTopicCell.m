//
//  LJHotPostsCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotTopicCell.h"
#import "UIImageView+WebCache.h"

@interface LJHotTopicCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *forumLab;
@property (weak, nonatomic) IBOutlet UILabel *readAndFloorLab;

@end

@implementation LJHotTopicCell

- (void)setHotTopic:(LJHotTopic *)hotTopic
{
    self.titleLab.text = hotTopic.title;
    if (hotTopic.isShowImage) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:hotTopic.image] placeholderImage:[UIImage imageNamed:@"common_default_300x165"]];
    }
    self.contentLab.text = hotTopic.message;
    self.forumLab.text = hotTopic.forumName;
    self.readAndFloorLab.text = [NSString stringWithFormat:@"%d阅/%d楼", hotTopic.viewCount.integerValue, hotTopic.replyCount.integerValue];
}


@end
