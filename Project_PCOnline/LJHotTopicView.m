//
//  LJHotTopicView.m
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotTopicView.h"

@interface LJHotTopicView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;
@property (weak, nonatomic) IBOutlet UILabel *forumNameLab;
@property (weak, nonatomic) IBOutlet UILabel *viewAndReplyLab;


@end

@implementation LJHotTopicView

- (void)setTopic:(LJHotTopic *)topic
{
    _topic = topic;
    self.titleLab.text = topic.title;
    self.messageLab.text = topic.message;
    self.forumNameLab.text = topic.forumName;
    self.viewAndReplyLab.text = [NSString stringWithFormat:@"%d阅/%d楼", topic.viewCount.integerValue, topic.floor.integerValue];
}

@end
