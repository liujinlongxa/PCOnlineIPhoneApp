//
//  LJHotTopicFrame.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotTopicFrame.h"
#import "NSString+MyString.h"

@implementation LJHotTopicFrame

+ (instancetype)topicFrameWithTopic:(LJBaseTopic *)topic
{
    LJHotTopicFrame * topicFrame = [[self alloc] init];
    topicFrame.topic = topic;
    return topicFrame;
}

- (void)setTopic:(LJBaseTopic *)topic
{
    [super setTopic:topic];
    
    assert([topic isKindOfClass:[LJHotTopic class]]);
    LJHotTopic * hotTopic  = (LJHotTopic *)topic;
    CGFloat padding = 10;
    
    //content view frame
    CGFloat contentX = padding;
    CGFloat contentY = padding;
    CGFloat contentW = kScrW - 2 * padding;
    
    //forum frame
    CGFloat forumX = self.titleFrame.origin.x;
    CGFloat forumY = CGRectGetMaxY(self.messageFrame) + padding;
    CGSize forumSize = [hotTopic.forumName sizeOfStringInIOS7WithFont:TopicForumFont andMaxSize:CGSizeMake(150, 20)];
    self.forumOrTimeFrame = CGRectMake(forumX, forumY, forumSize.width, forumSize.height);
    
    //floorCount frame
    CGFloat floorCountX = 150 + padding;
    CGFloat floorCountY = forumY;
    NSString * floorCountStr = [NSString stringWithFormat:@"%d楼/%d阅", hotTopic.replyCount.integerValue, hotTopic.viewCount.integerValue];
    CGSize floorCountSize = [floorCountStr sizeOfStringInIOS7WithFont:TopicFloorCountFont andMaxSize:CGSizeMake(150, 20)];
    self.floorCountFrame = CGRectMake(floorCountX, floorCountY, floorCountSize.width, floorCountSize.height);
    
    //content view H
    CGFloat contentH = CGRectGetMaxY(self.forumOrTimeFrame) + padding;
    self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    
    //cell heigh
    self.cellHeigh = CGRectGetMaxY(self.contentFrame);
    
}

@end
