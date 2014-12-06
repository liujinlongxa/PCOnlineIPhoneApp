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

+ (instancetype)topicFrameWithTopic:(LJHotTopic *)topic
{
    LJHotTopicFrame * topicFrame = [[self alloc] init];
    topicFrame.topic = topic;
    return topicFrame;
}

- (void)setTopic:(LJHotTopic *)topic
{
    _topic = topic;
    
    CGFloat padding = 10;
    
    //content view frame
    CGFloat contentX = padding;
    CGFloat contentY = padding;
    CGFloat contentW = kScrW - 2 * padding;
    
    //title frame
    CGFloat titleX = padding;
    CGFloat titleY = padding;
    CGSize titleSize = [topic.title sizeOfStringInIOS7WithFont:TopicTitleFont andMaxSize:CGSizeMake(kScrW - 4 * titleX, 40)];
    self.titleFrame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height > 40 ? 40 : titleSize.height);
    
    //image frame
    if (topic.isShowImage)
    {
        CGFloat imageX = titleX;
        CGFloat imageY = CGRectGetMaxY(self.titleFrame) + padding;
        CGFloat imageW = kScrW - 4 * imageX;
        CGFloat imageH = 80;
        self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    }
    
    //message frame
    CGFloat messageX = titleX;
    CGFloat messageY = topic.isShowImage ? (CGRectGetMaxY(self.imageFrame) + padding) : (CGRectGetMaxY(self.titleFrame) + padding);
    CGSize messageSize = [topic.message sizeOfStringInIOS7WithFont:TopicMessageFont andMaxSize:CGSizeMake(kScrW - 4 * titleX, 40)];
    self.messageFrame = CGRectMake(messageX, messageY, messageSize.width, messageSize.height > 40 ? 40 : messageSize.height);
    
    //forum frame
    CGFloat forumX = titleX;
    CGFloat forumY = CGRectGetMaxY(self.messageFrame) + padding;
    CGSize forumSize = [topic.forumName sizeOfStringInIOS7WithFont:TopicForumFont andMaxSize:CGSizeMake(150, 20)];
    self.forumFrame = CGRectMake(forumX, forumY, forumSize.width, forumSize.height);
    
    //floorCount frame
    CGFloat floorCountX = 150 + padding;
    CGFloat floorCountY = forumY;
    NSString * floorCountStr = [NSString stringWithFormat:@"%d楼/%d阅", topic.replyCount.integerValue, topic.viewCount.integerValue];
    CGSize floorCountSize = [floorCountStr sizeOfStringInIOS7WithFont:TopicFloorCountFont andMaxSize:CGSizeMake(150, 20)];
    self.floorCountFrame = CGRectMake(floorCountX, floorCountY, floorCountSize.width, floorCountSize.height);
    
    //content view H
    CGFloat contentH = CGRectGetMaxY(self.forumFrame) + padding;
    self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    
    //cell heigh
    self.cellHeigh = CGRectGetMaxY(self.contentFrame);
    
}

@end
