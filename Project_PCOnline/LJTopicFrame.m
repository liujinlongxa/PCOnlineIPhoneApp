//
//  LJTopicFrame.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJTopicFrame.h"
#import "NSString+MyString.h"

@implementation LJTopicFrame

+ (instancetype)topicFrameWithTopic:(LJBaseTopic *)topic
{
    assert([topic isKindOfClass:[LJTopic class]]);
    LJTopicFrame * topicFrame = [[self alloc] init];
    topicFrame.topic = topic;
    return topicFrame;
}

- (void)setTopic:(LJBaseTopic *)topic
{
    [super setTopic:topic];
    
    assert([topic isKindOfClass:[LJTopic class]]);
    LJTopic * normalTopic  = (LJTopic *)topic;
    CGFloat padding = 10;
    
    //content view frame
    CGFloat contentX = padding;
    CGFloat contentY = padding;
    CGFloat contentW = kScrW - 2 * padding;
    
    //time frame
    CGFloat timeX = self.titleFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.messageFrame) + padding;
    CGSize timeSize = [normalTopic.createAtStr sizeOfStringInIOS7WithFont:TopicForumFont andMaxSize:CGSizeMake(130, 20)];
    self.forumOrTimeFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    //floorCount frame
    CGFloat floorCountX = 130 + padding;
    CGFloat floorCountY = timeY;
    NSString * floorCountStr = [NSString stringWithFormat:@"%d楼/%d阅", normalTopic.replyCount.integerValue, normalTopic.view.integerValue];
    CGSize floorCountSize = [floorCountStr sizeOfStringInIOS7WithFont:TopicFloorCountFont andMaxSize:CGSizeMake(150, 20)];
    self.floorCountFrame = CGRectMake(floorCountX, floorCountY, floorCountSize.width, floorCountSize.height);
    
    //essence frame
    CGSize essenceSize = [@"精华" sizeOfStringInIOS7WithFont:TopicFloorCountFont andMaxSize:CGSizeMake(50, 20)];
    CGFloat essenceX = contentW - padding - essenceSize.width - 5;
    CGFloat essenceY = floorCountY;
    self.essenceFrame = CGRectMake(essenceX, essenceY, essenceSize.width + 5, essenceSize.height + 2);
    
    //content view H
    CGFloat contentH = CGRectGetMaxY(self.forumOrTimeFrame) + padding;
    self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    
    //cell heigh
    self.cellHeigh = CGRectGetMaxY(self.contentFrame);
    
}

@end
