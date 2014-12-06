//
//  LJBaseTopicFrame.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseTopicFrame.h"
#import "NSString+MyString.h"
@implementation LJBaseTopicFrame

- (void)setTopic:(LJBaseTopic *)topic
{
    _topic = topic;
    
    CGFloat padding = 10;
    
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
    
}


@end
